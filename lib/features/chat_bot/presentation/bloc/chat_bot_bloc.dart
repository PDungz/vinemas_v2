import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vinemas_v1/core/service/injection_container.dart';
import 'package:vinemas_v1/core/service/logger_service.dart';
import 'package:vinemas_v1/core/utils/format_datetime.dart';
import 'package:vinemas_v1/features/about_sessions/domain/entity/session/cinema.dart';
import 'package:vinemas_v1/features/about_sessions/domain/entity/session/session_movie.dart';
import 'package:vinemas_v1/features/about_sessions/domain/use_case/about/movie_detail_use_case.dart';
import 'package:vinemas_v1/features/about_sessions/domain/use_case/session/session_use_case.dart';
import 'package:vinemas_v1/features/chat_bot/domain/enum/message_chat_enum.dart';
import 'package:vinemas_v1/l10n/generated/app_localizations.dart';

part 'chat_bot_event.dart';
part 'chat_bot_state.dart';

class ChatBotBloc extends Bloc<ChatBotEvent, ChatBotState> {
  final Gemini gemini;

  ChatBotBloc({required this.gemini}) : super(ChatBotInitial()) {
    on<SendMessageEvent>(_onSendMessage);
    on<SendMediaMessageEvent>(_onSendMediaMessage);
  }

  Future<void> _onSendMessage(
      SendMessageEvent event, Emitter<ChatBotState> emit) async {
    // Thêm tin nhắn của người dùng
    List<ChatMessage> updatedMessages = List.from(state.messages)
      ..insert(0, event.message);

    // Thêm tin nhắn "Gemini đang phản hồi..."
    final loadingMessage = ChatMessage(
      text: event.messageLoading ?? '...',
      user: event.geminiUser,
      createdAt: DateTime.now(),
    );

    updatedMessages.insert(0, loadingMessage);
    emit(ChatBotLoaded(messages: updatedMessages, isShowQuickReply: false));

    try {
      final cinemas = await _fetchCinemas();
      final sessionMovies = await _fetchSessionMovies();
      final chatHistory =
          await _buildChatHistory(event, cinemas, sessionMovies);

      String fullResponse = '';

      await for (var response in gemini.streamChat(chatHistory)) {
        if (response.output != null) {
          fullResponse += response.output ?? ''; // Ghép câu trả lời lại
        }
      }

      if (fullResponse.isNotEmpty) {
        // Cập nhật tin nhắn loading thành tin nhắn hoàn chỉnh
        List<ChatMessage> newMessages = List.from(state.messages)
          ..removeWhere((msg) => msg.text == (event.messageLoading ?? '...'))
          ..insert(
            0,
            ChatMessage(
              text: fullResponse.replaceAll('*', ''),
              user: event.geminiUser,
              createdAt: DateTime.now(),
            ),
          );
        emit(ChatBotLoaded(messages: newMessages, isShowQuickReply: false));
      }
    } catch (e) {
      emit(ChatBotError(errorMessage: "Lỗi không xác định: $e"));
    }
  }

  Future<List<Cinema>> _fetchCinemas() async {
    List<Cinema>? cinemas;
    await getIt<SessionUseCase>().getCinema(
      onPressed: ({required cinema, required message, required status}) {
        cinemas = cinema ?? [];
      },
    );
    return cinemas ?? [];
  }

  Future<List<SessionMovie>> _fetchSessionMovies() async {
    List<SessionMovie>? sessionMovies;
    await getIt<SessionUseCase>().getSessionMovie(
      onPressed: ({required message, required sessionMovie, required status}) {
        sessionMovies = sessionMovie ?? [];
      },
    );
    return sessionMovies ?? [];
  }

  Future<List<Map<String, dynamic>>> _fetchSessionMovieData(
      List<Cinema> cinemas, List<SessionMovie> sessionMovies) async {
    DateTime today = DateTime.now();
    DateTime todayOnly = DateTime(today.year, today.month, today.day);

    return await Future.wait(
      sessionMovies
          .where((session) =>
              session.endDate.year == todayOnly.year &&
              session.endDate.month == todayOnly.month &&
              session.endDate.day == todayOnly.day)
          .map((session) async {
        try {
          final cinema = cinemas
              .firstWhere((element) => element.cinemaId == session.cinemaId);

          final movieDetail = await getIt<MovieDetailUseCase>()
              .getMovieDetail(movieId: session.movieId);

          return {
            'nameCinema': cinema.nameCinema,
            'addressCinema': cinema.address,
            'movieName': movieDetail?.title ?? "Unknown",
            'genre':
                movieDetail?.genres.map((genre) => genre.name).join(', ') ??
                    "Unknown",
            'runtime': movieDetail?.runtime ?? "Unknown",
            'releaseDate': movieDetail?.releaseDate ?? "Unknown",
            'startDate': FormatDateTime.formatWithTime(session.startDate),
            'endDate': FormatDateTime.formatWithTime(session.endDate),
            'toDay': '${DateTime.now()}'
          };
        } catch (e) {
          printE("Error processing session: $e");
          return {};
        }
      }),
    );
  }

  Future<List<Content>> _buildChatHistory(SendMessageEvent event,
      List<Cinema> cinemas, List<SessionMovie> sessionMovies) async {
    List<Content> chatHistory = [];
    String selectedLanguage = event.context != null
        ? AppLocalizations.of(event.context!)!.keyword_locale
        : "en";
    String searchImage = AppLocalizations.of(event.context!)!
        .keyword_chatbot_movie_info_by_image;

    if (event.message.medias != null && event.message.medias!.isNotEmpty) {
      File imageFile = File(event.message.medias!.first.url);
      final imageBytes = await imageFile.readAsBytes();
      final sessionMovieData =
          await _fetchSessionMovieData(cinemas, sessionMovies);
      String jsonResult = jsonEncode(sessionMovieData);
      chatHistory.add(
        Content(role: "user", parts: [
          Part.text("Language: $selectedLanguage"),
          Part.text("Question: $searchImage"),
          Part.text(
              "Find the nearest showtime and cinema for this movie: $jsonResult"),
          Part.uint8List(imageBytes),
        ]),
      );
    } else {
      if (event.messageChatEnum == MessageChatEnum.system) {
        String extraInfo = "";
        if (event.messageChatSystemEnum ==
            MessageChatSystemEnum.paymentMethods) {
          extraInfo = "Payment Method: Card, VNPay, Momo, cod";
        } else if (event.messageChatSystemEnum ==
            MessageChatSystemEnum.showtimesToday) {
          final sessionMovieData =
              await _fetchSessionMovieData(cinemas, sessionMovies);
          String jsonResult = jsonEncode(sessionMovieData);
          extraInfo = "Show times today: $jsonResult";
        } else if (event.messageChatSystemEnum ==
            MessageChatSystemEnum.nearestCinema) {
          final sessionMovieData =
              await _fetchSessionMovieData(cinemas, sessionMovies);
          String jsonResult = jsonEncode(sessionMovieData);
          extraInfo = "Nearest Cinema: $jsonResult";
        }

        chatHistory.add(
          Content(role: "user", parts: [
            Part.text("Language: $selectedLanguage"),
            Part.text(extraInfo),
            Part.text(event.message.text),
          ]),
        );
      } else {
        chatHistory.add(
          Content(role: "user", parts: [
            Part.text("Language: $selectedLanguage"),
            Part.text(event.message.text),
          ]),
        );
      }
    }
    return chatHistory;
  }

  Future<void> _onSendMediaMessage(
      SendMediaMessageEvent event, Emitter<ChatBotState> emit) async {
    ImagePicker picker = ImagePicker();
    XFile? file = await picker.pickImage(source: ImageSource.gallery);

    if (file != null) {
      final imageMessage = ChatMessage(
        user: event.currentUser,
        createdAt: DateTime.now(),
        medias: [
          ChatMedia(
            url: file.path,
            fileName: file.name,
            type: MediaType.image,
          ),
        ],
      );
      add(SendMessageEvent(
          message: imageMessage,
          context: event.context,
          geminiUser: event.geminiUser,
          messageChatEnum: event.messageChatEnum,
          messageLoading: event.messageLoading));
    }
  }
}

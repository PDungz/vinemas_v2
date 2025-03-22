import 'package:bloc/bloc.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:image_picker/image_picker.dart';
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
    List<ChatMessage> updatedMessages = List.from(state.messages)
      ..insert(0, event.message);
    emit(ChatBotLoaded(messages: updatedMessages, isShowQuickReply: false));

    try {
      List<Content> chatHistory = [];
      String selectedLanguage = event.context != null
          ? AppLocalizations.of(event.context!)!.keyword_locale
          : "en";

      chatHistory.add(
        Content(
          role: "user",
          parts: [
            Part.text("Ngôn ngữ: $selectedLanguage"),
            Part.text(event.message.text),
          ],
        ),
      );

      gemini.streamChat(chatHistory).listen(
        (response) {
          if (response.output != null) {
            final botMessage = ChatMessage(
              text: response.output!,
              user: event.geminiUser,
              createdAt: DateTime.now(),
            );
            List<ChatMessage> newMessages = List.from(state.messages)
              ..insert(0, botMessage);
            emit(ChatBotLoaded(messages: newMessages, isShowQuickReply: false));
          }
        },
        onError: (error) {
          emit(ChatBotError(errorMessage: "Lỗi khi gửi tin nhắn: $error"));
        },
      );
    } catch (e) {
      emit(ChatBotError(errorMessage: "Lỗi không xác định: $e"));
    }
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
          geminiUser: event.geminiUser));
    }
  }
}

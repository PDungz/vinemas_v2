import 'dart:io';

import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:packages/widget/Layout/custom_layout.dart';
import 'package:vinemas_v1/core/config/app_color.dart';
import 'package:vinemas_v1/core/theme/theme_app.dart';
import 'package:vinemas_v1/features/chat_bot/domain/enum/message_chat_enum.dart';
import 'package:vinemas_v1/features/chat_bot/presentation/bloc/chat_bot_bloc.dart';
import 'package:vinemas_v1/features/chat_bot/presentation/widget/chat_bot_app_bar_widget.dart';
import 'package:vinemas_v1/features/chat_bot/presentation/widget/chat_bot_quick_replay_widget.dart';
import 'package:vinemas_v1/gen/assets.gen.dart';
import 'package:vinemas_v1/l10n/generated/app_localizations.dart';

class ChatBot extends StatelessWidget {
  const ChatBot({super.key});

  @override
  Widget build(BuildContext context) {
    final ChatUser currentUser = ChatUser(id: '0', firstName: 'User');
    final ChatUser geminiUser = ChatUser(
      id: '1',
      firstName: 'Gemini',
      profileImage:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTWKREuKJr5m61_eqF9gwmkVwUTGWZABbD-Vg&s',
    );

    return BlocProvider(
      create: (context) => ChatBotBloc(gemini: Gemini.instance),
      child: BlocBuilder<ChatBotBloc, ChatBotState>(
        builder: (context, state) {
          return CustomLayout(
            appBar: ChatBotAppBarWidget(),
            body: Padding(
              padding: const EdgeInsets.only(
                  top: 20, bottom: 8.0, left: 8.0, right: 2.0),
              child: Stack(
                children: [
                  DashChat(
                    currentUser: currentUser,
                    onSend: (message) {
                      BlocProvider.of<ChatBotBloc>(context).add(
                        SendMessageEvent(
                          message: message,
                          context: context,
                          geminiUser: geminiUser,
                          messageLoading: AppLocalizations.of(context)!
                              .keyword_chatbot_typing,
                        ),
                      );
                    },
                    messages: state.messages,
                    inputOptions: InputOptions(
                      inputDecoration: InputDecoration(
                        enabledBorder: ThemeApp.outlineInputTheme(
                          AppColor.buttonLinerTwoColor,
                        ).enabledBorder,
                        focusedBorder: ThemeApp.outlineInputTheme(
                          AppColor.buttonLinerTwoColor,
                        ).focusedBorder,
                        hintText: AppLocalizations.of(context)!
                            .keyword_chatbot_input_placeholder,
                        hintStyle: TextStyle(
                          color: AppColor.secondaryTextColor.withOpacity(0.7),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                      ),
                      inputTextStyle:
                          TextStyle(color: AppColor.buttonLinerOneColor),
                      trailing: [
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 10.0, right: 4.0),
                          child: GestureDetector(
                            onTap: () {
                              BlocProvider.of<ChatBotBloc>(context).add(
                                SendMediaMessageEvent(
                                  currentUser: currentUser,
                                  context: context,
                                  geminiUser: geminiUser,
                                  messageLoading: AppLocalizations.of(context)!
                                      .keyword_chatbot_typing,
                                  messageChatEnum: MessageChatEnum.image,
                                ),
                              );
                            },
                            child: SvgPicture.asset(
                              $AssetsIconsGen().iconApp.image,
                              height: 28.0,
                            ),
                          ),
                        )
                      ],
                    ),
                    messageOptions: MessageOptions(
                      avatarBuilder: (p0, onPressAvatar, onLongPressAvatar) =>
                          Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: NetworkImage(geminiUser.profileImage!),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      messageMediaBuilder:
                          (message, previousMessage, nextMessage) {
                        if (message.medias != null &&
                            message.medias!.isNotEmpty) {
                          ChatMedia media = message.medias!.first;

                          if (media.type == MediaType.image) {
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.file(
                                File(media.url),
                                width: 180,
                                fit: BoxFit.cover,
                              ),
                            );
                          }
                        }
                        return const SizedBox();
                      },
                    ),
                  ),
                  ChatBotQuickReplayWidget(
                    isShowQuickReply: state.isShowQuickReply,
                    quickReplies: {
                      AppLocalizations.of(context)!
                              .keyword_chatbot_suggestion_showtimes_today:
                          MessageChatSystemEnum.showtimesToday,
                      AppLocalizations.of(context)!
                              .keyword_chatbot_suggestion_nearest_cinema:
                          MessageChatSystemEnum.nearestCinema,
                      // AppLocalizations.of(context)!
                      //         .keyword_chatbot_suggestion_ticket_price_promo:
                      //     MessageChatSystemEnum.ticketPricePromo,
                      // AppLocalizations.of(context)!
                      //         .keyword_chatbot_suggestion_fast_booking:
                      //     MessageChatSystemEnum.fastBooking,
                      AppLocalizations.of(context)!
                              .keyword_chatbot_suggestion_payment_methods:
                          MessageChatSystemEnum.paymentMethods,
                    },
                    onQuickReplySelected: (message, messageChatSystemEnum) {
                      BlocProvider.of<ChatBotBloc>(context).add(
                        SendMessageEvent(
                          message: message,
                          context: context,
                          messageChatEnum: MessageChatEnum.system,
                          messageChatSystemEnum: messageChatSystemEnum,
                          geminiUser: geminiUser,
                          messageLoading: AppLocalizations.of(context)!
                              .keyword_chatbot_typing,
                        ),
                      );
                    },
                    currentUser: currentUser,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

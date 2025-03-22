// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'chat_bot_bloc.dart';

abstract class ChatBotEvent {}

class SendMessageEvent extends ChatBotEvent {
  final ChatMessage message;
  final BuildContext? context;
  final ChatUser geminiUser;
  final MessageChatEnum messageChatEnum;
  final MessageChatSystemEnum? messageChatSystemEnum;
  final String? messageLoading;

  SendMessageEvent({
    required this.message,
    this.context,
    required this.geminiUser,
    this.messageChatEnum = MessageChatEnum.text,
    this.messageChatSystemEnum,
    this.messageLoading,
  });

  SendMessageEvent copyWith({
    ChatMessage? message,
    BuildContext? context,
    ChatUser? geminiUser,
    MessageChatEnum? messageChatEnum,
    MessageChatSystemEnum? messageChatSystemEnum,
    String? messageLoading,
  }) {
    return SendMessageEvent(
      message: message ?? this.message,
      context: context ?? this.context,
      geminiUser: geminiUser ?? this.geminiUser,
      messageChatEnum: messageChatEnum ?? this.messageChatEnum,
      messageChatSystemEnum:
          messageChatSystemEnum ?? this.messageChatSystemEnum,
      messageLoading: messageLoading ?? this.messageLoading,
    );
  }
}

class SendMediaMessageEvent extends ChatBotEvent {
  final ChatUser currentUser;
  final BuildContext? context;
  final ChatUser geminiUser;
  final String? messageLoading;

  SendMediaMessageEvent({
    required this.currentUser,
    this.context,
    required this.geminiUser,
    this.messageLoading,
  });

  SendMediaMessageEvent copyWith({
    ChatUser? currentUser,
    BuildContext? context,
    ChatUser? geminiUser,
    String? messageLoading,
  }) {
    return SendMediaMessageEvent(
      currentUser: currentUser ?? this.currentUser,
      context: context ?? this.context,
      geminiUser: geminiUser ?? this.geminiUser,
      messageLoading: messageLoading ?? this.messageLoading,
    );
  }
}

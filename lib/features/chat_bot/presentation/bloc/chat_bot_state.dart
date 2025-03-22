part of 'chat_bot_bloc.dart';

abstract class ChatBotState {
  final List<ChatMessage> messages;
  final bool isShowQuickReply;

  ChatBotState({required this.messages, required this.isShowQuickReply});
}

class ChatBotInitial extends ChatBotState {
  ChatBotInitial() : super(messages: [], isShowQuickReply: true);
}

class ChatBotLoaded extends ChatBotState {
  ChatBotLoaded({required super.messages, required super.isShowQuickReply});
}

class ChatBotError extends ChatBotState {
  final String errorMessage;

  ChatBotError({required this.errorMessage})
      : super(messages: [], isShowQuickReply: true);
}

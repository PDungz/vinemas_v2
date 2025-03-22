part of 'chat_bot_bloc.dart';

abstract class ChatBotEvent {}

class SendMessageEvent extends ChatBotEvent {
  final ChatMessage message;
  final BuildContext? context;
  final ChatUser geminiUser;

  SendMessageEvent(
      {required this.message, this.context, required this.geminiUser});
}

class SendMediaMessageEvent extends ChatBotEvent {
  final ChatUser currentUser;
  final BuildContext? context;
  final ChatUser geminiUser;

  SendMediaMessageEvent(
      {required this.currentUser, this.context, required this.geminiUser});
}

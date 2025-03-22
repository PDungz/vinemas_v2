
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:vinemas_v1/core/config/app_color.dart';

class ChatBotQuickReplayWidget extends StatefulWidget {
  const ChatBotQuickReplayWidget(
      {super.key,
      required this.quickReplies,
      required this.onQuickReplySelected,
      required this.currentUser,
      this.onQuickReplySelectedCallback,
      required this.isShowQuickReply});
  final List<String> quickReplies;
  final Function(ChatMessage) onQuickReplySelected;
  final ChatUser currentUser;
  final bool isShowQuickReply;
  final VoidCallback? onQuickReplySelectedCallback;

  @override
  State<ChatBotQuickReplayWidget> createState() => _ChatBotQuickReplayWidgetState();
}

class _ChatBotQuickReplayWidgetState extends State<ChatBotQuickReplayWidget> {
  @override
  Widget build(BuildContext context) {
    return widget.isShowQuickReply
        ? Positioned(
            top: 80,
            left: 8,
            child: SizedBox(
              width: 250,
              child: Card(
                color: AppColor.secondaryColor,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Column(
                        children: widget.quickReplies.map((text) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 2.0),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColor.primaryColor,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 10),
                                minimumSize: const Size(double.infinity, 40),
                              ),
                              onPressed: () {
                                widget.onQuickReplySelected(ChatMessage(
                                  text: text,
                                  user: widget.currentUser,
                                  createdAt: DateTime.now(),
                                ));
                                widget.onQuickReplySelectedCallback;
                              },
                              child: Text(
                                text,
                                style: Theme.of(context).textTheme.labelLarge,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        : SizedBox();
  }
}

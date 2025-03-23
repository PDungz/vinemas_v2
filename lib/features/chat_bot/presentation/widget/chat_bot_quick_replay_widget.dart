import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vinemas_v1/core/config/app_color.dart';
import 'package:vinemas_v1/features/chat_bot/domain/enum/message_chat_enum.dart';
import 'package:vinemas_v1/gen/assets.gen.dart';

class ChatBotQuickReplayWidget extends StatefulWidget {
  const ChatBotQuickReplayWidget({
    super.key,
    required this.quickReplies,
    required this.onQuickReplySelected,
    required this.currentUser,
    this.onQuickReplySelectedCallback,
    required this.isShowQuickReply,
  });

  final Map<String, MessageChatSystemEnum> quickReplies;
  final Function(ChatMessage, MessageChatSystemEnum) onQuickReplySelected;
  final ChatUser currentUser;
  final bool isShowQuickReply;
  final VoidCallback? onQuickReplySelectedCallback;

  @override
  State<ChatBotQuickReplayWidget> createState() =>
      _ChatBotQuickReplayWidgetState();
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
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Column(
                        children: widget.quickReplies.entries.map((entry) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 2.0, horizontal: 8.0),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColor.primaryColor,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 10),
                                minimumSize: const Size(double.infinity, 40),
                              ),
                              onPressed: () {
                                widget.onQuickReplySelected(
                                  ChatMessage(
                                    text: entry.key,
                                    user: widget.currentUser,
                                    createdAt: DateTime.now(),
                                  ),
                                  entry.value,
                                );
                                widget.onQuickReplySelectedCallback?.call();
                              },
                              child: Text(
                                entry.key,
                                style: Theme.of(context).textTheme.labelLarge,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 8),
                      SvgPicture.asset($AssetsSvgGen().appIcon, height: 42),
                      const SizedBox(height: 8),
                      Text(
                        "Vinemas",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 8),
                    ],
                  ),
                ),
              ),
            ),
          )
        : const SizedBox();
  }
}

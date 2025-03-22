import 'dart:io';

import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:packages/widget/Layout/custom_layout.dart';
import 'package:vinemas_v1/core/config/app_color.dart';
import 'package:vinemas_v1/core/theme/theme_app.dart';
import 'package:vinemas_v1/features/chat_bot/presentation/widget/chat_bot_app_bar_widget.dart';
import 'package:vinemas_v1/features/chat_bot/presentation/widget/chat_bot_quick_replay_widget.dart';
import 'package:vinemas_v1/gen/assets.gen.dart';
import 'package:vinemas_v1/l10n/generated/app_localizations.dart';

class ChatBot extends StatefulWidget {
  const ChatBot({super.key});

  @override
  State<ChatBot> createState() => _ChatBotState();
}

class _ChatBotState extends State<ChatBot> {
  late Gemini gemini;
  late ChatUser currentUser;
  late ChatUser geminiUser;
  List<ChatMessage> messages = [];
  final List<String> quickReplies = [
    "Lịch chiếu hôm nay?",
    "Rạp gần nhất?",
    "Giá vé & khuyến mãi?",
    "Cách đặt vé nhanh?",
    "Phương thức thanh toán?",
  ];
  bool isShowQuickReply = true;

  @override
  void initState() {
    super.initState();
    gemini = Gemini.instance;
    currentUser = ChatUser(id: '0', firstName: 'User');
    geminiUser = ChatUser(
      id: '1',
      firstName: 'Gemini',
      profileImage:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTWKREuKJr5m61_eqF9gwmkVwUTGWZABbD-Vg&s',
    );
  }

  void sendMessage(ChatMessage chatMessage) async {
    setState(() {
      isShowQuickReply = false;
      messages.insert(0, chatMessage);
    });

    try {
      // Thêm ngôn ngữ nhưng không hiển thị lên giao diện chat
      String selectedLanguage = AppLocalizations.of(context)!.keyword_locale;
      List<Content> chatHistory = [];

      if (chatMessage.medias != null && chatMessage.medias!.isNotEmpty) {
        File imageFile = File(chatMessage.medias!.first.url);

        // Đọc file ảnh dưới dạng bytes
        final imageBytes = await imageFile.readAsBytes();

        chatHistory.add(
          Content(
            role: "user",
            parts: [
              Part.text("Ngôn ngữ: $selectedLanguage"),
              Part.uint8List(imageBytes),
            ],
          ),
        );
      } else {
        chatHistory.add(
          Content(role: "user", parts: [
            Part.text("Ngôn ngữ: $selectedLanguage"),
            Part.text(chatMessage.text),
          ]),
        );
      }

      gemini.streamChat(chatHistory).listen(
        (response) {
          if (response.output != null) {
            final botMessage = ChatMessage(
              text: response.output!,
              user: geminiUser,
              createdAt: DateTime.now(),
            );

            setState(() {
              messages.insert(0, botMessage);
            });
          }
        },
        onError: (error) {
          debugPrint('Lỗi khi gửi tin nhắn: $error');
        },
      );
    } catch (e) {
      debugPrint('Lỗi không xác định: $e');
    }
  }

  void _sendMessageMedia() async {
    setState(() {
      isShowQuickReply = false;
    });
    ImagePicker picker = ImagePicker();
    XFile? file = await picker.pickImage(source: ImageSource.gallery);

    if (file != null) {
      final imageMessage = ChatMessage(
        user: currentUser,
        createdAt: DateTime.now(),
        medias: [
          ChatMedia(
            url: file.path, // Đường dẫn ảnh
            fileName: file.name,
            type: MediaType.image,
          ),
        ],
      );

      sendMessage(imageMessage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomLayout(
      appBar: ChatBotAppBarWidget(),
      body: Padding(
        padding:
            const EdgeInsets.only(top: 20, bottom: 8.0, left: 8.0, right: 2.0),
        child: Stack(
          children: [
            DashChat(
              currentUser: currentUser,
              onSend: sendMessage,
              messages: messages,
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
                      padding: const EdgeInsets.only(left: 10.0, right: 4.0),
                      child: GestureDetector(
                        onTap: _sendMessageMedia,
                        child: SvgPicture.asset(
                          $AssetsIconsGen().iconApp.image,
                          height: 28.0,
                        ),
                      ),
                    )
                  ]),
              messageOptions: MessageOptions(
                avatarBuilder: (p0, onPressAvatar, onLongPressAvatar) =>
                    Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: NetworkImage(geminiUser.profileImage!),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                messageMediaBuilder: (message, previousMessage, nextMessage) {
                  if (message.medias != null && message.medias!.isNotEmpty) {
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
              isShowQuickReply: isShowQuickReply,
              quickReplies: quickReplies,
              onQuickReplySelected: sendMessage,
              currentUser: currentUser,
              onQuickReplySelectedCallback: () => setState(() {
                isShowQuickReply = false;
              }),
            )
          ],
        ),
      ),
    );
  }
}

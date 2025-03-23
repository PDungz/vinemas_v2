import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:packages/widget/App_bar/custom_app_bar.dart';
import 'package:packages/widget/Button/custom_icon_button.dart';
import 'package:vinemas_v1/gen/assets.gen.dart';
import 'package:vinemas_v1/l10n/generated/app_localizations.dart';

class ChatBotAppBarWidget extends StatelessWidget {
  const ChatBotAppBarWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomAppBar(
      leading: CustomIconButton(
        svgPathUp: $AssetsIconsGen().iconApp.back,
        onPressed: () => Get.back(),
        elevation: 0,
      ),
      title: Padding(
        padding: EdgeInsets.only(top: 12.0, bottom: 12.0, right: 36),
        child: Text(AppLocalizations.of(context)!.keyword_chatbot_appbar_title,
            overflow: TextOverflow.ellipsis,
            style:
                Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 18)),
      ),
    );
  }
}

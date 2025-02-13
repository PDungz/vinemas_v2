import 'package:flutter/material.dart';
import 'package:vinemas_v1/core/config/app_color.dart';
import 'package:vinemas_v1/features/login/presentation/widget/social_network_widget.dart';
import 'package:vinemas_v1/gen/assets.gen.dart';
import 'package:vinemas_v1/l10n/generated/app_localizations.dart';

class OtherSignInWidget extends StatelessWidget {
  final Function() onGoogle;
  final Function() onFacebook;

  const OtherSignInWidget(
      {super.key, required this.onGoogle, required this.onFacebook});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 12, bottom: 16),
          child: Text(
            AppLocalizations.of(context)!.keyword_or_sign_in_with,
            style: Theme.of(context)
                .textTheme
                .labelLarge
                ?.copyWith(color: AppColor.secondaryTextColor),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SocialNetworkWidget(
                onTap: onGoogle,
                socialNetworkWidget:
                    $AssetsImagesSocialNetworkGen().google.path,
                title: "Google"),
            SizedBox(width: 24),
            SocialNetworkWidget(
                onTap: onFacebook,
                socialNetworkWidget:
                    $AssetsImagesSocialNetworkGen().facebook.path,
                title: "Facebook"),
          ],
        )
      ],
    );
  }
}

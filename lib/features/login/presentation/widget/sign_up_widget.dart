import 'package:flutter/material.dart';
import 'package:vinemas_v1/core/config/app_color.dart';
import 'package:vinemas_v1/l10n/generated/app_localizations.dart';

class SignUpWidget extends StatelessWidget {
  const SignUpWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12, bottom: 36),
      child: Align(
        alignment: Alignment.center,
        child: GestureDetector(
          onTap: () {},
          child: Text.rich(
            TextSpan(
              text: AppLocalizations.of(context)!.keyword_no_account,
              children: [
                WidgetSpan(child: SizedBox(width: 8)),
                TextSpan(
                  text: AppLocalizations.of(context)!.keyword_sign_up,
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall
                      ?.copyWith(color: AppColor.buttonLinerOneColor),
                ),
              ],
              style: Theme.of(context)
                  .textTheme
                  .titleSmall
                  ?.copyWith(color: AppColor.secondaryTextColor),
            ),
          ),
        ),
      ),
    );
  }
}

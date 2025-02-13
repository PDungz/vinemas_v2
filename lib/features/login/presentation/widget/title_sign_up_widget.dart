import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:packages/widget/Shadow/custom_shadow.dart';
import 'package:vinemas_v1/core/config/app_color.dart';
import 'package:vinemas_v1/gen/assets.gen.dart';
import 'package:vinemas_v1/l10n/generated/app_localizations.dart';

class TitleSignUpWidget extends StatelessWidget {
  const TitleSignUpWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 60),
      child: CustomShadow(
        blurRadius: 36,
        borderRadius: 12,
        shadowColor: AppColor.buttonLinerOneColor.withOpacity(0.16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              child: SvgPicture.asset(
                $AssetsSvgGen().logo,
              ),
            ),
            SizedBox(width: 12),
            Text(
              AppLocalizations.of(context)!.keyword_sign_up,
              style: Theme.of(context).textTheme.displaySmall,
            ),
          ],
        ),
      ),
    );
  }
}

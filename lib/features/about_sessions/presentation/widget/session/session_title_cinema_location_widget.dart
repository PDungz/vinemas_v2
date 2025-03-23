import 'package:flutter/material.dart';
import 'package:packages/widget/Button/custom_button.dart';
import 'package:packages/widget/Layout/custom_layout_horizontal.dart';
import 'package:vinemas_v1/gen/assets.gen.dart';
import 'package:vinemas_v1/l10n/generated/app_localizations.dart';

class SessionTitleCinemaLocationWidget extends StatelessWidget {
  const SessionTitleCinemaLocationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomLayoutHorizontal(
        verticalPadding: 0,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        leftWidget: Text(AppLocalizations.of(context)!.keyword_recommended,
            style: Theme.of(context).textTheme.titleLarge),
        rightWidget: CustomButton(
          useMinSize: false,
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          isOutlined: true,
          svgAsset: $AssetsIconsGen().iconApp.locationCrosshairs,
          iconSize: 16,
          label: 'Ha noi',
          onPressed: () {},
        ));
  }
}

import 'package:flutter/material.dart';
import 'package:packages/widget/Bottom_sheet/custom_bottom_sheet.dart';
import 'package:packages/widget/Button/custom_icon_button.dart';
import 'package:vinemas_v1/gen/assets.gen.dart';

class SearchNowPlayingWidget extends StatelessWidget {
  const SearchNowPlayingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomIconButton(
      elevation: 0,
      verticalPadding: 2,
      svgPath: $AssetsIconsGen().iconApp.search,
      onPressed: () {
        CustomBottomSheet.show(context, minHeight: 0.68, body: Container());
      },
    );
  }
}

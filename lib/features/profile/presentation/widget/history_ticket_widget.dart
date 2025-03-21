import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:packages/widget/Layout/custom_layout_horizontal.dart';
import 'package:vinemas_v1/core/config/app_color.dart';
import 'package:vinemas_v1/core/config/app_router.dart';
import 'package:vinemas_v1/gen/assets.gen.dart';
import 'package:vinemas_v1/l10n/generated/app_localizations.dart';

class HistoryTicketWidget extends StatelessWidget {
  const HistoryTicketWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomLayoutHorizontal(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      horizontalPadding: 0,
      leftWidget: Text(
        AppLocalizations.of(context)!.keyword_ticket,
        style: Theme.of(context)
            .textTheme
            .titleMedium
            ?.copyWith(color: AppColor.secondaryTextColor),
      ),
      rightWidget: GestureDetector(
        onTap: () => Get.toNamed(ConfigRoute.ticketPage),
        child: SvgPicture.asset(
          $AssetsIconsGen().iconApp.ticket,
          height: 32,
        ),
      ),
    );
  }
}

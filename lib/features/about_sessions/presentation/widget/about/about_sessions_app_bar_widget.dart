import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:packages/widget/App_bar/custom_app_bar.dart';
import 'package:packages/widget/Button/custom_icon_button.dart';
import 'package:packages/widget/Tab_label/custom_tab_label.dart';
import 'package:vinemas_v1/core/config/app_color.dart';
import 'package:vinemas_v1/core/config/app_router.dart';
import 'package:vinemas_v1/features/home/domain/entity/movie.dart';
import 'package:vinemas_v1/gen/assets.gen.dart';
import 'package:vinemas_v1/l10n/generated/app_localizations.dart';

class AboutSessionsAppBarWidget extends StatelessWidget {
  const AboutSessionsAppBarWidget(
      {super.key,
      required this.parameter,
      required this.selectedTabIndex,
      required this.pageController,
      required this.onTabSelected});
  final Movie parameter;
  final int selectedTabIndex;
  final PageController pageController;
  final Function(int index) onTabSelected;

  @override
  Widget build(BuildContext context) {
    return CustomAppBar(
      leading: GestureDetector(
        onTap: () => Get.back(),
        child: SvgPicture.asset($AssetsIconsGen().iconApp.back),
      ),
      title: Padding(
        padding: const EdgeInsets.only(left: 16, bottom: 2.0),
        child: Text(
          parameter.title,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 18),
        ),
      ),
      actions: [
        CustomIconButton(
            elevation: 0,
            svgPathUp: $AssetsIconsGen().iconApp.ticket,
            horizontalPadding: 4,
            onPressed: () {
              Get.toNamed(ConfigRoute.ticketPage);
            })
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(36),
        child: CustomTabLabel(
          labels: [
            AppLocalizations.of(context)!.keyword_about,
            AppLocalizations.of(context)!.keyword_sessions,
          ],
          selectedColor: AppColor.buttonLinerOneColor,
          selectedTextStyle: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(color: AppColor.buttonLinerOneColor),
          unselectedTextStyle: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(color: AppColor.secondaryTextColor),
          selectedIndex: selectedTabIndex,
          onTap: onTabSelected,
        ),
      ),
    );
  }
}

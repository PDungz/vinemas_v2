import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:packages/widget/App_bar/custom_app_bar.dart';
import 'package:packages/widget/Button/custom_icon_button.dart';
import 'package:packages/widget/Layout/custom_layout_horizontal.dart';
import 'package:vinemas_v1/core/config/app_color.dart';
import 'package:vinemas_v1/core/utils/format_datetime.dart';
import 'package:vinemas_v1/features/about_sessions/domain/entity/session/session_movie.dart';
import 'package:vinemas_v1/features/home/domain/entity/movie.dart';
import 'package:vinemas_v1/gen/assets.gen.dart';

class SeatReservationAppBarWidget extends StatelessWidget {
  const SeatReservationAppBarWidget({
    super.key,
    required this.movie,
    required this.sessionMovie,
  });

  final Movie movie;
  final SessionMovie sessionMovie;

  @override
  Widget build(BuildContext context) {
    return CustomAppBar(
      leading: CustomIconButton(
        svgPathUp: $AssetsIconsGen().iconApp.back,
        onPressed: () => Get.back(),
        elevation: 0,
      ),
      title: Padding(
        padding: EdgeInsets.only(top: 12.0, bottom: 12.0),
        child: Text(movie.title,
            overflow: TextOverflow.ellipsis,
            style:
                Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 18)),
      ),
      actions: [
        CustomIconButton(
            elevation: 0,
            svgPathUp: $AssetsIconsGen().iconApp.enlarge,
            svgPathDown: $AssetsIconsGen().iconApp.compress,
            onPressed: () {})
      ],
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: CustomLayoutHorizontal(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          leftWidget: _buildItemHeader(
              context,
              $AssetsIconsGen().iconApp.calendar,
              FormatDateTime.formatDateShort(sessionMovie.startDate)),
          rightWidget: _buildItemHeader(
                  context,
                  $AssetsIconsGen().iconApp.clock,
                  FormatDateTime.formatToHourMinute(sessionMovie.startDate))
              .paddingOnly(bottom: 8),
        ),
      ),
    );
  }
}

Widget _buildItemHeader(BuildContext context, String iconPath, String value) =>
    IntrinsicWidth(
      child: Container(
        width: 156,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: AppColor.primaryIconColor,
            )),
        child: CustomLayoutHorizontal(
            horizontalPadding: 16,
            spaceWith: 4,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            leftWidget: SvgPicture.asset(iconPath),
            rightWidget:
                Text(value, style: Theme.of(context).textTheme.titleSmall)),
      ),
    );

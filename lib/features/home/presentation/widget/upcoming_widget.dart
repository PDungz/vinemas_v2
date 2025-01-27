import 'package:flutter/material.dart';
import 'package:packages/widget/Carousel/custom_carousel.dart';
import 'package:packages/widget/Layout/custom_layout_horizontal.dart';
import 'package:packages/widget/Layout/custom_layout_vertical.dart';
import 'package:vinemas_v1/core/config/app_color.dart';
import 'package:vinemas_v1/l10n/generated/app_localizations.dart';

class UpcomingWidget extends StatelessWidget {
  const UpcomingWidget({super.key, required this.listUpcommingMoviesPoster});

  final List<String> listUpcommingMoviesPoster;

  @override
  Widget build(BuildContext context) => CustomLayoutVertical(
        verticalPadding: 0,
        horizontalPadding: 0,
        topWidget: CustomLayoutHorizontal(
          crossAxisAlignment: CrossAxisAlignment.center,
          verticalPadding: 0,
          leftWidget: Text(
            AppLocalizations.of(context)!.keyword_upcoming,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          rightWidget: InkWell(
            child: Text(
              AppLocalizations.of(context)!.keyword_view_all,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: AppColor.buttonLinerOneColor,
                  ),
            ),
          ),
        ),
        bottomWidget: CustomCarousel(
          listItem: listUpcommingMoviesPoster,
        ),
      );
}

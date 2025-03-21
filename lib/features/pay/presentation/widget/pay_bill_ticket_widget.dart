import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:packages/Core/config/app_color.dart';
import 'package:packages/widget/Divider/custom_divider.dart';
import 'package:packages/widget/Layout/custom_layout_label_value.dart';
import 'package:vinemas_v1/core/utils/format_datetime.dart';
import 'package:vinemas_v1/features/about_sessions/domain/entity/about/movie_detail.dart';
import 'package:vinemas_v1/features/about_sessions/domain/entity/session/cinema.dart';
import 'package:vinemas_v1/features/about_sessions/domain/entity/session/session_movie.dart';
import 'package:vinemas_v1/l10n/generated/app_localizations.dart';

class PayBillTicketWidget extends StatelessWidget {
  const PayBillTicketWidget({
    super.key,
    required this.movieDetail,
    required this.cinema,
    required this.sessionMovie,
    required this.currentBooked,
    required this.contentPayment,
    required this.isChangeShowTime,
  });

  final MovieDetail movieDetail;
  final Cinema cinema;
  final SessionMovie sessionMovie;
  final List currentBooked;
  final String contentPayment;
  final bool isChangeShowTime;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          movieDetail.title,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        CustomLayoutLabelValue(
            labelWidth: 120,
            padding: EdgeInsets.symmetric(horizontal: 0, vertical: 8),
            widgetLeft: Text(
              AppLocalizations.of(context)!.keyword_cinema,
              style: Theme.of(context)
                  .textTheme
                  .titleSmall
                  ?.copyWith(color: AppColor.secondaryTextColor),
            ),
            widgetRight: Text(cinema.nameCinema)),
        CustomLayoutLabelValue(
            labelWidth: 120,
            padding: EdgeInsets.symmetric(horizontal: 0, vertical: 8),
            widgetLeft: Text(
              AppLocalizations.of(context)!.keyword_date,
              style: Theme.of(context)
                  .textTheme
                  .titleSmall
                  ?.copyWith(color: AppColor.secondaryTextColor),
            ),
            widgetRight: Text(
                "${FormatDateTime.formatToHourMinute(sessionMovie.startDate)} - ${FormatDateTime.formatToReadable(sessionMovie.startDate)}")),
        CustomLayoutLabelValue(
            labelWidth: 120,
            padding: EdgeInsets.symmetric(horizontal: 0, vertical: 8),
            widgetLeft: Text(
              AppLocalizations.of(context)!.keyword_runtime,
              style: Theme.of(context)
                  .textTheme
                  .titleSmall
                  ?.copyWith(color: AppColor.secondaryTextColor),
            ),
            widgetRight: Text(FormatDateTime.convertMinutesToHourMinute(
                movieDetail.runtime))),
        CustomLayoutLabelValue(
            labelWidth: 120,
            padding: EdgeInsets.symmetric(horizontal: 0, vertical: 8),
            widgetLeft: Text(
              AppLocalizations.of(context)!.keyword_seats,
              style: Theme.of(context)
                  .textTheme
                  .titleSmall
                  ?.copyWith(color: AppColor.secondaryTextColor),
            ),
            widgetRight: Text(currentBooked.map((e) => e).toList().join(', '))),
        CustomLayoutLabelValue(
            labelWidth: 120,
            padding: EdgeInsets.symmetric(horizontal: 0, vertical: 8),
            widgetLeft: Text(
              AppLocalizations.of(context)!.keyword_book_at,
              style: Theme.of(context)
                  .textTheme
                  .titleSmall
                  ?.copyWith(color: AppColor.secondaryTextColor),
            ),
            widgetRight: Text(FormatDateTime.formatWithTime(DateTime.now()))),
        if (isChangeShowTime)
          CustomLayoutLabelValue(
              labelWidth: 120,
              padding: EdgeInsets.symmetric(horizontal: 0, vertical: 8),
              widgetLeft: Text(
                AppLocalizations.of(context)!.keyword_content,
                style: Theme.of(context)
                    .textTheme
                    .titleSmall
                    ?.copyWith(color: AppColor.secondaryTextColor),
              ),
              widgetRight: Text(contentPayment)),
        CustomDivider(
          color: AppColor.accentColor,
        ).paddingOnly(top: 12, bottom: 8),
      ],
    );
  }
}

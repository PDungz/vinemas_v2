
import 'package:flutter/material.dart';
import 'package:packages/widget/Layout/custom_layout_label_value.dart';
import 'package:vinemas_v1/core/config/app_color.dart';
import 'package:vinemas_v1/core/utils/currency_formatter.dart';
import 'package:vinemas_v1/core/utils/format_datetime.dart';
import 'package:vinemas_v1/features/about_sessions/domain/entity/about/movie_detail.dart';
import 'package:vinemas_v1/features/about_sessions/domain/entity/session/cinema.dart';
import 'package:vinemas_v1/features/about_sessions/domain/entity/session/session_movie.dart';
import 'package:vinemas_v1/l10n/generated/app_localizations.dart';

class TicketInfoDetailWidget extends StatelessWidget {
  const TicketInfoDetailWidget({
    super.key,
    required this.cinema,
    required this.sessionMovie,
    required this.movieDetail,
    required this.currentBooked,
    required this.currentPrice,
  });

  final Cinema cinema;
  final SessionMovie sessionMovie;
  final MovieDetail movieDetail;
  final List<String> currentBooked;
  final int currentPrice;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
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
            widgetRight: Text(
                FormatDateTime.convertMinutesToHourMinute(
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
            widgetRight: Text(
                currentBooked.map((e) => e).toList().join(', '))),
        CustomLayoutLabelValue(
            labelWidth: 120,
            padding: EdgeInsets.symmetric(horizontal: 0, vertical: 8),
            widgetLeft: Text(
              AppLocalizations.of(context)!.keyword_price,
              style: Theme.of(context)
                  .textTheme
                  .titleSmall
                  ?.copyWith(color: AppColor.secondaryTextColor),
            ),
            widgetRight: Text(
                currentPrice.formatCurrency(
                    currencyCode: AppLocalizations.of(context)!
                        .keyword_currency_format),
                style: Theme.of(context).textTheme.titleSmall)),
      ],
    );
  }
}

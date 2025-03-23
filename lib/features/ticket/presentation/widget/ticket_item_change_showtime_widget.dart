import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vinemas_v1/core/config/app_color.dart';
import 'package:vinemas_v1/core/utils/format_datetime.dart';
import 'package:vinemas_v1/features/about_sessions/domain/entity/session/cinema.dart';
import 'package:vinemas_v1/features/about_sessions/domain/entity/session/session_movie.dart';
import 'package:vinemas_v1/l10n/generated/app_localizations.dart';

class TicketItemChangeShowtimeWidget extends StatelessWidget {
  const TicketItemChangeShowtimeWidget({
    super.key,
    required this.cinemas,
    required this.sessionMovie,
    this.isSelected = false,
    this.onTap,
  });

  final List<Cinema> cinemas;
  final SessionMovie sessionMovie;
  final bool isSelected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: AppColor.secondaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(
            color: isSelected
                ? AppColor.buttonLinerOneColor
                : AppColor.secondaryColor,
            width: 1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      cinemas
                          .firstWhere((element) =>
                              element.cinemaId == sessionMovie.cinemaId)
                          .nameCinema,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: isSelected
                              ? AppColor.buttonLinerOneColor
                              : AppColor.primaryTextColor)),
                  Text(
                      "${FormatDateTime.formatToHourMinute(sessionMovie.startDate)} - ${FormatDateTime.formatToHourMinute(sessionMovie.endDate)}",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: isSelected
                              ? AppColor.buttonLinerOneColor
                              : AppColor.primaryTextColor)),
                  Text(
                      cinemas
                          .firstWhere((element) =>
                              element.cinemaId == sessionMovie.cinemaId)
                          .address,
                      maxLines: 5,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: isSelected
                              ? AppColor.buttonLinerOneColor
                              : AppColor.primaryTextColor)),
                ],
              ),
            ),
            const SizedBox(width: 20),
            if (!isSelected)
              Text(
                AppLocalizations.of(context)!.keyword_select,
                style: Theme.of(context)
                    .textTheme
                    .titleSmall
                    ?.copyWith(color: AppColor.buttonLinerOneColor),
              ),
          ],
        ).paddingSymmetric(vertical: 12, horizontal: 20),
      ),
    );
  }
}

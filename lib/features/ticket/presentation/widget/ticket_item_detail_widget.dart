import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:packages/widget/Layout/custom_layout_label_value.dart';
import 'package:vinemas_v1/core/common/enum/configuration.dart';
import 'package:vinemas_v1/core/common/enum/process_status.dart';
import 'package:vinemas_v1/core/common/extension/configuration_extension.dart';
import 'package:vinemas_v1/core/config/app_color.dart';
import 'package:vinemas_v1/core/config/app_router.dart';
import 'package:vinemas_v1/core/global/global_bloc/global_bloc.dart';
import 'package:vinemas_v1/core/utils/format_datetime.dart';
import 'package:vinemas_v1/features/ticket/domain/entity/ticket.dart';
import 'package:vinemas_v1/features/ticket/domain/enum/ticket_status_enum.dart';
import 'package:vinemas_v1/features/ticket/domain/extension/ticket_status_extension.dart';
import 'package:vinemas_v1/features/ticket/presentation/bloc/ticket_bloc.dart';
import 'package:vinemas_v1/l10n/generated/app_localizations.dart';

class TicketItemDetailWidget extends StatelessWidget {
  final Ticket ticket;

  const TicketItemDetailWidget({super.key, required this.ticket});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          TicketBloc()..add(TicketMovieDetailEvent(ticket: ticket)),
      child: BlocBuilder<TicketBloc, TicketState>(
        builder: (context, state) {
          if (state is MovieTicketDetailState &&
              state.processStatus == ProcessStatus.success) {
            final movieDetail = state.movieDetail;
            final sessionMovie = state.sessionMovie;
            final cinema = state.cinema;
            final chairConfig = state.chairConfig;
            final configuration =
                context.read<GlobalBloc>().state.configuration;
            return GestureDetector(
              onTap: () {
                if (ticket.status == TicketStatus.active) {
                  Get.toNamed(ConfigRoute.ticketDetailPage, arguments: [
                    movieDetail,
                    sessionMovie,
                    ticket.seats,
                    ticket.totalPrice,
                    cinema,
                    chairConfig,
                    false,
                    ticket,
                  ]);
                }
              },
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                color: AppColor.secondaryColor,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 68,
                        height: 108,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                            image: NetworkImage(
                              "${configuration?.getPosterUrl(movieDetail?.posterPath, size: PosterSize.w500)}",
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      // Ticket Info
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    movieDetail?.title ?? '',
                                    overflow: TextOverflow.ellipsis,
                                    style:
                                        Theme.of(context).textTheme.titleSmall,
                                  ),
                                ),
                                Card(
                                  color: ticket.status.toColor(),
                                  child: Text(ticket.status.name)
                                      .paddingSymmetric(
                                          horizontal: 8, vertical: 2),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            CustomLayoutLabelValue(
                              labelWidth: 80,
                              padding: EdgeInsets.zero,
                              widgetLeft: Text(
                                AppLocalizations.of(context)!.keyword_show_date,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                        color: AppColor.secondaryTextColor),
                              ),
                              widgetRight: Text(
                                "${FormatDateTime.formatToHourMinute(sessionMovie!.startDate)} - ${FormatDateTime.formatToAbbreviated(sessionMovie.startDate)}",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                        color: AppColor.primaryIconColor),
                              ),
                            ),
                            CustomLayoutLabelValue(
                              labelWidth: 80,
                              padding: EdgeInsets.zero,
                              widgetLeft: Text(
                                AppLocalizations.of(context)!.keyword_seats,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                        color: AppColor.secondaryTextColor),
                              ),
                              widgetRight: Text(
                                ticket.seats.map((e) => e).toList().join(', '),
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                        color: AppColor.primaryIconColor),
                              ),
                            ),
                            CustomLayoutLabelValue(
                              labelWidth: 80,
                              padding: EdgeInsets.zero,
                              widgetLeft: Text(
                                AppLocalizations.of(context)!.keyword_cinema,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                        color: AppColor.secondaryTextColor),
                              ),
                              widgetRight: Text(
                                cinema?.nameCinema ?? '',
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                        color: AppColor.primaryIconColor),
                              ),
                            ),
                            CustomLayoutLabelValue(
                              labelWidth: 80,
                              padding: EdgeInsets.zero,
                              widgetLeft: Text(
                                AppLocalizations.of(context)!
                                    .keyword_booking_time,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                        color: AppColor.secondaryTextColor),
                              ),
                              widgetRight: Text(
                                "${FormatDateTime.formatToHourMinute(ticket.bookedTime)} - ${FormatDateTime.formatToAbbreviated(ticket.bookedTime)}",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                        color: AppColor.primaryIconColor),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}

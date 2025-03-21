import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:packages/widget/Bottom_sheet/custom_bottom_sheet.dart';
import 'package:packages/widget/Button/custom_button.dart';
import 'package:packages/widget/Divider/custom_divider.dart';
import 'package:vinemas_v1/core/common/enum/process_status.dart';
import 'package:vinemas_v1/core/config/app_color.dart';
import 'package:vinemas_v1/core/config/app_router.dart';
import 'package:vinemas_v1/features/about_sessions/domain/entity/about/movie_detail.dart';
import 'package:vinemas_v1/features/about_sessions/presentation/bloc/session_bloc/session_bloc.dart';
import 'package:vinemas_v1/features/ticket/domain/entity/ticket.dart';
import 'package:vinemas_v1/features/ticket/presentation/widget/ticket_item_change_showtime_widget.dart';
import 'package:vinemas_v1/l10n/generated/app_localizations.dart';

class TicketButtonChangeSessionWidget extends StatelessWidget {
  const TicketButtonChangeSessionWidget({
    super.key,
    required this.movieDetail,
    required this.ticket,
  });

  final MovieDetail movieDetail;
  final Ticket ticket;

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      label: AppLocalizations.of(context)!.keyword_change_session,
      onPressed: () {
        CustomBottomSheet.show(
          context,
          minHeight: 0.68,
          header: Column(
            children: [
              Text(
                AppLocalizations.of(context)!.keyword_change_session,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              CustomDivider(
                color: AppColor.primaryIconColor,
                thickness: 1,
              ).marginSymmetric(vertical: 12),
            ],
          ),
          onClose: () => Get.close,
          body: BlocProvider(
            create: (context) =>
                SessionBloc()..add(SessionCinemaAndSessionMovieEvent()),
            child: BlocBuilder<SessionBloc, SessionState>(
              builder: (context, state) {
                if (state is SessionCinemaAndSessionMovieState) {
                  switch (state.state) {
                    case ProcessStatus.loading:
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    case ProcessStatus.success:
                      final chairConfigs = state.chairConfigs;
                      final cinemas = state.cinemas;
                      final DateTime now = DateTime.now();
                      final DateTime today =
                          DateTime(now.year, now.month, now.day);
                      final DateTime tomorrow =
                          today.add(const Duration(days: 1));

                      final selectSessionMovie = state.sessionMovie?.firstWhere(
                        (element) => element.sessionMovieId == ticket.sessionId,
                      );

                      final listSessionMovie =
                          state.sessionMovie?.where((element) {
                        return element.movieId == movieDetail.id &&
                            element.sessionMovieId != ticket.sessionId &&
                            element.endDate.isAfter(now);
                      }).where((element) {
                        DateTime movieStartDate = element.startDate;

                        return !movieStartDate.isBefore(today) &&
                            !movieStartDate.isAfter(tomorrow);
                      }).toList();

                      if (listSessionMovie != null &&
                          cinemas != null &&
                          selectSessionMovie != null &&
                          chairConfigs != null) {
                        return Column(
                          children: [
                            TicketItemChangeShowtimeWidget(
                              cinemas: cinemas,
                              sessionMovie: selectSessionMovie,
                              isSelected: true,
                              onTap: () => Get.toNamed(
                                  ConfigRoute.seatReservationPage,
                                  arguments: [
                                    selectSessionMovie,
                                    movieDetail,
                                    chairConfigs.firstWhere((element) =>
                                        element.chairConfigId ==
                                        cinemas
                                            .firstWhere((element) =>
                                                element.cinemaId ==
                                                selectSessionMovie.cinemaId)
                                            .chairConfigId),
                                    cinemas.firstWhere((element) =>
                                        element.cinemaId ==
                                        selectSessionMovie.cinemaId),
                                    ticket,
                                    true,
                                  ]),
                            ),
                            Expanded(
                              child: ListView.builder(
                                itemCount: listSessionMovie.length,
                                itemBuilder: (context, index) {
                                  return TicketItemChangeShowtimeWidget(
                                    cinemas: cinemas,
                                    sessionMovie: listSessionMovie[index],
                                    onTap: () => Get.toNamed(
                                        ConfigRoute.seatReservationPage,
                                        arguments: [
                                          listSessionMovie[index],
                                          movieDetail,
                                          chairConfigs.firstWhere((element) =>
                                              element.chairConfigId ==
                                              cinemas
                                                  .firstWhere((element) =>
                                                      element.cinemaId ==
                                                      listSessionMovie[index]
                                                          .cinemaId)
                                                  .chairConfigId),
                                          cinemas.firstWhere((element) =>
                                              element.cinemaId ==
                                              listSessionMovie[index].cinemaId),
                                          ticket,
                                          true,
                                        ]),
                                  );
                                },
                              ),
                            ),
                          ],
                        ).marginOnly(bottom: 16);
                      }
                    default:
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                  }
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),
        );
      },
    );
  }
}

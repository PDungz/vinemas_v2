import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:packages/widget/Button/custom_icon_button.dart';
import 'package:packages/widget/Divider/custom_divider.dart';
import 'package:packages/widget/Layout/custom_layout_horizontal.dart';
import 'package:packages/widget/Layout/custom_layout_vertical.dart';
import 'package:vinemas_v1/core/config/app_color.dart';
import 'package:vinemas_v1/core/config/app_router.dart';
import 'package:vinemas_v1/core/utils/format_datetime.dart';
import 'package:vinemas_v1/features/about_sessions/domain/entity/about/movie_detail.dart';
import 'package:vinemas_v1/features/about_sessions/domain/entity/session/chair_config.dart';
import 'package:vinemas_v1/features/about_sessions/domain/entity/session/cinema.dart';
import 'package:vinemas_v1/features/about_sessions/domain/entity/session/cinema_band.dart';
import 'package:vinemas_v1/features/about_sessions/domain/entity/session/session_movie.dart';
import 'package:vinemas_v1/features/ticket/data/model/ticket_model.dart';
import 'package:vinemas_v1/features/ticket/domain/enum/ticket_status_enum.dart';
import 'package:vinemas_v1/gen/assets.gen.dart';
import 'package:vinemas_v1/l10n/generated/app_localizations.dart';

class SessionCinemaRecommendWidget extends StatefulWidget {
  const SessionCinemaRecommendWidget(
      {super.key,
      required this.cinemaBand,
      required this.cinema,
      required this.currentCinemaIndex,
      required this.sessionMovieCinema,
      required this.index,
      required this.movieDetail,
      required this.chairConfig});
  final CinemaBand cinemaBand;
  final Cinema cinema;
  final MovieDetail movieDetail;
  final List<int> currentCinemaIndex;
  final List<SessionMovie> sessionMovieCinema;
  final ChairConfig chairConfig;
  final int index;

  @override
  State<SessionCinemaRecommendWidget> createState() =>
      _SessionCinemaRecommendWidgetState();
}

class _SessionCinemaRecommendWidgetState
    extends State<SessionCinemaRecommendWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomLayoutHorizontal(
          verticalPadding: 0,
          horizontalPadding: 0,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          leftWidget: CustomLayoutHorizontal(
            crossAxisAlignment: CrossAxisAlignment.center,
            leftWidget: Container(
              height: 36,
              width: 36,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                      color: AppColor.buttonLinerOneColor, width: 1.2),
                  image: DecorationImage(
                    image: NetworkImage(
                      widget.cinemaBand.imageUrl ?? '',
                    ),
                    fit: BoxFit.cover,
                  )),
            ),
            rightWidget: CustomLayoutVertical(
              topWidget: Text(widget.cinema.nameCinema,
                  style: Theme.of(context).textTheme.titleSmall),
              bottomWidget: Text('Bạn ở gần đây',
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodySmall),
            ),
          ),
          rightWidget: Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: CustomIconButton(
                elevation: 0,
                size: 16,
                horizontalPadding: 0,
                svgPathUp: widget.currentCinemaIndex.contains(widget.index)
                    ? $AssetsIconsGen().iconApp.angleUp
                    : $AssetsIconsGen().iconApp.expandArrow,
                onPressed: () {
                  if (widget.currentCinemaIndex.contains(widget.index)) {
                    setState(() {
                      widget.currentCinemaIndex.remove(widget.index);
                    });
                  } else {
                    setState(() {
                      widget.currentCinemaIndex.add(widget.index);
                    });
                  }
                }),
          ),
        ),
        Visibility(
          visible: widget.currentCinemaIndex.contains(widget.index),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(widget.cinema.address,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.bodySmall),
                    ),
                    GestureDetector(
                      child: Text('Tìm Đường',
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(color: AppColor.buttonLinerOneColor)),
                    )
                  ],
                ).marginSymmetric(horizontal: 8),
                Wrap(
                  alignment: WrapAlignment.start, // Căn trái
                  children: [
                    ...widget.sessionMovieCinema.map(
                      (session) {
                        return IntrinsicWidth(
                          child: GestureDetector(
                            onTap: () => Get.toNamed(
                              ConfigRoute.seatReservationPage,
                              arguments: [
                                session,
                                widget.movieDetail,
                                widget.chairConfig,
                                widget.cinema,
                                TicketModel(
                                    ticketId: '',
                                    sessionId: '',
                                    seats: [],
                                    totalPrice: 0,
                                    bookedTime: DateTime.now(),
                                    updateTime: DateTime.now(),
                                    status: TicketStatus.active,
                                    content: ''),
                                false,
                              ],
                            ),
                            child: Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 8),
                              padding: EdgeInsets.all(1),
                              decoration: BoxDecoration(
                                color: AppColor.buttonLinerOneColor,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                      color: AppColor.primaryColor,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(8),
                                        topRight: Radius.circular(8),
                                      ),
                                    ),
                                    child: Text(
                                      "${FormatDateTime.formatToHourMinute(session.startDate)} - ${FormatDateTime.formatToHourMinute(session.endDate)}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.copyWith(
                                            color: AppColor.buttonLinerOneColor,
                                          ),
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    child: Text(
                                      '${AppLocalizations.of(context)!.keyword_remaining} ${widget.chairConfig.rowCount * widget.chairConfig.seatsPerRow - session.chairStatuses.length}/${widget.chairConfig.rowCount * widget.chairConfig.seatsPerRow}'
                                          .toString(),
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: CustomDivider(
            color: AppColor.accentColor,
          ),
        )
      ],
    );
  }
}

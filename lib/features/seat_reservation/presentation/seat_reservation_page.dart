import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:packages/widget/Button/custom_button.dart';
import 'package:packages/widget/Divider/custom_divider.dart';
import 'package:packages/widget/Layout/custom_layout.dart';
import 'package:packages/widget/Layout/custom_layout_horizontal.dart';
import 'package:packages/widget/Shadow/custom_shadow.dart';
import 'package:vinemas_v1/core/common/enum/seat_enum.dart';
import 'package:vinemas_v1/core/common/extension/seat_extenstion.dart';
import 'package:vinemas_v1/core/config/app_color.dart';
import 'package:vinemas_v1/core/config/app_router.dart';
import 'package:vinemas_v1/core/utils/currency_formatter.dart';
import 'package:vinemas_v1/core/utils/format_datetime.dart';
import 'package:vinemas_v1/features/about_sessions/domain/entity/about/movie_detail.dart';
import 'package:vinemas_v1/features/about_sessions/domain/entity/session/chair_config.dart';
import 'package:vinemas_v1/features/about_sessions/domain/entity/session/cinema.dart';
import 'package:vinemas_v1/features/about_sessions/domain/entity/session/session_movie.dart';
import 'package:vinemas_v1/features/about_sessions/presentation/bloc/session_bloc/session_bloc.dart';
import 'package:vinemas_v1/features/seat_reservation/presentation/widget/seat_reservation_app_bar_widget.dart';
import 'package:vinemas_v1/features/seat_reservation/presentation/widget/seat_reservation_list_title_seat_widget.dart';
import 'package:vinemas_v1/features/ticket/presentation/bloc/ticket_bloc.dart';
import 'package:vinemas_v1/gen/assets.gen.dart';
import 'package:vinemas_v1/l10n/generated/app_localizations.dart';

class SeatReservationPage extends StatefulWidget {
  const SeatReservationPage({super.key});

  @override
  State<SeatReservationPage> createState() => _SeatReservationPageState();
}

class _SeatReservationPageState extends State<SeatReservationPage> {
  List<String> currentBooked = [];
  int currentPrice = 0;

  late SessionMovie sessionMovie;
  late MovieDetail movieDetail;
  late ChairConfig chairConfig;
  late Cinema cinema;

  @override
  void initState() {
    super.initState();
    _getArguments();
  }

  void _getArguments() {
    final args = Get.arguments;
    if (args != null && args.length >= 4) {
      sessionMovie = args[0] as SessionMovie;
      movieDetail = args[1] as MovieDetail;
      chairConfig = args[2] as ChairConfig;
      cinema = args[3] as Cinema;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SessionBloc()
            ..add(
              SessionSessionMovieEvent(
                  sessionMovieId: sessionMovie.sessionMovieId),
            ),
        ),
        BlocProvider<TicketBloc>(
          create: (context) => TicketBloc()
            ..add(UserMovieTicketEvent(
                sessionMovieId: sessionMovie.sessionMovieId)),
        )
      ],
      child: BlocBuilder<TicketBloc, TicketState>(
        builder: (context, stateTicket) {
          if (stateTicket is SeatMovieTicketState) {}
          return CustomLayout(
            appBar: SeatReservationAppBarWidget(
                movieDetail: movieDetail, sessionMovie: sessionMovie),
            body: Column(
              children: [
                Column(
                  children: [
                    SvgPicture.asset($AssetsSvgGen().screen),
                    Text(AppLocalizations.of(context)!.keyword_screen,
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall
                            ?.copyWith(color: AppColor.primaryIconColor)),
                  ],
                ).paddingSymmetric(vertical: 16),
                Expanded(
                  child: InteractiveViewer(
                    minScale: 0.5,
                    maxScale: 3.0,
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: chairConfig.seatsPerRow as int,
                      ),
                      itemCount: (chairConfig.seatsPerRow *
                          chairConfig.rowCount) as int,
                      itemBuilder: (context, index) {
                        int rowIndex = index ~/ chairConfig.seatsPerRow;
                        int seatNumber =
                            (index % chairConfig.seatsPerRow as int) + 1;
                        SeatRowEnum row = SeatRowEnum.values[rowIndex];
                        Color seatColor = AppColor.secondaryColor;
                        if (chairConfig.chairTypes['regular']!
                            .contains(row.name)) {
                          seatColor = SeatTypeEnum.regular.color;
                        } else if (chairConfig.chairTypes['vip']!
                            .contains(row.name)) {
                          seatColor = SeatTypeEnum.vip.color;
                        } else if (chairConfig.chairTypes['sweetBox']!
                            .contains(row.name)) {
                          seatColor = SeatTypeEnum.sweetbox.color;
                        }
                        if (sessionMovie.chairStatuses
                            .containsKey('${row.name}$seatNumber')) {
                          seatColor = SeatTypeEnum.reserved.color;
                        }

                        return InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          onTap: () {
                            if (!sessionMovie.chairStatuses
                                .containsKey('${row.name}$seatNumber')) {
                              setState(() {
                                if (currentBooked
                                    .contains('${row.name}$seatNumber')) {
                                  currentBooked
                                      .remove('${row.name}$seatNumber');
                                  if (chairConfig.chairTypes['regular']!
                                      .contains(row.name)) {
                                    setState(() {
                                      currentPrice -= sessionMovie
                                          .seatPrices['regular'] as int;
                                    });
                                  } else if (chairConfig.chairTypes['vip']!
                                      .contains(row.name)) {
                                    setState(() {
                                      currentPrice -=
                                          sessionMovie.seatPrices['vip'] as int;
                                    });
                                  } else if (chairConfig.chairTypes['sweetBox']!
                                      .contains(row.name)) {
                                    setState(() {
                                      currentPrice -= sessionMovie
                                          .seatPrices['sweetBox'] as int;
                                    });
                                  }
                                } else {
                                  currentBooked.add('${row.name}$seatNumber');
                                  if (chairConfig.chairTypes['regular']!
                                      .contains(row.name)) {
                                    setState(() {
                                      currentPrice += sessionMovie
                                          .seatPrices['regular'] as int;
                                    });
                                  } else if (chairConfig.chairTypes['vip']!
                                      .contains(row.name)) {
                                    setState(() {
                                      currentPrice +=
                                          sessionMovie.seatPrices['vip'] as int;
                                    });
                                  } else if (chairConfig.chairTypes['sweetBox']!
                                      .contains(row.name)) {
                                    setState(() {
                                      currentPrice += sessionMovie
                                          .seatPrices['sweetBox'] as int;
                                    });
                                  }
                                }
                              });
                            }
                          },
                          child: Container(
                            margin: EdgeInsets.all(2.8),
                            padding: EdgeInsets.all(2),
                            height: 32,
                            width: 32,
                            decoration: BoxDecoration(
                              color: currentBooked
                                      .contains('${row.name}$seatNumber')
                                  ? SeatTypeEnum.selected.color
                                  : seatColor,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            alignment: Alignment.center,
                            child: sessionMovie.chairStatuses
                                    .containsKey('${row.name}$seatNumber')
                                ? SvgPicture.asset(
                                    $AssetsIconsGen().iconApp.close,
                                    color: AppColor.accentColor,
                                  )
                                : Text('${row.name}$seatNumber',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(
                                            color: currentBooked.contains(
                                                    '${row.name}$seatNumber')
                                                ? AppColor.primaryTextColor
                                                : AppColor.primaryIconColor,
                                            fontSize: 8)),
                          ),
                        );
                      },
                    ).marginSymmetric(horizontal: 16),
                  ),
                ),
              ],
            ).marginOnly(top: 128),
            bottomNavigationBar: ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                    padding: EdgeInsets.only(top: 12, bottom: 20),
                    decoration: BoxDecoration(
                      color: AppColor.secondaryColor.withOpacity(0.8),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SeatReservationListTitleSeatWidget()
                            .paddingSymmetric(horizontal: 16),
                        const CustomDivider(
                          thickness: 8,
                          borderRadius: 0,
                          color: AppColor.primaryColor,
                        ).paddingSymmetric(vertical: 4),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(movieDetail.title,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium),
                                Text(
                                    AppLocalizations.of(context)!
                                        .keyword_change_showtime,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall
                                        ?.copyWith(
                                            color: AppColor.buttonLinerOneColor,
                                            fontSize: 14)),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text(
                                '${FormatDateTime.formatToHourMinute(sessionMovie.startDate)} ~ ${FormatDateTime.formatToHourMinute(sessionMovie.endDate)} | +16',
                                style: Theme.of(context).textTheme.bodySmall),
                          ],
                        ).paddingSymmetric(horizontal: 16),
                        const SizedBox(height: 8),
                        CustomLayoutHorizontal(
                            horizontalPadding: 16,
                            verticalPadding: 0,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            leftWidget: Text(
                                AppLocalizations.of(context)!.keyword_total,
                                style: Theme.of(context).textTheme.bodyMedium),
                            rightWidget: Text(
                                currentPrice.formatCurrency(
                                    currencyCode: AppLocalizations.of(context)!
                                        .keyword_currency_format),
                                style: Theme.of(context).textTheme.titleSmall)),
                        const SizedBox(height: 16),
                        CustomShadow(
                            child: CustomButton(
                          onPressed: () {
                            Get.toNamed(ConfigRoute.payPage, arguments: [
                              movieDetail,
                              sessionMovie,
                              currentBooked,
                              currentPrice,
                              cinema
                            ]);
                          },
                          label: AppLocalizations.of(context)!.keyword_buy,
                        )).paddingSymmetric(horizontal: 12)
                      ],
                    )),
              ),
            ),
          );
        },
      ),
    );
  }
}

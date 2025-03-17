import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:packages/widget/Layout/custom_layout.dart';
import 'package:vinemas_v1/core/common/enum/process_status.dart';
import 'package:vinemas_v1/core/common/enum/seat_enum.dart';
import 'package:vinemas_v1/core/common/extension/seat_extenstion.dart';
import 'package:vinemas_v1/core/config/app_color.dart';
import 'package:vinemas_v1/features/about_sessions/domain/entity/about/movie_detail.dart';
import 'package:vinemas_v1/features/about_sessions/domain/entity/session/chair_config.dart';
import 'package:vinemas_v1/features/about_sessions/domain/entity/session/cinema.dart';
import 'package:vinemas_v1/features/about_sessions/domain/entity/session/session_movie.dart';
import 'package:vinemas_v1/features/about_sessions/presentation/bloc/session_bloc/session_bloc.dart';
import 'package:vinemas_v1/features/seat_reservation/presentation/widget/seat_button_book_ticket_widget.dart';
import 'package:vinemas_v1/features/seat_reservation/presentation/widget/seat_loading_widget.dart';
import 'package:vinemas_v1/features/seat_reservation/presentation/widget/seat_reservation_app_bar_widget.dart';
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

  void _toggleSeatSelection(SeatRowEnum row, int seatNumber) {
    String seatKey = '${row.name}$seatNumber';

    if (!sessionMovie.chairStatuses.containsKey(seatKey)) {
      setState(() {
        if (currentBooked.contains(seatKey)) {
          currentBooked.remove(seatKey);
          _updatePrice(row, isAdding: false);
        } else {
          currentBooked.add(seatKey);
          _updatePrice(row, isAdding: true);
        }
      });
    }
  }

  void _updatePrice(SeatRowEnum row, {required bool isAdding}) {
    int priceChange = 0;

    if (chairConfig.chairTypes['regular']!.contains(row.name)) {
      priceChange = sessionMovie.seatPrices['regular'] as int;
    } else if (chairConfig.chairTypes['vip']!.contains(row.name)) {
      priceChange = sessionMovie.seatPrices['vip'] as int;
    } else if (chairConfig.chairTypes['sweetBox']!.contains(row.name)) {
      priceChange = sessionMovie.seatPrices['sweetBox'] as int;
    }

    setState(() {
      currentPrice += isAdding ? priceChange : -priceChange;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomLayout(
      appBar: SeatReservationAppBarWidget(
          movieDetail: movieDetail, sessionMovie: sessionMovie),
      body: MultiBlocProvider(
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
        child: Column(
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
                child: BlocBuilder<TicketBloc, TicketState>(
                  builder: (context, stateTicket) {
                    if (stateTicket is SeatMovieTicketState &&
                        stateTicket.processStatus == ProcessStatus.success) {
                      final bookedSeats = stateTicket.seats ?? [];
                      return GridView.builder(
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
                          if (bookedSeats.contains('${row.name}$seatNumber')) {
                            seatColor =
                                SeatTypeEnum.selected.color.withOpacity(0.4);
                          }

                          return GestureDetector(
                            onTap: () => _toggleSeatSelection(row, seatNumber),
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
                              child: sessionMovie.chairStatuses.containsKey(
                                          '${row.name}$seatNumber') &&
                                      !bookedSeats
                                          .contains('${row.name}$seatNumber')
                                  ? SvgPicture.asset(
                                      $AssetsIconsGen().iconApp.close,
                                      color: AppColor.accentColor,
                                    )
                                  : Text(
                                      '${row.name}$seatNumber',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.copyWith(
                                              color: currentBooked.contains(
                                                      '${row.name}$seatNumber')
                                                  ? AppColor.primaryTextColor
                                                  : AppColor.primaryIconColor,
                                              fontSize: 8),
                                    ),
                            ),
                          );
                        },
                      );
                    }
                    return SeatLoadingWidget();
                  },
                ).marginSymmetric(horizontal: 16),
              ),
            ),
          ],
        ).marginOnly(top: 128),
      ),
      bottomNavigationBar: SeatButtonBookTicketWidget(
          movieDetail: movieDetail,
          sessionMovie: sessionMovie,
          currentPrice: currentPrice,
          currentBooked: currentBooked,
          chairConfig: chairConfig,
          cinema: cinema),
    );
  }
}

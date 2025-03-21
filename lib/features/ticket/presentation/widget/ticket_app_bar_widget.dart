import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:packages/widget/App_bar/custom_app_bar.dart';
import 'package:packages/widget/Button/custom_icon_button.dart';
import 'package:vinemas_v1/core/config/app_router.dart';
import 'package:vinemas_v1/features/about_sessions/domain/entity/about/movie_detail.dart';
import 'package:vinemas_v1/features/about_sessions/domain/entity/session/chair_config.dart';
import 'package:vinemas_v1/features/about_sessions/domain/entity/session/cinema.dart';
import 'package:vinemas_v1/features/about_sessions/domain/entity/session/session_movie.dart';
import 'package:vinemas_v1/features/ticket/data/model/ticket_model.dart';
import 'package:vinemas_v1/features/ticket/domain/enum/ticket_status_enum.dart';
import 'package:vinemas_v1/gen/assets.gen.dart';

class TicketAppBarWidget extends StatelessWidget {
  const TicketAppBarWidget({
    super.key,
    required this.title,
    this.showIconTicket = true,
    this.sessionMovie,
    this.movieDetail,
    this.chairConfig,
    this.cinema,
    this.paymentPass = false,
  });

  final String title;
  final bool showIconTicket;

  final SessionMovie? sessionMovie;
  final MovieDetail? movieDetail;
  final ChairConfig? chairConfig;
  final Cinema? cinema;
  final bool paymentPass;

  @override
  Widget build(BuildContext context) {
    return CustomAppBar(
      leading: CustomIconButton(
        svgPathUp: $AssetsIconsGen().iconApp.back,
        onPressed: () {
          Get.back();
          if (paymentPass) {
            Get.offNamed(ConfigRoute.seatReservationPage, arguments: [
              sessionMovie,
              movieDetail,
              chairConfig,
              cinema,
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
            ]);
          }
        },
        elevation: 0,
      ),
      title: Padding(
        padding: EdgeInsets.only(
            top: 12.0, bottom: 12.0, right: showIconTicket ? 0 : 36),
        child: Text(title,
            overflow: TextOverflow.ellipsis,
            style:
                Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 18)),
      ),
      actions: [
        if (showIconTicket)
          CustomIconButton(
              elevation: 0,
              svgPathUp: $AssetsIconsGen().iconApp.ticket,
              onPressed: () {
                Get.toNamed(ConfigRoute.ticketPage);
              })
      ],
    );
  }
}

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:packages/widget/Button/custom_button.dart';
import 'package:packages/widget/Dialog/custom_dialog.dart';
import 'package:packages/widget/Divider/custom_divider.dart';
import 'package:packages/widget/Layout/custom_layout_horizontal.dart';
import 'package:packages/widget/Shadow/custom_shadow.dart';
import 'package:packages/widget/Snackbar/custom_snackbar.dart';
import 'package:vinemas_v1/core/common/enum/process_status.dart';
import 'package:vinemas_v1/core/config/app_color.dart';
import 'package:vinemas_v1/core/config/app_router.dart';
import 'package:vinemas_v1/core/utils/currency_formatter.dart';
import 'package:vinemas_v1/core/utils/format_datetime.dart';
import 'package:vinemas_v1/features/about_sessions/domain/entity/about/movie_detail.dart';
import 'package:vinemas_v1/features/about_sessions/domain/entity/session/chair_config.dart';
import 'package:vinemas_v1/features/about_sessions/domain/entity/session/cinema.dart';
import 'package:vinemas_v1/features/about_sessions/domain/entity/session/session_movie.dart';
import 'package:vinemas_v1/features/seat_reservation/presentation/widget/seat_reservation_list_title_seat_widget.dart';
import 'package:vinemas_v1/features/ticket/data/model/ticket_model.dart';
import 'package:vinemas_v1/features/ticket/domain/enum/ticket_status_enum.dart';
import 'package:vinemas_v1/features/ticket/presentation/bloc/ticket_bloc.dart';
import 'package:vinemas_v1/gen/assets.gen.dart';
import 'package:vinemas_v1/l10n/generated/app_localizations.dart';

class SeatButtonBookTicketWidget extends StatelessWidget {
  const SeatButtonBookTicketWidget({
    super.key,
    required this.movieDetail,
    required this.sessionMovie,
    required this.currentPrice,
    required this.currentBooked,
    required this.cinema,
    required this.chairConfig,
    required this.ticketModel,
    required this.isChangeShowTime,
  });

  final MovieDetail movieDetail;
  final SessionMovie sessionMovie;
  final int currentPrice;
  final List<String> currentBooked;
  final Cinema cinema;
  final ChairConfig chairConfig;
  final TicketModel ticketModel;
  final bool isChangeShowTime;

  @override
  Widget build(BuildContext context) {
    return ClipRect(
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
                          style: Theme.of(context).textTheme.titleMedium),
                      Text(
                          AppLocalizations.of(context)!.keyword_change_showtime,
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
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      SvgPicture.asset($AssetsIconsGen().iconApp.location,
                          height: 16),
                      SizedBox(width: 2),
                      Expanded(
                        child: Text(cinema.address,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.bodySmall),
                      ),
                    ],
                  ),
                ],
              ).paddingSymmetric(horizontal: 16),
              const SizedBox(height: 8),
              if (isChangeShowTime)
                CustomLayoutHorizontal(
                    horizontalPadding: 16,
                    verticalPadding: 0,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    leftWidget: Text(
                        AppLocalizations.of(context)!.keyword_amount_paid,
                        style: Theme.of(context).textTheme.bodyMedium),
                    rightWidget: Text(
                        ticketModel.totalPrice.formatCurrency(
                            currencyCode: AppLocalizations.of(context)!
                                .keyword_currency_format),
                        style: Theme.of(context).textTheme.titleSmall)),
              const SizedBox(height: 8),
              CustomLayoutHorizontal(
                  horizontalPadding: 16,
                  verticalPadding: 0,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  leftWidget: Text(AppLocalizations.of(context)!.keyword_total,
                      style: Theme.of(context).textTheme.bodyMedium),
                  rightWidget: Text(
                      currentPrice.formatCurrency(
                          currencyCode: AppLocalizations.of(context)!
                              .keyword_currency_format),
                      style: Theme.of(context).textTheme.titleSmall)),
              const SizedBox(height: 16),
              if (!isChangeShowTime)
                CustomShadow(
                  child: CustomButton(
                    onPressed: () {
                      if (currentBooked.isEmpty) {
                        Get.dialog(CustomDialog(
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 32, vertical: 12),
                          svgIcon: $AssetsIconsGen().iconApp.exclamationCircle,
                          title: AppLocalizations.of(context)!
                              .keyword_notification,
                          description: AppLocalizations.of(context)!
                              .keyword_notification_seat_required,
                          acceptText:
                              AppLocalizations.of(context)!.keyword_continue,
                          showCancelButton: false,
                          onAccept: () {
                            Get.back();
                          },
                        ));
                      } else {
                        Get.toNamed(ConfigRoute.payPage, arguments: [
                          movieDetail,
                          sessionMovie,
                          currentBooked,
                          currentPrice,
                          cinema,
                          chairConfig,
                          '',
                          false,
                          TicketModel(
                              ticketId: '',
                              sessionId: '',
                              seats: [],
                              totalPrice: 0,
                              bookedTime: DateTime.now(),
                              updateTime: DateTime.now(),
                              status: TicketStatus.active,
                              content: ''),
                        ]);
                      }
                    },
                    label: AppLocalizations.of(context)!.keyword_buy,
                  ),
                ).paddingSymmetric(horizontal: 12)
              else
                BlocProvider(
                  create: (context) => TicketBloc(),
                  child: BlocBuilder<TicketBloc, TicketState>(
                    builder: (context, state) {
                      return BlocListener<TicketBloc, TicketState>(
                        listener: (context, state) {
                          if (state is ChangeTicketState &&
                              state.processStatus == ProcessStatus.success) {
                            CustomSnackbar.show(
                              title: 'Notification',
                              message: state.message ?? "",
                              iconPath: $AssetsIconsGen().iconApp.bell,
                              iconColor: AppColor.primaryTextColor,
                              backgroundColor:
                                  state.processStatus == ProcessStatus.success
                                      ? Colors.green
                                      : Colors.red,
                              snackPosition:
                                  SnackPosition.TOP, // Hiển thị từ trên xuống
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 20),
                              borderRadius: 10,
                              duration: const Duration(seconds: 2),
                              isDismissible: true,
                              forwardAnimationCurve: Curves.easeOutBack,
                            );
                            Get.toNamed(ConfigRoute.ticketDetailPage,
                                arguments: [
                                  movieDetail,
                                  sessionMovie,
                                  currentBooked,
                                  currentPrice,
                                  cinema,
                                  chairConfig,
                                  true,
                                  ticketModel
                                ]);
                            CustomSnackbar.show(
                              title: 'Notification',
                              message: state.message ?? "",
                              iconPath: $AssetsIconsGen().iconApp.bell,
                              iconColor: AppColor.primaryTextColor,
                              backgroundColor:
                                  state.processStatus == ProcessStatus.success
                                      ? Colors.green
                                      : Colors.red,
                              snackPosition:
                                  SnackPosition.TOP, // Hiển thị từ trên xuống
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 20),
                              borderRadius: 10,
                              duration: const Duration(seconds: 2),
                              isDismissible: true,
                              forwardAnimationCurve: Curves.easeOutBack,
                            );
                          }
                        },
                        child: CustomShadow(
                            child: CustomButton(
                          isLoading: state is ChangeTicketState &&
                              state.processStatus == ProcessStatus.loading,
                          onPressed: () {
                            if (currentBooked.isEmpty) {
                              Get.dialog(
                                CustomDialog(
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 32, vertical: 12),
                                  svgIcon: $AssetsIconsGen()
                                      .iconApp
                                      .exclamationCircle,
                                  title: AppLocalizations.of(context)!
                                      .keyword_notification,
                                  description: AppLocalizations.of(context)!
                                      .keyword_notification_seat_required,
                                  acceptText: AppLocalizations.of(context)!
                                      .keyword_continue,
                                  showCancelButton: false,
                                  onAccept: () {
                                    Get.back();
                                  },
                                ),
                              );
                            } else {
                              if (currentPrice - ticketModel.totalPrice > 0) {
                                Get.toNamed(ConfigRoute.payPage, arguments: [
                                  movieDetail,
                                  sessionMovie,
                                  currentBooked,
                                  currentPrice - ticketModel.totalPrice,
                                  cinema,
                                  chairConfig,
                                  AppLocalizations.of(context)!
                                      .keyword_payment_change_fee,
                                  true,
                                  ticketModel
                                ]);
                              } else if (currentPrice -
                                      ticketModel.totalPrice ==
                                  0) {
                                context.read<TicketBloc>().add(
                                    ChangeTichetEvent(
                                        ticketModel: ticketModel,
                                        sessionMovie: sessionMovie,
                                        seats: currentBooked));
                              } else {
                                CustomSnackbar.show(
                                  title: 'Notification',
                                  message: AppLocalizations.of(context)!
                                      .keyword_no_refund_change_session,
                                  iconPath: $AssetsIconsGen().iconApp.bell,
                                  iconColor: AppColor.primaryTextColor,
                                  backgroundColor: Colors.red,
                                  snackPosition: SnackPosition.TOP,
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 20),
                                  borderRadius: 10,
                                  duration: const Duration(seconds: 2),
                                  isDismissible: true,
                                  forwardAnimationCurve: Curves.easeOutBack,
                                );
                              }
                            }
                          },
                          label: AppLocalizations.of(context)!
                              .keyword_change_session,
                        )),
                      );
                    },
                  ),
                ).paddingSymmetric(horizontal: 12)
            ],
          ),
        ),
      ),
    );
  }
}

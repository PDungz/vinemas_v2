import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:packages/Core/config/app_color.dart';
import 'package:packages/widget/Button/custom_button.dart';
import 'package:packages/widget/Layout/custom_layout.dart';
import 'package:packages/widget/Layout/custom_layout_label_value.dart';
import 'package:packages/widget/Shadow/custom_shadow.dart';
import 'package:vinemas_v1/core/common/enum/process_status.dart';
import 'package:vinemas_v1/core/config/app_router.dart';
import 'package:vinemas_v1/core/config/app_url.dart';
import 'package:vinemas_v1/core/utils/currency_formatter.dart';
import 'package:vinemas_v1/features/about_sessions/domain/entity/about/movie_detail.dart';
import 'package:vinemas_v1/features/about_sessions/domain/entity/session/chair_config.dart';
import 'package:vinemas_v1/features/about_sessions/domain/entity/session/cinema.dart';
import 'package:vinemas_v1/features/about_sessions/domain/entity/session/session_movie.dart';
import 'package:vinemas_v1/features/pay/domain/enum/pay_enum.dart';
import 'package:vinemas_v1/features/pay/presentation/pay_bloc/pay_bloc.dart';
import 'package:vinemas_v1/features/pay/presentation/widget/pay_app_bar_widget.dart';
import 'package:vinemas_v1/features/pay/presentation/widget/pay_bill_ticket_widget.dart';
import 'package:vinemas_v1/features/pay/presentation/widget/pay_method_widget.dart';
import 'package:vinemas_v1/features/pay/presentation/widget/pay_tear_line_widget.dart';
import 'package:vinemas_v1/features/ticket/data/model/ticket_model.dart';
import 'package:vinemas_v1/features/ticket/domain/enum/ticket_status_enum.dart';
import 'package:vinemas_v1/l10n/generated/app_localizations.dart';

class PayPage extends StatefulWidget {
  const PayPage({super.key});

  @override
  State<PayPage> createState() => _PayPageState();
}

class _PayPageState extends State<PayPage> {
  late List<String> currentBooked;
  late int currentPrice;
  PayMethodEnum selectedMethod = PayMethodEnum.card;

  late SessionMovie sessionMovie;
  late MovieDetail movieDetail;
  late Cinema cinema;
  late ChairConfig chairConfig;
  late String contentPayment;
  late bool isChangeShowTime;
  late TicketModel ticketModel;

  void onSelectedMethod(dynamic paymentMethod) {
    setState(() {
      selectedMethod = paymentMethod;
    });
  }

  @override
  void initState() {
    Stripe.publishableKey = AppUrl.publishableKey;
    _getArguments();
    super.initState();
  }

  void _getArguments() {
    final args = Get.arguments;
    if (args != null && args.length >= 9) {
      movieDetail = args[0] as MovieDetail;
      sessionMovie = args[1] as SessionMovie;
      currentBooked = args[2] as List<String>;
      currentPrice = args[3] as int;
      cinema = args[4] as Cinema;
      chairConfig = args[5] as ChairConfig;
      contentPayment = args[6] as String;
      isChangeShowTime = args[7] as bool;
      ticketModel = args[8] as TicketModel;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PayBloc(),
      child: CustomLayout(
        appBar: PayAppBarWidget(),
        body: Container(
          padding: EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: AppColor.secondaryColor,
            borderRadius: BorderRadiusDirectional.only(
              bottomStart: Radius.circular(16),
              bottomEnd: Radius.circular(16),
            ),
          ),
          child: ListView(
            shrinkWrap: true,
            children: [
              PayBillTicketWidget(
                movieDetail: movieDetail,
                cinema: cinema,
                sessionMovie: sessionMovie,
                currentBooked: currentBooked,
                contentPayment: contentPayment,
                isChangeShowTime: isChangeShowTime,
              ).paddingSymmetric(horizontal: 12),
              CustomLayoutLabelValue(
                      labelWidth: 120,
                      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 8),
                      widgetLeft: Text(
                        AppLocalizations.of(context)!.keyword_total,
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall
                            ?.copyWith(color: AppColor.secondaryTextColor),
                      ),
                      widgetRight: Text(currentPrice.formatCurrency(
                          currencyCode: AppLocalizations.of(context)!
                              .keyword_currency_format)))
                  .paddingSymmetric(horizontal: 12),
              PayTearLineWidget().paddingSymmetric(vertical: 12),
              PayMethodWidget(
                onSelectedMethod: onSelectedMethod,
                selectedMethod: selectedMethod,
              ).paddingSymmetric(horizontal: 12, vertical: 12),
              BlocConsumer<PayBloc, PayState>(
                listener: (context, state) {
                  if (state is PaymentTicketState &&
                      state.processStatus == ProcessStatus.success) {
                    Get.toNamed(ConfigRoute.ticketDetailPage, arguments: [
                      movieDetail,
                      sessionMovie,
                      currentBooked,
                      currentPrice,
                      cinema,
                      chairConfig,
                      true,
                      state.ticket
                    ]);
                  }
                },
                builder: (context, state) {
                  return CustomShadow(
                    child: CustomButton(
                      label: AppLocalizations.of(context)!.keyword_continue,
                      isLoading: state is PaymentTicketState
                          ? state.processStatus == ProcessStatus.loading
                          : false,
                      onPressed: () {
                        if (!isChangeShowTime) {
                          context.read<PayBloc>().add(PaymentTicketEvent(
                                amount: currentPrice,
                                currency: AppLocalizations.of(context)!
                                    .keyword_currency_format
                                    .toLowerCase(),
                                payMethodEnum: selectedMethod,
                                sessionMovie: sessionMovie,
                                ticketModel: TicketModel(
                                    ticketId: '',
                                    sessionId: sessionMovie.sessionMovieId,
                                    seats: currentBooked,
                                    totalPrice: currentPrice,
                                    status: TicketStatus.active,
                                    bookedTime: DateTime.now(),
                                    updateTime: DateTime.now(),
                                    content: ''),
                              ));
                        } else {
                          context
                              .read<PayBloc>()
                              .add(PaymentTicketChangeShowTimeEvent(
                                amount: currentPrice,
                                currency: AppLocalizations.of(context)!
                                    .keyword_currency_format
                                    .toLowerCase(),
                                payMethodEnum: selectedMethod,
                                sessionMovie: sessionMovie,
                                content: contentPayment,
                                ticketModel: ticketModel,
                                seats: currentBooked,
                              ));
                        }
                      },
                    ),
                  );
                },
              ).marginSymmetric(horizontal: 12)
            ],
          ),
        ).marginOnly(top: 60),
      ),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _getArguments(); // Load lại dữ liệu khi có sự thay đổi trong context
    setState(() {}); // Cập nhật giao diện
  }
}

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
import 'package:vinemas_v1/core/config/app_url.dart';
import 'package:vinemas_v1/core/utils/currency_formatter.dart';
import 'package:vinemas_v1/features/about_sessions/domain/entity/about/movie_detail.dart';
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
  PayMethodEnum selectedMethod = PayMethodEnum.visa;

  late SessionMovie sessionMovie;
  late MovieDetail movieDetail;
  late Cinema cinema;
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
    if (args != null && args.length >= 5) {
      movieDetail = args[0] as MovieDetail;
      cinema = args[4] as Cinema;
      sessionMovie = args[1] as SessionMovie;
      currentBooked = args[2] as List<String>;
      currentPrice = args[3] as int;
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
                      currentBooked: currentBooked)
                  .paddingSymmetric(horizontal: 12),
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
              BlocBuilder<PayBloc, PayState>(
                builder: (context, state) {
                  return CustomShadow(
                    child: CustomButton(
                      label: AppLocalizations.of(context)!.keyword_continue,
                      isLoading: state is PaymentTicketState
                          ? state.processStatus == ProcessStatus.loading
                          : false,
                      onPressed: () {
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
                                status: TicketStatus.confirmed,
                                bookedAt: DateTime.now(),
                                paymentId: '',
                              ),
                            ));
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
}

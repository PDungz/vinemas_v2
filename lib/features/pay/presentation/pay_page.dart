import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:packages/Core/config/app_color.dart';
import 'package:packages/widget/Layout/custom_layout.dart';
import 'package:packages/widget/Layout/custom_layout_label_value.dart';
import 'package:vinemas_v1/core/utils/format_datetime.dart';
import 'package:vinemas_v1/features/about_sessions/domain/entity/session/session_movie.dart';
import 'package:vinemas_v1/features/home/domain/entity/movie.dart';
import 'package:vinemas_v1/features/pay/presentation/widget/pay_app_bar_widget.dart';
import 'package:vinemas_v1/l10n/generated/app_localizations.dart';

class PayPage extends StatefulWidget {
  const PayPage({super.key});

  @override
  State<PayPage> createState() => _PayPageState();
}

class _PayPageState extends State<PayPage> {
  late List currentBooked;
  late int currentPrice;

  late SessionMovie sessionMovie;
  late Movie movie;

  @override
  void initState() {
    super.initState();
    _getArguments();
  }

  void _getArguments() {
    final args = Get.arguments;
    if (args != null && args.length >= 4) {
      movie = args[0] as Movie;
      sessionMovie = args[1] as SessionMovie;
      currentBooked = args[2] as List<String>;
      currentPrice = args[3] as int;
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomLayout(
      appBar: PayAppBarWidget(),
      body: Container(
        height: 300,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
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
            Text(
              movie.title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            CustomLayoutLabelValue(
                labelWidth: 120,
                padding: EdgeInsets.symmetric(horizontal: 0, vertical: 8),
                widgetLeft: Text(
                  AppLocalizations.of(context)!.keyword_cinema,
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall
                      ?.copyWith(color: AppColor.secondaryTextColor),
                ),
                widgetRight: Text("")),
            CustomLayoutLabelValue(
                labelWidth: 120,
                padding: EdgeInsets.symmetric(horizontal: 0, vertical: 8),
                widgetLeft: Text(
                  AppLocalizations.of(context)!.keyword_date,
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall
                      ?.copyWith(color: AppColor.secondaryTextColor),
                ),
                widgetRight: Text(
                    FormatDateTime.formatToReadable(sessionMovie.startDate))),
            CustomLayoutLabelValue(
                labelWidth: 120,
                padding: EdgeInsets.symmetric(horizontal: 0, vertical: 8),
                widgetLeft: Text(
                  AppLocalizations.of(context)!.keyword_runtime,
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall
                      ?.copyWith(color: AppColor.secondaryTextColor),
                ),
                widgetRight: Text(
                   ""))
            
          ],
        ),
      ).marginOnly(top: 60),
    );
  }
}

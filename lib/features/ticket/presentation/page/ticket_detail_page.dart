import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:packages/widget/Button/custom_button.dart';
import 'package:packages/widget/Layout/custom_layout.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:vinemas_v1/core/config/app_color.dart';
import 'package:vinemas_v1/core/utils/format_datetime.dart';
import 'package:vinemas_v1/features/about_sessions/domain/entity/about/movie_detail.dart';
import 'package:vinemas_v1/features/about_sessions/domain/entity/session/chair_config.dart';
import 'package:vinemas_v1/features/about_sessions/domain/entity/session/cinema.dart';
import 'package:vinemas_v1/features/about_sessions/domain/entity/session/session_movie.dart';
import 'package:vinemas_v1/features/pay/presentation/widget/pay_tear_line_widget.dart';
import 'package:vinemas_v1/features/ticket/presentation/widget/ticket_app_bar_widget.dart';
import 'package:vinemas_v1/features/ticket/presentation/widget/ticket_info_detail_widget.dart';
import 'package:vinemas_v1/gen/assets.gen.dart';
import 'package:vinemas_v1/l10n/generated/app_localizations.dart';

class TicketDetailPage extends StatefulWidget {
  const TicketDetailPage({super.key});

  @override
  State<TicketDetailPage> createState() => _TicketDetailPageState();
}

class _TicketDetailPageState extends State<TicketDetailPage> {
  late List<String> currentBooked;
  late int currentPrice;

  late SessionMovie sessionMovie;
  late MovieDetail movieDetail;
  late Cinema cinema;
  late ChairConfig chairConfig;

  @override
  void initState() {
    _getArguments();
    super.initState();
  }

  void _getArguments() {
    final args = Get.arguments;
    if (args != null && args.length >= 6) {
      movieDetail = args[0] as MovieDetail;
      sessionMovie = args[1] as SessionMovie;
      currentBooked = args[2] as List<String>;
      currentPrice = args[3] as int;
      cinema = args[4] as Cinema;
      chairConfig = args[5] as ChairConfig;
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomLayout(
      appBar: TicketAppBarWidget(
        title: movieDetail.title,
        sessionMovie: sessionMovie,
        chairConfig: chairConfig,
        cinema: cinema,
        movieDetail: movieDetail,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: AppColor.secondaryColor,
          borderRadius: BorderRadiusDirectional.only(
            bottomStart: Radius.circular(16),
            bottomEnd: Radius.circular(16),
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Card(
                color: AppColor.primaryTextColor,
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: QrImageView(
                    data:
                        '${AppLocalizations.of(context)!.keyword_movie_session_code}: ${sessionMovie.sessionMovieId}\n'
                        '${AppLocalizations.of(context)!.keyword_more}: ${movieDetail.title}\n'
                        '${AppLocalizations.of(context)!.keyword_cinema}: ${cinema.address}\n'
                        '${AppLocalizations.of(context)!.keyword_date}: ${FormatDateTime.formatToHourMinute(sessionMovie.startDate)} - ${FormatDateTime.formatToReadable(sessionMovie.startDate)}\n'
                        '${AppLocalizations.of(context)!.keyword_runtime}: ${FormatDateTime.convertMinutesToHourMinute(movieDetail.runtime)}\n'
                        '${AppLocalizations.of(context)!.keyword_seats}: ${currentBooked.map((e) => e).toList().join(', ')}',
                    embeddedImage:
                        Image.asset($AssetsImagesLogoAppGen().appIcon.path)
                            .image,
                    embeddedImageStyle: QrEmbeddedImageStyle(
                      size: Size(36, 36), // Kích thước logo
                    ),
                    size: 180,
                    gapless: false,
                    errorStateBuilder: (cxt, err) {
                      return Text(
                        'Uh oh! Something went wrong...',
                        textAlign: TextAlign.center,
                      );
                    },
                  ),
                ),
              ),
              PayTearLineWidget().paddingSymmetric(vertical: 16),
              // Card(
              //   color: AppColor.primaryTextColor,
              //   elevation: 6,
              //   child: Padding(
              //     padding: const EdgeInsets.all(12.0),
              //     child: BarcodeWidget(
              //       barcode: Barcode.code128(), // Chọn loại mã vạch
              //       data: sessionMovie.sessionMovieId,
              //       width: double.infinity,
              //       height: 60,
              //       drawText: false,
              //     ),
              //   ),
              // ).marginSymmetric(horizontal: 20),
              TicketInfoDetailWidget(
                      cinema: cinema,
                      sessionMovie: sessionMovie,
                      movieDetail: movieDetail,
                      currentBooked: currentBooked,
                      currentPrice: currentPrice)
                  .paddingSymmetric(horizontal: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: CustomButton(
                      label: AppLocalizations.of(context)!.keyword_refund,
                      onPressed: () => Get.back(),
                      isOutlined: true,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: CustomButton(
                      label:
                          AppLocalizations.of(context)!.keyword_change_session,
                      onPressed: () {},
                    ),
                  ),
                ],
              ).marginSymmetric(horizontal: 12, vertical: 12),
            ],
          ),
        ).marginOnly(top: 60),
      ),
    );
  }
}

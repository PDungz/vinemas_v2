import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:packages/widget/App_bar/custom_app_bar.dart';
import 'package:packages/widget/Button/custom_icon_button.dart';
import 'package:packages/widget/Layout/custom_layout.dart';
import 'package:vinemas_v1/gen/assets.gen.dart';

class SeatReservationPage extends StatelessWidget {
  const SeatReservationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final SessionMovie = Get.arguments;
    return CustomLayout(
        appBar: CustomAppBar(
          leading: CustomIconButton(
            svgPathUp: $AssetsIconsGen().iconApp.back,
            onPressed: () => Get.back(),
            elevation: 0,
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Movie',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ],
          ),
        ),
        body: Container());
  }
}

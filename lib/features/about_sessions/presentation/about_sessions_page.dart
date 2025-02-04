import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:packages/widget/App_bar/custom_app_bar.dart';
import 'package:packages/widget/Layout/custom_layout.dart';
import 'package:vinemas_v1/features/home/domain/entity/movie.dart';
import 'package:vinemas_v1/gen/assets.gen.dart';

class AboutSessionsPage extends StatelessWidget {
  const AboutSessionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Movie parameter = Get.arguments as Movie;
    return CustomLayout(
        appBar: CustomAppBar(
          leading: GestureDetector(
            onTap: () => Get.back(),
            child: SvgPicture.asset($AssetsIconsGen().iconApp.back),
          ),
          title: Padding(
            padding: const EdgeInsets.only(top: 8.0, right: 12.0, bottom: 8.0),
            child: Text(
              parameter.title,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ),
          actions: [],
        ),
        body: Container());
  }
}

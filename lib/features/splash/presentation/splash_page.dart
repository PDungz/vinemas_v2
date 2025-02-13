import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:packages/widget/Layout/custom_layout.dart';

import 'package:vinemas_v1/features/home/presentation/home_page.dart';
import 'package:vinemas_v1/gen/assets.gen.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 2), () {
      Get.to(() => HomePage(), duration: Duration(seconds: 2));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomLayout(
      backgroundWidget: Image.asset(
        $AssetsImagesBackgroundGen().splash.path,
        fit: BoxFit.fill,
      ),
      appBar: SizedBox(),
      body: Center(
        child: SvgPicture.asset(
          $AssetsSvgGen().appIcon,
          width: 120,
        ),
      ),
    );
  }
}

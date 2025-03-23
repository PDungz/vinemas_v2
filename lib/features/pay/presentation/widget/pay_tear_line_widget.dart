import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vinemas_v1/gen/assets.gen.dart';

class PayTearLineWidget extends StatelessWidget {
  const PayTearLineWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset($AssetsSvgGen().circleLeft),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(
              12,
              (index) => SvgPicture.asset($AssetsSvgGen().circle),
            ),
          ),
        ),
        SvgPicture.asset($AssetsSvgGen().circleRight),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:packages/widget/Shimmer/custom_shimmer.dart';
import 'package:vinemas_v1/core/config/app_color.dart';

class SeatLoadingWidget extends StatelessWidget {
  const SeatLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 10),
      itemCount: 80,
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.all(2.8),
          child: CustomShimmer(
            height: 48,
            width: 48,
            borderRadius: 4,
            baseColor: AppColor.secondaryTextColor.withOpacity(0.3),
            highlightColor: AppColor.buttonLinerOneColor.withOpacity(0.6),
          ),
        );
      },
    );
  }
}

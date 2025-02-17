import 'package:flutter/material.dart';
import 'package:packages/widget/Shimmer/custom_shimmer.dart';
import 'package:vinemas_v1/core/config/app_color.dart';

class NowPlayingLoadingWidget extends StatelessWidget {
  const NowPlayingLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverGrid.builder(
      itemCount: 6,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.54,
      ),
      itemBuilder: (context, index) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                CustomShimmer(
                  height: 230,
                  width: double.infinity,
                  borderRadius: 8,
                  baseColor: AppColor.secondaryTextColor.withOpacity(0.3),
                  highlightColor: AppColor.buttonLinerOneColor.withOpacity(0.6),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: CustomShimmer(
                    height: 20,
                    width: 32,
                    borderRadius: 4,
                    baseColor: AppColor.secondaryTextColor.withOpacity(0.3),
                    highlightColor:
                        AppColor.buttonLinerOneColor.withOpacity(0.6),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            CustomShimmer(
              height: 16,
              width: 80,
              borderRadius: 4,
              baseColor: AppColor.secondaryTextColor.withOpacity(0.3),
              highlightColor: AppColor.buttonLinerOneColor.withOpacity(0.6),
            ),
            const SizedBox(height: 4),
            CustomShimmer(
              height: 16,
              width: 120,
              borderRadius: 4,
              baseColor: AppColor.secondaryTextColor.withOpacity(0.3),
              highlightColor: AppColor.buttonLinerOneColor.withOpacity(0.6),
            ),
          ],
        );
      },
    );
  }
}

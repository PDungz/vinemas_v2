import 'package:flutter/material.dart';
import 'package:packages/widget/Shimmer/custom_shimmer.dart';
import 'package:vinemas_v1/core/config/app_color.dart';

class SearchListNowPlayingLoading extends StatelessWidget {
  const SearchListNowPlayingLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 8,
      itemBuilder: (context, index) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              flex: 2,
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 8),
                constraints: const BoxConstraints(minHeight: 100, maxWidth: 80),
                child: CustomShimmer(
                  height: 100,
                  width: 80,
                  borderRadius: 8,
                  baseColor: AppColor.secondaryTextColor.withOpacity(0.3),
                  highlightColor: AppColor.buttonLinerOneColor.withOpacity(0.6),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              flex: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 12),
                  CustomShimmer(
                    height: 16,
                    width: 80,
                    borderRadius: 4,
                    baseColor: AppColor.secondaryTextColor.withOpacity(0.3),
                    highlightColor:
                        AppColor.buttonLinerOneColor.withOpacity(0.6),
                  ),
                  SizedBox(height: 8),
                  CustomShimmer(
                    height: 16,
                    width: double.infinity,
                    borderRadius: 4,
                    baseColor: AppColor.secondaryTextColor.withOpacity(0.3),
                    highlightColor:
                        AppColor.buttonLinerOneColor.withOpacity(0.6),
                  ),
                  SizedBox(height: 8),
                  CustomShimmer(
                    height: 16,
                    width: 100,
                    borderRadius: 4,
                    baseColor: AppColor.secondaryTextColor.withOpacity(0.3),
                    highlightColor:
                        AppColor.buttonLinerOneColor.withOpacity(0.6),
                  ),
                  SizedBox(height: 8),
                  CustomShimmer(
                    height: 16,
                    width: 200,
                    borderRadius: 4,
                    baseColor: AppColor.secondaryTextColor.withOpacity(0.3),
                    highlightColor:
                        AppColor.buttonLinerOneColor.withOpacity(0.6),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}


import 'package:flutter/material.dart';
import 'package:packages/widget/Shimmer/custom_shimmer.dart';
import 'package:vinemas_v1/core/config/app_color.dart';

class SessionCinemaScheduleMovieLoadingWidget extends StatelessWidget {
  const SessionCinemaScheduleMovieLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: 5,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.only(top: 20, left: 16, right: 16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomShimmer(
              height: 48,
              width: 48,
              borderRadius: 8,
              baseColor: AppColor.secondaryTextColor.withOpacity(0.3),
              highlightColor: AppColor.buttonLinerOneColor.withOpacity(0.6),
            ),
            SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomShimmer(
                    height: 16,
                    width: 160,
                    borderRadius: 8,
                    baseColor: AppColor.secondaryTextColor.withOpacity(0.3),
                    highlightColor:
                        AppColor.buttonLinerOneColor.withOpacity(0.6),
                  ),
                  SizedBox(height: 8),
                  CustomShimmer(
                    height: 16,
                    width: 80,
                    borderRadius: 8,
                    baseColor: AppColor.secondaryTextColor.withOpacity(0.3),
                    highlightColor:
                        AppColor.buttonLinerOneColor.withOpacity(0.6),
                  ),
                ],
              ),
            ),
            CustomShimmer(
              height: 32,
              width: 32,
              borderRadius: 8,
              baseColor: AppColor.secondaryTextColor.withOpacity(0.3),
              highlightColor: AppColor.buttonLinerOneColor.withOpacity(0.6),
            ),
          ],
        ),
      ),
    );
  }
}

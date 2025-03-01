import 'package:flutter/material.dart';
import 'package:packages/widget/Shimmer/custom_shimmer.dart';
import 'package:vinemas_v1/core/config/app_color.dart';
import 'package:vinemas_v1/features/about_sessions/presentation/widget/about_movie_rating.dart';

class AboutLoadingWidget extends StatelessWidget {
  const AboutLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Rating Section
        Container(
          decoration: BoxDecoration(
            color: AppColor.secondaryColor,
          ),
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: AboutMovieRating(
            widgetLeft: CustomShimmer(
              height: 16,
              width: 40,
              borderRadius: 8,
              baseColor: AppColor.secondaryTextColor.withOpacity(0.3),
              highlightColor: AppColor.buttonLinerOneColor.withOpacity(0.6),
            ),
            widgetRight: CustomShimmer(
              height: 16,
              width: 40,
              borderRadius: 8,
              baseColor: AppColor.secondaryTextColor.withOpacity(0.3),
              highlightColor: AppColor.buttonLinerOneColor.withOpacity(0.6),
            ),
          ),
        ),

        // Image Section
        Padding(
          padding: const EdgeInsets.all(8),
          child: CustomShimmer(
            height: 80,
            width: double.infinity,
            borderRadius: 8,
            baseColor: AppColor.secondaryTextColor.withOpacity(0.3),
            highlightColor: AppColor.buttonLinerOneColor.withOpacity(0.6),
          ),
        ),

        // Text Section
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomShimmer(
                height: 24,
                width: 100,
                borderRadius: 8,
                baseColor: AppColor.secondaryTextColor.withOpacity(0.3),
                highlightColor: AppColor.buttonLinerOneColor.withOpacity(0.6),
              ),
              const SizedBox(height: 8),
              CustomShimmer(
                height: 20,
                width: 140,
                borderRadius: 8,
                baseColor: AppColor.secondaryTextColor.withOpacity(0.3),
                highlightColor: AppColor.buttonLinerOneColor.withOpacity(0.6),
              ),
              const SizedBox(height: 8),
              CustomShimmer(
                height: 20,
                width: 90,
                borderRadius: 8,
                baseColor: AppColor.secondaryTextColor.withOpacity(0.3),
                highlightColor: AppColor.buttonLinerOneColor.withOpacity(0.6),
              ),
              const SizedBox(height: 8),
              CustomShimmer(
                height: 20,
                width: double.infinity,
                borderRadius: 8,
                baseColor: AppColor.secondaryTextColor.withOpacity(0.3),
                highlightColor: AppColor.buttonLinerOneColor.withOpacity(0.6),
              ),
              const SizedBox(height: 8),
              CustomShimmer(
                height: 20,
                width: 250,
                borderRadius: 8,
                baseColor: AppColor.secondaryTextColor.withOpacity(0.3),
                highlightColor: AppColor.buttonLinerOneColor.withOpacity(0.6),
              ),
              const SizedBox(height: 12),
              CustomShimmer(
                height: 50,
                width: double.infinity,
                borderRadius: 8,
                baseColor: AppColor.secondaryTextColor.withOpacity(0.3),
                highlightColor: AppColor.buttonLinerOneColor.withOpacity(0.6),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

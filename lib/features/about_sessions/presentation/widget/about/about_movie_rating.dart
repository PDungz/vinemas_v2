import 'package:flutter/material.dart';
import 'package:packages/widget/Divider/custom_divider.dart';
import 'package:vinemas_v1/core/config/app_color.dart';

class AboutMovieRating extends StatelessWidget {
  const AboutMovieRating(
      {super.key, required this.widgetLeft, required this.widgetRight});

  final Widget widgetLeft;
  final Widget widgetRight;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            children: [
              widgetLeft  ,
              Text(
                'IMDB',
                style: Theme.of(context)
                    .textTheme
                    .titleSmall
                    ?.copyWith(color: AppColor.secondaryTextColor),
              ),
            ],
          ),
        ),
        CustomDivider(
          color: AppColor.secondaryTextColor.withOpacity(0.5),
          thickness: 1.0,
          indent: 10.0,
          endIndent: 10.0,
          height: 68,
          isVertical: true,
        ),
        Expanded(
          child: Column(
            children: [
              widgetRight,
              Text(
                'Vote',
                style: Theme.of(context)
                    .textTheme
                    .titleSmall
                    ?.copyWith(color: AppColor.secondaryTextColor),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

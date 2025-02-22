import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:packages/widget/Shadow/custom_shadow.dart';
import 'package:vinemas_v1/core/config/app_color.dart';

class FormTitleWidget extends StatelessWidget {
  const FormTitleWidget({
    super.key,
    this.svgPathUp,
    required this.title,
    this.description,
  });

  final String? svgPathUp;
  final String title;
  final String? description;

  @override
  Widget build(BuildContext context) {
    return CustomShadow(
      blurRadius: 36,
      borderRadius: 12,
      shadowOffset: Offset(0, 0),
      shadowColor: AppColor.buttonLinerOneColor.withOpacity(0.16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              svgPathUp != null
                  ? SizedBox(
                      child: SvgPicture.asset(
                        svgPathUp ?? '',
                      ),
                    )
                  : SizedBox(),
              SizedBox(width: 12),
              Text(
                title,
                style: Theme.of(context)
                    .textTheme
                    .displaySmall
                    ?.copyWith(fontSize: 32),
              ),
            ],
          ),
          SizedBox(width: 16),
          Text(
            description ?? '',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(),
          ),
        ],
      ),
    );
  }
}

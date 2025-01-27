import 'package:flutter/material.dart';
import 'package:packages/Core/config/app_color.dart';

class CustomShadow extends StatelessWidget {
  final Widget child;
  final double borderRadius;
  final Color shadowColor;
  final double blurRadius;
  final Offset shadowOffset;
  final double spreadRadius;

  const CustomShadow({
    super.key,
    required this.child,
    this.borderRadius = 8.0,
    this.shadowColor = AppColor.buttonLinerOneColor,
    this.blurRadius = 12.0,
    this.shadowOffset = const Offset(0, 1),
    this.spreadRadius = 0.0,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        // Shadow container without background
        Positioned(
          left: shadowOffset.dx,
          top: shadowOffset.dy,
          right: -shadowOffset.dx,
          bottom: -shadowOffset.dy,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(borderRadius),
              boxShadow: [
                BoxShadow(
                  color: shadowColor.withOpacity(0.4),
                  blurRadius: blurRadius,
                  offset: shadowOffset,
                  spreadRadius: spreadRadius,
                ),
              ],
            ),
          ),
        ),
        child,
      ],
    );
  }
}

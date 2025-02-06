import 'dart:ui';
import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({
    super.key,
    required this.backgroundColor,
    this.child,
    this.borderRadius,
    this.elevation = 0,
    this.padding = const EdgeInsets.all(8.0),
    this.shadowColor,
    this.onTap,
  });

  final Color backgroundColor;
  final Widget? child;
  final BorderRadius? borderRadius;
  final double elevation;
  final EdgeInsets padding;
  final Color? shadowColor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: borderRadius ?? BorderRadius.circular(8.0),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            decoration: BoxDecoration(
              color: backgroundColor.withOpacity(0.8),
            ),
            child: Padding(
              padding: padding,
              child: child ?? const SizedBox.shrink(),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class CustomDivider extends StatelessWidget {
  final Color color;
  final double thickness;
  final double indent;
  final double endIndent;
  final bool isVertical;
  final double? height;
  final double? width;
  final double borderRadius;

  const CustomDivider({
    super.key,
    this.color = Colors.grey,
    this.thickness = 1.0,
    this.indent = 0.0,
    this.endIndent = 0.0,
    this.borderRadius = 8,
    this.isVertical = false,
    this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return isVertical
        ? Container(
            margin: EdgeInsets.only(left: indent, right: endIndent),
            height: height ?? double.infinity,
            width: thickness,
            decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(borderRadius)),
          )
        : Container(
            margin: EdgeInsets.only(top: indent, bottom: endIndent),
            width: width ?? double.infinity,
            height: thickness,
            decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(borderRadius)),
          );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomIconButton extends StatelessWidget {
  final String svgPath;
  final VoidCallback onPressed;
  final double size;
  final Color? iconColor;
  final Color backgroundColor;
  final Color? borderColor;
  final double hight;
  final double width;
  final double verticalPadding;
  final double horizontalPadding;
  final double borderRadius;
  final double elevation;
  final BoxShape shape;
  final Color splashColor;
  final Color highlightColor;
  final Color hoverColor;
  final Color?
      iconBackgroundColor; // Thêm màu nền cho icon (mặc định là không có)

  const CustomIconButton({
    super.key,
    required this.svgPath,
    required this.onPressed,
    this.size = 24.0,
    this.iconColor,
    this.backgroundColor = Colors.transparent,
    this.borderColor,
    this.borderRadius = 8.0,
    this.elevation = 2.0,
    this.shape = BoxShape.rectangle,
    this.splashColor = Colors.transparent,
    this.highlightColor = Colors.transparent,
    this.hoverColor = Colors.transparent,
    this.hight = 42,
    this.width = 42,
    this.verticalPadding = 4,
    this.horizontalPadding = 8,
    this.iconBackgroundColor, // Mặc định không có màu nền cho icon
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: backgroundColor,
      shape: shape == BoxShape.circle
          ? const CircleBorder()
          : RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              side: borderColor != null
                  ? BorderSide(color: borderColor!)
                  : BorderSide.none,
            ),
      elevation: elevation,
      child: InkWell(
        onTap: onPressed,
        splashColor: splashColor,
        highlightColor: highlightColor,
        hoverColor: hoverColor,
        customBorder: shape == BoxShape.circle
            ? const CircleBorder()
            : RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadius),
              ),
        child: Container(
          width: hight,
          height: width,
          padding: EdgeInsets.symmetric(
              vertical: verticalPadding, horizontal: horizontalPadding),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: iconBackgroundColor ??
                Colors.transparent, // Áp dụng màu nền cho icon
            shape: shape,
            borderRadius: shape == BoxShape.rectangle
                ? BorderRadius.circular(borderRadius)
                : null,
          ),
          child: SvgPicture.asset(
            svgPath,
            width: size + 16,
            height: size + 16,
            // ignore: deprecated_member_use
            color: iconColor,
          ),
        ),
      ),
    );
  }
}

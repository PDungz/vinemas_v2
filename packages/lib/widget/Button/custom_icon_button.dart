import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomIconButton extends StatelessWidget {
  final String svgPath;
  final VoidCallback onPressed;
  final double size;
  final Color? iconColor;
  final Color backgroundColor;
  final Color? borderColor;
  final double borderRadius;
  final double elevation;
  final BoxShape shape;

  // Điều chỉnh hiệu ứng khi nhấn
  final Color splashColor;
  final Color highlightColor;
  final Color hoverColor;

  const CustomIconButton({
    super.key,
    required this.svgPath,
    required this.onPressed,
    this.size = 24.0,
    this.iconColor,
    this.backgroundColor = Colors.white,
    this.borderColor,
    this.borderRadius = 8.0,
    this.elevation = 2.0,
    this.shape = BoxShape.rectangle,
    this.splashColor = Colors.transparent,
    this.highlightColor = Colors.transparent,
    this.hoverColor = Colors.transparent,
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
          width: size + 16,
          height: size + 16,
          alignment: Alignment.center,
          child: SvgPicture.asset(
            svgPath,
            width: size,
            height: size,
            // ignore: deprecated_member_use
            color: iconColor,
          ),
        ),
      ),
    );
  }
}

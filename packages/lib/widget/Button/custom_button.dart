import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final bool isLoading;
  final bool isDisabled;
  final String? svgAsset;
  final double borderRadius;
  final double elevation;
  final bool isOutlined;
  final BorderSide? border;
  final TextStyle? textStyle;
  final double? iconSize;
  final Color? iconColor;
  final EdgeInsetsGeometry? padding;
  final Color? backgroundColor;
  final Color? overlayColor;
  final bool useMinSize; // Tùy chọn bật/tắt minSize

  const CustomButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isLoading = false,
    this.isDisabled = false,
    this.svgAsset,
    this.borderRadius = 8.0,
    this.elevation = 0.0,
    this.isOutlined = false,
    this.border,
    this.textStyle,
    this.iconSize = 24.0,
    this.iconColor,
    this.padding,
    this.backgroundColor,
    this.overlayColor = Colors.white,
    this.useMinSize = true, // Mặc định bật minSize
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final borderColor = border?.color ?? theme.primaryColor;
    final textColor = isOutlined ? borderColor : Colors.white;
    final buttonTextStyle =
        textStyle ?? theme.textTheme.labelLarge?.copyWith(color: textColor);

    return ElevatedButton(
      onPressed: isLoading || isDisabled ? null : onPressed,
      style: ElevatedButton.styleFrom(
        elevation: isOutlined ? 0 : elevation,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          side: isOutlined
              ? (border ?? BorderSide(color: theme.primaryColor, width: 1.2))
              : BorderSide.none,
        ),
        padding: padding ?? EdgeInsets.symmetric(horizontal: 8, vertical: 12),
        minimumSize: useMinSize ? const Size(64, 36) : Size.zero,
        backgroundColor: isOutlined
            ? Colors.transparent
            : (backgroundColor ?? theme.primaryColor),
        foregroundColor: overlayColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (isLoading)
            const SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            ),
          if (svgAsset != null && !isLoading)
            SvgPicture.asset(
              svgAsset!,
              height: iconSize,
              width: iconSize,
              colorFilter: ColorFilter.mode(textColor, BlendMode.srcIn),
            ),
          if (svgAsset != null && !isLoading) const SizedBox(width: 8),
          if (!isLoading)
            Text(
              label,
              style: buttonTextStyle,
            ),
        ],
      ),
    );
  }
}

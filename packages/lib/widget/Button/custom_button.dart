import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final bool isLoading;
  final bool isDisabled;
  final IconData? icon;
  final double borderRadius;
  final double elevation;
  final BorderSide? border;
  final TextStyle? textStyle; // Optional textStyle
  final double? iconSize;
  final Color? iconColor;
  final EdgeInsetsGeometry? padding;
  final Color? backgroundColor;

  const CustomButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isLoading = false,
    this.isDisabled = false,
    this.icon,
    this.borderRadius = 8.0,
    this.elevation = 0.0,
    this.border,
    this.textStyle, // Optional textStyle
    this.iconSize,
    this.iconColor,
    this.padding,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    // Default theme button text style
    final buttonTextStyle = textStyle ??
        Theme.of(context).textTheme.labelLarge?.copyWith(
              color:
                  Theme.of(context).textTheme.labelLarge?.color ?? Colors.white,
            );

    return ElevatedButton(
      onPressed: isLoading || isDisabled ? null : onPressed,
      style: ElevatedButton.styleFrom(
        elevation: elevation,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          side: border ?? BorderSide.none,
        ),
        padding: padding ??
            EdgeInsets.symmetric(
                vertical: 12, horizontal: 16), // Default padding
        backgroundColor: backgroundColor ??
            Theme.of(context).primaryColor, // Use theme color by default
      ),
      child: isLoading
          ? const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (icon != null)
                  Icon(
                    icon,
                    color: iconColor ??
                        Theme.of(context)
                            .iconTheme
                            .color, // Use theme icon color by default
                    size: iconSize,
                  ),
                if (icon != null) const SizedBox(width: 8),
                Text(
                  label,
                  style: buttonTextStyle, // Use the text style
                ),
              ],
            ),
    );
  }
}

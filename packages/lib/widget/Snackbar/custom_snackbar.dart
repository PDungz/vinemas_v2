import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomSnackbar {
  static void show({
    required String title,
    required String message,
    Color backgroundColor = Colors.blue,
    Color textColor = Colors.white,
    String? iconPath, // Đường dẫn SVG
    Color? iconColor, // Màu SVG
    double iconSize = 24.0,
    SnackPosition snackPosition = SnackPosition.BOTTOM,
    Duration duration = const Duration(seconds: 3),
    EdgeInsets margin = const EdgeInsets.all(10),
    double borderRadius = 8.0,
    bool isDismissible = true,
    SnackStyle snackStyle = SnackStyle.FLOATING,
    void Function()? onTap,
    Widget? mainButton,
    EdgeInsets padding =
        const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    double maxWidth = double.infinity,
    bool showProgressIndicator = false,
    Color progressIndicatorColor = Colors.white,
    DismissDirection dismissDirection = DismissDirection.horizontal,
    TextAlign titleTextAlign = TextAlign.start,
    TextAlign messageTextAlign = TextAlign.start,
    double titleFontSize = 16,
    double messageFontSize = 14,
    FontWeight titleFontWeight = FontWeight.bold,
    FontWeight messageFontWeight = FontWeight.normal,
    int animationDurationMs = 300,
    Curve forwardAnimationCurve = Curves.easeOut,
    Curve reverseAnimationCurve = Curves.easeIn,
    bool overlayBlur = false,
    double overlayBlurValue = 2.0,
  }) {
    Get.snackbar(
      title,
      message,
      backgroundColor: backgroundColor,
      colorText: textColor,
      snackPosition: snackPosition,
      margin: margin,
      borderRadius: borderRadius,
      isDismissible: isDismissible,
      snackStyle: snackStyle,
      duration: duration,
      animationDuration: Duration(milliseconds: animationDurationMs),
      forwardAnimationCurve: forwardAnimationCurve,
      reverseAnimationCurve: reverseAnimationCurve,
      maxWidth: maxWidth,
      overlayBlur: overlayBlur ? overlayBlurValue : 0,
      showProgressIndicator: showProgressIndicator,
      progressIndicatorBackgroundColor: backgroundColor.withOpacity(0.5),
      progressIndicatorValueColor:
          AlwaysStoppedAnimation(progressIndicatorColor),
      dismissDirection: dismissDirection,
      titleText: Text(
        title,
        textAlign: titleTextAlign,
        style: TextStyle(
          fontSize: titleFontSize,
          fontWeight: titleFontWeight,
          color: textColor,
        ),
      ),
      messageText: Text(
        message,
        textAlign: messageTextAlign,
        style: TextStyle(
          fontSize: messageFontSize,
          fontWeight: messageFontWeight,
          color: textColor,
        ),
      ),
      icon: iconPath != null
          ? Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: SvgPicture.asset(
                iconPath,
                width: iconSize,
                height: iconSize,
                colorFilter: iconColor != null
                    ? ColorFilter.mode(iconColor, BlendMode.srcIn)
                    : null,
              ),
            )
          : null,
      mainButton: mainButton != null
          ? TextButton(
              onPressed: onTap ?? () => Get.back(),
              child: mainButton,
            )
          : null,
      padding: padding,
    );
  }
}

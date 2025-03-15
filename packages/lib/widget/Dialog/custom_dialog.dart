import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:packages/Core/config/app_color.dart';
import 'package:packages/gen/assets.gen.dart';
import 'package:packages/widget/Button/custom_button.dart';

class CustomDialog extends StatelessWidget {
  final String? title;
  final String? description;
  final String? svgIcon;
  final String? cancelText;
  final String? acceptText;
  final VoidCallback? onCancel;
  final VoidCallback? onAccept;
  final bool showCancelButton;
  final bool showAcceptButton;
  final TextStyle? titleStyle;
  final TextStyle? descriptionStyle;
  final EdgeInsetsGeometry? contentPadding;
  final EdgeInsetsGeometry? buttonPadding;
  final double borderRadius;
  final Color? backgroundColor;
  final Color? headerBackgroundColor;
  final Color? buttonBackgroundColor;
  final Color? buttonTextColor;

  const CustomDialog({
    super.key,
    this.title,
    this.description,
    this.svgIcon,
    this.cancelText,
    this.acceptText,
    this.onCancel,
    this.onAccept,
    this.showCancelButton = true,
    this.showAcceptButton = true,
    this.titleStyle,
    this.descriptionStyle,
    this.contentPadding,
    this.buttonPadding,
    this.borderRadius = 16.0,
    this.backgroundColor,
    this.headerBackgroundColor,
    this.buttonBackgroundColor,
    this.buttonTextColor,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor ?? AppColor.primaryColor,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Tiêu đề
            Stack(
              children: [
                Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: headerBackgroundColor ?? AppColor.secondaryColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(borderRadius),
                      topRight: Radius.circular(borderRadius),
                    ),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  child: Text(
                    title ?? 'Notification',
                    style:
                        titleStyle ?? Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  bottom: 0,
                  child: GestureDetector(
                    onTap: () => Get.back(),
                    child: SvgPicture.asset($AssetsIconsGen().iconApp.close)
                        .marginOnly(right: 12),
                  ),
                ),
              ],
            ),

            // Icon
            if (svgIcon != null)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: SvgPicture.asset(
                  svgIcon ?? $AssetsIconsGen().iconApp.exclamationCircle,
                  color: AppColor.buttonLinerOneColor,
                  height: 48,
                ),
              ),

            // Mô tả
            if (description != null)
              Padding(
                padding: contentPadding ??
                    const EdgeInsets.only(
                        top: 8, bottom: 8, left: 20, right: 20),
                child: Text(
                  description!,
                  textAlign: TextAlign.center,
                  style:
                      descriptionStyle ?? Theme.of(context).textTheme.bodyLarge,
                ),
              ),

            // Nút Hủy & Xác nhận
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                if (showCancelButton)
                  Expanded(
                    child: CustomButton(
                      padding: buttonPadding ??
                          const EdgeInsets.symmetric(horizontal: 12),
                      label: cancelText ?? "Cancel",
                      onPressed: onCancel ?? () => Get.back(),
                      isOutlined: true,
                    ),
                  ),
                if (showCancelButton) const SizedBox(width: 12),
                if (showAcceptButton)
                  Expanded(
                    child: CustomButton(
                      padding: buttonPadding ??
                          const EdgeInsets.symmetric(horizontal: 12),
                      label: acceptText ?? "Confirm",
                      onPressed: onAccept ?? () {},
                    ),
                  ),
              ],
            ).marginOnly(bottom: 12, left: 16, right: 16),
          ],
        ),
      ),
    );
  }
}

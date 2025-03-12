import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomRadio<T> extends StatelessWidget {
  final T value;
  final T groupValue;
  final String label;
  final String? subtitle;
  final String? iconPath;
  final ValueChanged<T?> onChanged;
  final Color activeColor;
  final Color textColor;
  final Color? selectedBackground;
  final double iconSize;
  final Color iconColor;
  final bool isVertical;
  final TextStyle? labelStyle; // Tuỳ chỉnh style cho label
  final TextStyle? subtitleStyle; // Tuỳ chỉnh style cho subtitle
  final EdgeInsets? padding;

  const CustomRadio({
    super.key,
    required this.value,
    required this.groupValue,
    required this.label,
    this.subtitle,
    this.iconPath,
    required this.onChanged,
    this.activeColor = Colors.grey,
    this.textColor = Colors.grey,
    this.selectedBackground,
    this.iconSize = 24.0,
    this.isVertical = false,
    this.iconColor = Colors.grey,
    this.labelStyle, // Nhận style riêng cho label
    this.subtitleStyle, // Nhận style riêng cho subtitle
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final bool isSelected = value == groupValue;

    return Container(
      padding: padding ?? EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: isSelected && selectedBackground != null
          ? BoxDecoration(
              color: selectedBackground,
              borderRadius: BorderRadius.circular(8),
            )
          : null,
      child: RadioListTile<T>(
        value: value,
        groupValue: groupValue,
        activeColor: activeColor,
        contentPadding: EdgeInsets.zero,
        dense: true,
        visualDensity: VisualDensity.compact,
        onChanged: onChanged,
        title: isVertical
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: _buildContent(),
              )
            : Row(
                children: _buildContent(),
              ),
      ),
    );
  }

  List<Widget> _buildContent() {
    return [
      if (iconPath != null)
        SvgPicture.asset(
          iconPath!,
          height: iconSize,
          color: iconColor,
        ),
      if (iconPath != null) const SizedBox(width: 6),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: labelStyle ??
                TextStyle(
                    color: textColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
          ),
          if (subtitle != null)
            Text(
              subtitle!,
              style: subtitleStyle ??
                  TextStyle(color: textColor.withOpacity(0.7), fontSize: 12),
            ),
        ],
      ),
    ];
  }
}

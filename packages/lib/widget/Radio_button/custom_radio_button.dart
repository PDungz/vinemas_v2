import 'package:flutter/material.dart';

class CustomRadioButton<T> extends StatefulWidget {
  final List<MapEntry<String, T>> options;
  final T? selectedValue;
  final ValueChanged<T> onChanged;
  final Color? selectedColor;
  final Color? unselectedBorderColor;
  final Color? selectedBorderColor;
  final Color? unselectedBackgroundColor;
  final Color? selectedBackgroundColor;
  final double borderWidth;
  final double borderRadius;
  final double spacing;
  final EdgeInsetsGeometry? containerPadding;
  final MainAxisAlignment mainAxisAlignment;
  final bool isHorizontal;
  final TextStyle? textStyle;

  const CustomRadioButton({
    super.key,
    required this.options,
    this.selectedValue,
    required this.onChanged,
    this.selectedColor,
    this.unselectedBorderColor,
    this.selectedBorderColor,
    this.unselectedBackgroundColor,
    this.selectedBackgroundColor,
    this.borderWidth = 1.0,
    this.borderRadius = 8.0,
    this.spacing = 8.0,
    this.containerPadding,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.isHorizontal = true,
    this.textStyle,
  });

  @override
  _CustomRadioButtonState<T> createState() => _CustomRadioButtonState<T>();
}

class _CustomRadioButtonState<T> extends State<CustomRadioButton<T>> {
  T? selected;

  @override
  void initState() {
    super.initState();
    selected = widget.selectedValue;
  }

  @override
  Widget build(BuildContext context) {
    final widgetRadio = widget.options.map((option) {
      bool isSelected = option.value == selected;

      return GestureDetector(
        onTap: () {
          setState(() {
            selected = option.value;
          });
          widget.onChanged(option.value);
        },
        child: Container(
          padding: widget.containerPadding ??
              const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: isSelected
                ? widget.selectedBackgroundColor ?? Colors.transparent
                : widget.unselectedBackgroundColor ?? Colors.transparent,
            border: Border.all(
              color: isSelected
                  ? widget.selectedBorderColor ?? Colors.blue
                  : widget.unselectedBorderColor ?? Colors.grey,
              width: widget.borderWidth,
            ),
            borderRadius: BorderRadius.circular(widget.borderRadius),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Radio<T>(
                value: option.value,
                groupValue: selected,
                activeColor: widget.selectedColor,
                fillColor: WidgetStateProperty.resolveWith<Color?>(
                  (states) {
                    if (states.contains(WidgetState.selected)) {
                      return widget.selectedColor;
                    }
                    return widget.unselectedBorderColor ?? Colors.grey;
                  },
                ),
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                visualDensity: const VisualDensity(
                  horizontal: VisualDensity.minimumDensity,
                  vertical: VisualDensity.minimumDensity,
                ),
                onChanged: (value) {
                  setState(() {
                    selected = value;
                  });
                  widget.onChanged(value as T);
                },
              ),
              const SizedBox(width: 8),
              Text(option.key, style: widget.textStyle),
            ],
          ),
        ),
      );
    }).toList();

    return widget.isHorizontal
        ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: widgetRadio,
          )
        : Column(
            mainAxisAlignment: widget.mainAxisAlignment,
            children: widgetRadio,
          );
  }
}

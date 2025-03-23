import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomDropDown<T> extends StatefulWidget {
  final List<MapEntry<String, T>> items;
  final String hint;
  final ValueChanged<T?>? onChanged;
  final T? value;
  final bool isExpanded;
  final String? svgIcon;
  final Color? dropdownColor;
  final TextStyle? style;
  final double elevation;
  final EdgeInsetsGeometry? padding;
  final InputDecoration? decoration;
  final AlignmentGeometry alignment;
  final double iconSize;
  final bool autofocus;
  final bool enabled;
  final bool enableFeedback;
  final FocusNode? focusNode;
  final FormFieldValidator<T>? validator;

  const CustomDropDown({
    super.key,
    required this.items,
    this.hint = "Select an option",
    this.onChanged,
    this.value,
    this.isExpanded = true,
    this.svgIcon,
    this.dropdownColor,
    this.style,
    this.elevation = 8.0,
    this.padding,
    this.decoration,
    this.alignment = AlignmentDirectional.centerStart,
    this.iconSize = 16,
    this.autofocus = false,
    this.enabled = true,
    this.enableFeedback = true,
    this.focusNode,
    this.validator,
  });

  @override
  // ignore: library_private_types_in_public_api
  _CustomDropDownState<T> createState() => _CustomDropDownState<T>();
}

class _CustomDropDownState<T> extends State<CustomDropDown<T>> {
  T? selectedValue;

  @override
  void initState() {
    super.initState();
    selectedValue = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding ?? EdgeInsets.zero,
      child: DropdownButtonFormField<T>(
        value: selectedValue,
        decoration: widget.decoration ??
            InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
            ),
        hint: Text(widget.hint),
        items: widget.items.map((entry) {
          return DropdownMenuItem<T>(
            value: entry.value,
            child: Text(entry.key),
          );
        }).toList(),
        onChanged: widget.enabled
            ? (newValue) {
                setState(() {
                  selectedValue = newValue;
                });
                if (widget.onChanged != null) {
                  widget.onChanged!(newValue);
                }
              }
            : null,
        isExpanded: widget.isExpanded,
        icon: widget.svgIcon != null
            ? SvgPicture.asset(widget.svgIcon!,
                width: widget.iconSize, height: widget.iconSize)
            : const Icon(Icons.arrow_drop_down),
        dropdownColor: widget.dropdownColor,
        style: widget.style,
        elevation: widget.elevation.toInt(),
        alignment: widget.alignment,
        iconSize: widget.iconSize,
        autofocus: widget.autofocus,
        focusNode: widget.focusNode,
        validator: widget.validator,
        enableFeedback: widget.enableFeedback,
      ),
    );
  }
}

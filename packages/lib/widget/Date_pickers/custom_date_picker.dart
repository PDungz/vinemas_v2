import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:packages/Core/common/enum/text_form_field.dart';
import 'package:packages/Core/utils/format_datetime.dart';
import 'package:packages/gen/assets.gen.dart';

class CustomDatePicker extends StatefulWidget {
  final String? label;
  final String hint;
  final Color primaryColor;
  final TextEditingController controller;
  final FocusNode focusNode;
  final bool obscureText;
  final int? maxLength;
  final TextCapitalization textCapitalization;
  final bool isEnabled;
  final TextInputAction textInputAction;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;
  final String? Function(String?)? validator;
  final bool autoFocus;
  final TextStyle? textStyle;
  final EdgeInsetsGeometry? contentPadding;
  final Color? fillColor;
  final bool isFilled;
  final BorderType borderType;
  final InputDecorationTheme? decorationTheme;
  final Color? textColor;
  final Color? labelColor;
  final Color? borderColor;
  final Color? hintTextColor;
  final TextStyle? hintStyle;
  final TextAlign textAlign;
  final bool readOnly; // Thêm thuộc tính readOnly
  final bool useDefaultDate;

  const CustomDatePicker({
    super.key,
    this.label,
    required this.hint,
    required this.controller,
    required this.focusNode,
    this.obscureText = false,
    this.maxLength,
    this.textCapitalization = TextCapitalization.none,
    this.isEnabled = true,
    this.textInputAction = TextInputAction.done,
    this.onChanged,
    this.onSubmitted,
    this.validator,
    this.autoFocus = false,
    this.textStyle,
    this.contentPadding,
    this.fillColor,
    this.isFilled = false,
    this.borderType = BorderType.outline,
    this.decorationTheme,
    this.textColor,
    this.labelColor,
    this.borderColor,
    this.hintTextColor,
    this.hintStyle,
    this.textAlign = TextAlign.left,
    required this.primaryColor,
    this.readOnly = true, // Khởi tạo readOnly
    this.useDefaultDate = true,
  });

  @override
  State<CustomDatePicker> createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  @override
  void initState() {
    // Gán ngày hiện tại vào controller khi widget được khởi tạo
    if (widget.useDefaultDate) {
      widget.controller.text = FormatDateTime.formatToDDMMYYYY(DateTime.now());
    } else {
      widget.controller.text = '--/--/----';
    }
    super.initState();
  }

  InputBorder getBorder(Color color, double width) {
    switch (widget.borderType) {
      case BorderType.outline:
        return OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: color, width: width),
        );
      case BorderType.underline:
        return UnderlineInputBorder(
          borderSide: BorderSide(color: color, width: width),
        );
      case BorderType.none:
        return InputBorder.none;
    }
  }

  // Function to open date picker and update the TextFormField
  void _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );

    if (picked != null) {
      setState(() {
        widget.controller.text = FormatDateTime.formatToDDMMYYYY(picked);
      });

      // Gọi callback onChanged nếu có
      if (widget.onChanged != null) {
        widget.onChanged!(widget.controller.text);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final InputBorder border =
        getBorder(widget.borderColor ?? widget.primaryColor, 1);
    final InputBorder focusedBorder = getBorder(widget.primaryColor, 2);
    final InputBorder enabledBorder = getBorder(widget.primaryColor, 1);
    final InputBorder disabledBorder =
        getBorder(widget.primaryColor.withOpacity(0.5), 1);

    final decoration = widget.decorationTheme ??
        InputDecorationTheme(
          labelStyle: TextStyle(
            color: widget.labelColor ?? widget.primaryColor,
          ),
          contentPadding: widget.contentPadding ??
              const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null)
          Padding(
            padding: const EdgeInsets.only(left: 4),
            child: Text(
              widget.label!,
              style: TextStyle(
                color: widget.labelColor ?? widget.primaryColor,
              ),
            ),
          ),
        TextFormField(
          controller: widget.controller,
          focusNode: widget.focusNode,
          keyboardType: TextInputType.datetime,
          maxLength: widget.maxLength,
          textCapitalization: widget.textCapitalization,
          enabled: widget.isEnabled,
          textInputAction: widget.textInputAction,
          autofocus: widget.autoFocus,
          onChanged: widget.onChanged,
          onFieldSubmitted: widget.onSubmitted,
          validator: widget.validator,
          textAlign: widget.textAlign,
          style: widget.textStyle?.copyWith(color: widget.textColor) ??
              TextStyle(
                  color: widget.textColor ?? theme.textTheme.bodyLarge?.color),
          decoration: InputDecoration(
            hintText: widget.hint,
            hintStyle: widget.hintStyle ??
                TextStyle(
                    color: widget.hintTextColor ?? theme.hintColor,
                    fontWeight: FontWeight.normal),
            suffixIcon: GestureDetector(
              onTap: () => _selectDate(context), // Show date picker on tap
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: SvgPicture.asset($AssetsIconsGen().iconApp.calendar),
              ),
            ),
            border: border,
            focusedBorder: focusedBorder,
            enabledBorder: enabledBorder,
            disabledBorder: disabledBorder,
            contentPadding: decoration.contentPadding,
            fillColor: widget.isFilled ? widget.fillColor : null,
            filled: widget.isFilled,
            counterText: '',
          ),
          readOnly: widget.readOnly, // Không cho phép nhập liệu trực tiếp
        ),
      ],
    );
  }
}

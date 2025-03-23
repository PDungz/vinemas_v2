import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:packages/Core/common/enum/text_form_field.dart';
import 'package:packages/gen/assets.gen.dart';
import 'package:packages/widget/Button/custom_icon_button.dart';

class CustomTextField extends StatefulWidget {
  final String? label;
  final String hint;
  final String? svgPrefixIcon;
  final String? svgSuffixIcon;
  final String? svgSuffixIconToggled;
  final Color primaryColor;
  final VoidCallback? onSuffixIconTap;
  final TextEditingController controller;
  final FocusNode focusNode;
  final TextInputType keyboardType;
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
  final bool showClearButton; // New property

  const CustomTextField({
    super.key,
    this.label,
    required this.hint,
    required this.controller,
    required this.focusNode,
    this.svgPrefixIcon,
    this.svgSuffixIcon,
    this.svgSuffixIconToggled,
    this.onSuffixIconTap,
    this.keyboardType = TextInputType.text,
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
    this.showClearButton = false, // New parameter default true
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool _obscureText;
  late bool _hasText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
    _hasText = widget.controller.text.isNotEmpty;
    widget.controller.addListener(_textChanged);
  }

  void _textChanged() {
    setState(() {
      _hasText = widget.controller.text.isNotEmpty;
    });
  }

  void toggleVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void clearText() {
    widget.controller.clear();
    setState(() {
      _hasText = false;
    });
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
          keyboardType: widget.keyboardType,
          obscureText: _obscureText,
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
            prefixIcon: widget.svgPrefixIcon != null
                ? Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: SvgPicture.asset(widget.svgPrefixIcon!),
                  )
                : null,
            suffixIcon: widget.showClearButton && _hasText
                ? CustomIconButton(
                    elevation: 0,
                    verticalPadding: 16,
                    horizontalPadding: 16,
                    svgPathUp: $AssetsIconsGen().iconApp.circleXmark,
                    onPressed: clearText)
                : (widget.svgSuffixIcon != null
                    ? GestureDetector(
                        onTap: widget.obscureText
                            ? toggleVisibility
                            : widget.onSuffixIconTap,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: SvgPicture.asset(
                            _obscureText
                                ? widget.svgSuffixIcon!
                                : widget.svgSuffixIconToggled ??
                                    widget.svgSuffixIcon!,
                          ),
                        ),
                      )
                    : null),
            border: border,
            focusedBorder: focusedBorder,
            enabledBorder: enabledBorder,
            disabledBorder: disabledBorder,
            contentPadding: decoration.contentPadding,
            fillColor: widget.isFilled ? widget.fillColor : null,
            filled: widget.isFilled,
            counterText: '',
          ),
        ),
      ],
    );
  }
}

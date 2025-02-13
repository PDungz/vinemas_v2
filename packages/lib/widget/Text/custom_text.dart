import 'package:flutter/material.dart';
import 'package:packages/Core/config/app_color.dart';
import 'package:packages/widget/Shadow/custom_shadow.dart';

class CustomText extends StatefulWidget {
  final String text;
  final int collapsedMaxLines; // Number of lines when collapsed
  final TextAlign textAlign;
  final double fontSize;
  final Color textColor;
  final FontWeight fontWeight;
  final FontStyle fontStyle;
  final double letterSpacing;
  final double wordSpacing;
  final TextDecoration decoration;
  final TextOverflow overflow;
  final TextDirection textDirection;
  final double lineHeight;
  final TextStyle? customStyle;
  final TextStyle? customStyleAction;
  final bool showTabIndent;
  final bool isExpandable; // Add parameter to decide if expandable

  const CustomText({
    super.key,
    required this.text,
    this.collapsedMaxLines = 3, // Default collapsed lines
    this.textAlign = TextAlign.start,
    this.fontSize = 14.0,
    this.textColor = Colors.black,
    this.fontWeight = FontWeight.normal,
    this.fontStyle = FontStyle.normal,
    this.letterSpacing = 0.0,
    this.wordSpacing = 0.0,
    this.decoration = TextDecoration.none,
    this.overflow = TextOverflow.ellipsis,
    this.textDirection = TextDirection.ltr,
    this.lineHeight = 1.2,
    this.customStyle,
    this.showTabIndent = false,
    this.isExpandable = true,
    this.customStyleAction, // Default is expandable
  });

  @override
  // ignore: library_private_types_in_public_api
  _CustomTextState createState() => _CustomTextState();
}

class _CustomTextState extends State<CustomText> {
  bool _expanded = false; // Default is collapsed

  @override
  Widget build(BuildContext context) {
    final displayText =
        widget.showTabIndent ? '    ${widget.text}' : widget.text;

    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: constraints.maxWidth,
              ),
              child: Text(
                displayText,
                maxLines: _expanded
                    ? null
                    : widget
                        .collapsedMaxLines, // Use collapsedMaxLines when collapsed
                overflow: _expanded
                    ? TextOverflow.visible // Remove ellipsis in expanded state
                    : TextOverflow.ellipsis, // Show ellipsis in collapsed state
                textAlign: widget.textAlign,
                textDirection: widget.textDirection,
                style: widget.customStyle ??
                    TextStyle(
                      fontSize: widget.fontSize,
                      color: widget.textColor,
                      fontWeight: widget.fontWeight,
                      fontStyle: widget.fontStyle,
                      letterSpacing: widget.letterSpacing,
                      wordSpacing: widget.wordSpacing,
                      decoration: widget.decoration,
                      height: widget.lineHeight,
                    ),
              ),
            ),
            // Show 'See more' or 'Collapse' button if expandable and text length is more than 50
            if (widget.isExpandable && widget.text.length > 50)
              Align(
                alignment:
                    Alignment.bottomRight, // Align button to the bottom right
                child: Padding(
                  padding: const EdgeInsets.only(top: 2),
                  child: GestureDetector(
                    onTap: _toggleExpansion,
                    child: CustomShadow(
                      spreadRadius: 1,
                      shadowOffset: Offset(0, 0),
                      shadowColor:
                          AppColor.buttonLinerOneColor.withOpacity(0.1),
                      child: Text(
                        _expanded
                            ? 'Collapse'
                            : 'See more', // Toggle between "Collapse" and "See more"
                        style: widget.customStyleAction ??
                            TextStyle(
                              color: Colors.white,
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }

  void _toggleExpansion() {
    setState(() {
      _expanded = !_expanded;
    });
  }
}

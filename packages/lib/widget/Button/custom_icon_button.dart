import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomIconButton extends StatefulWidget {
  final String svgPathUp;
  final String? svgPathDown; // Có thể null
  final VoidCallback onPressed;
  final double size;
  final Color? iconColor;
  final Color backgroundColor;
  final Color? borderColor;
  final double height;
  final double width;
  final double verticalPadding;
  final double horizontalPadding;
  final double borderRadius;
  final double elevation;
  final BoxShape shape;
  final Color splashColor;
  final Color highlightColor;
  final Color hoverColor;
  final Color? iconBackgroundColor;

  const CustomIconButton({
    super.key,
    required this.svgPathUp,
    this.svgPathDown,
    required this.onPressed,
    this.size = 24.0,
    this.iconColor,
    this.backgroundColor = Colors.transparent,
    this.borderColor,
    this.borderRadius = 8.0,
    this.elevation = 2.0,
    this.shape = BoxShape.rectangle,
    this.splashColor = Colors.transparent,
    this.highlightColor = Colors.transparent,
    this.hoverColor = Colors.transparent,
    this.height = 42,
    this.width = 42,
    this.verticalPadding = 4,
    this.horizontalPadding = 8,
    this.iconBackgroundColor,
  });

  @override
  _CustomIconButtonState createState() => _CustomIconButtonState();
}

class _CustomIconButtonState extends State<CustomIconButton> {
  bool _isPressed = false;

  void _toggleIcon() {
    if (widget.svgPathDown != null) {
      setState(() {
        _isPressed = !_isPressed;
      });
    }
    widget.onPressed();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: widget.backgroundColor,
      shape: widget.shape == BoxShape.circle
          ? const CircleBorder()
          : RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius),
              side: widget.borderColor != null
                  ? BorderSide(color: widget.borderColor!)
                  : BorderSide.none,
            ),
      elevation: widget.elevation,
      child: InkWell(
        onTap: _toggleIcon,
        splashColor: widget.splashColor,
        highlightColor: widget.highlightColor,
        hoverColor: widget.hoverColor,
        customBorder: widget.shape == BoxShape.circle
            ? const CircleBorder()
            : RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(widget.borderRadius),
              ),
        child: Container(
          width: widget.height,
          height: widget.width,
          padding: EdgeInsets.symmetric(
              vertical: widget.verticalPadding,
              horizontal: widget.horizontalPadding),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: widget.iconBackgroundColor ?? Colors.transparent,
            shape: widget.shape,
            borderRadius: widget.shape == BoxShape.rectangle
                ? BorderRadius.circular(widget.borderRadius)
                : null,
          ),
          child: SvgPicture.asset(
            _isPressed && widget.svgPathDown != null
                ? widget.svgPathDown!
                : widget.svgPathUp,
            width: widget.size + 16,
            height: widget.size + 16,
            color: widget.iconColor,
          ),
        ),
      ),
    );
  }
}

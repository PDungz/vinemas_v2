import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomDropdownMenu<T> extends StatefulWidget {
  final List<MapEntry<String, T>> itemsWithValues;
  final String hint;
  final ValueChanged<T?> onChanged;
  final T? initialValue;
  final bool isExpanded;
  final String? svgIcon;
  final Color borderColor;
  final double borderRadius;
  final EdgeInsetsGeometry padding;
  final TextStyle? textStyle;
  final double iconSize;
  final Color? iconColor;
  final double dropdownElevation;
  final Color dropdownBackgroundColor;

  const CustomDropdownMenu({
    super.key,
    required this.itemsWithValues,
    required this.hint,
    required this.onChanged,
    this.initialValue,
    this.isExpanded = true,
    this.svgIcon,
    this.borderColor = Colors.grey,
    this.borderRadius = 8.0,
    this.padding = const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
    this.textStyle,
    this.iconSize = 24.0,
    this.iconColor,
    this.dropdownElevation = 2.0,
    this.dropdownBackgroundColor = Colors.white,
  });

  @override
  _CustomDropdownMenuState<T> createState() => _CustomDropdownMenuState<T>();
}

class _CustomDropdownMenuState<T> extends State<CustomDropdownMenu<T>> {
  late TextEditingController _controller;
  late FocusNode _focusNode;
  OverlayEntry? _overlayEntry;
  List<MapEntry<String, T>> _filteredItems = [];
  T? selectedItem;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _focusNode = FocusNode();
    _filteredItems = widget.itemsWithValues;
    selectedItem = widget.initialValue;

    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        _showOverlay();
      } else {
        _removeOverlay();
      }
    });
  }

  void _showOverlay() {
    _overlayEntry = _createOverlayEntry();
    Overlay.of(context).insert(_overlayEntry!);
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  OverlayEntry _createOverlayEntry() {
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    var size = renderBox.size;
    var offset = renderBox.localToGlobal(Offset.zero);

    return OverlayEntry(
      builder: (context) => Positioned(
        left: offset.dx,
        top: offset.dy + size.height,
        width: size.width,
        child: Material(
          elevation: widget.dropdownElevation,
          borderRadius: BorderRadius.circular(widget.borderRadius),
          color: widget.dropdownBackgroundColor,
          child: ConstrainedBox(
            constraints: BoxConstraints(maxHeight: 200),
            child: ListView(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              children: _filteredItems.map((entry) {
                return ListTile(
                  title: Text(entry.key, style: widget.textStyle),
                  onTap: () {
                    setState(() {
                      selectedItem = entry.value;
                      _controller.text = entry.key;
                    });
                    widget.onChanged(entry.value);
                    _focusNode.unfocus();
                  },
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }

  void _filterItems(String query) {
    setState(() {
      _filteredItems = widget.itemsWithValues
          .where(
              (entry) => entry.key.toLowerCase().contains(query.toLowerCase()))
          .toList();
      _removeOverlay();
      _showOverlay();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: _controller,
          focusNode: _focusNode,
          decoration: InputDecoration(
            hintText: widget.hint,
            suffixIcon: widget.svgIcon != null
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SvgPicture.asset(
                      widget.svgIcon!,
                      width: widget.iconSize,
                      height: widget.iconSize,
                      color: widget.iconColor,
                    ),
                  )
                : const Icon(Icons.arrow_drop_down),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius),
              borderSide: BorderSide(color: widget.borderColor),
            ),
          ),
          onChanged: _filterItems,
        ),
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }
}

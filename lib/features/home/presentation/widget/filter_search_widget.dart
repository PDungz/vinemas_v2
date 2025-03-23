import 'package:flutter/material.dart';
import 'package:packages/Core/common/enum/text_form_field.dart';
import 'package:packages/widget/Date_pickers/custom_date_picker.dart';
import 'package:packages/widget/Layout/custom_layout_horizontal.dart';
import 'package:packages/widget/Layout/custom_layout_vertical.dart';
import 'package:vinemas_v1/core/config/app_color.dart';
import 'package:vinemas_v1/features/home/presentation/widget/genres_search_widget.dart';

class FilterSearchWidget extends StatefulWidget {
  final Function(List<int>) onGenresChanged;
  final Function(String) getDateForm;
  final Function(String) getDateTo;

  const FilterSearchWidget({
    super.key,
    required this.onGenresChanged,
    required this.getDateForm,
    required this.getDateTo,
  });

  @override
  State<FilterSearchWidget> createState() => _FilterSearchWidgetState();
}

class _FilterSearchWidgetState extends State<FilterSearchWidget> {
  late final TextEditingController _dateFromPickerController;
  late final FocusNode _dateFromPickerFocusNode;
  late final TextEditingController _dateToPickerController;
  late final FocusNode _dateToPickerFocusNode;

  @override
  void initState() {
    _dateFromPickerController = TextEditingController();
    _dateFromPickerFocusNode = FocusNode();
    _dateToPickerController = TextEditingController();
    _dateToPickerFocusNode = FocusNode();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomLayoutVertical(
      horizontalPadding: 0,
      topWidget: GenresSearchWidget(
        onSelectedGenresChanged: widget.onGenresChanged,
      ),
      bottomWidget: CustomLayoutHorizontal(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        spaceWith: 12,
        horizontalPadding: 0,
        leftWidget: Expanded(
          child: CustomDatePicker(
            labelColor: AppColor.primaryTextColor,
            hint: 'dd/MM/YYYY',
            hintTextColor: AppColor.secondaryTextColor,
            controller: _dateFromPickerController,
            focusNode: _dateFromPickerFocusNode,
            borderType: BorderType.underline,
            fillColor: AppColor.buttonLinerOneColor,
            primaryColor: AppColor.buttonLinerOneColor,
            textInputAction: TextInputAction.next,
            useDefaultDate: false,
            onChanged: (value) {
              widget.getDateForm(value);
            },
          ),
        ),
        rightWidget: Expanded(
          child: CustomDatePicker(
            labelColor: AppColor.primaryTextColor,
            hint: 'dd/MM/YYYY',
            hintTextColor: AppColor.secondaryTextColor,
            controller: _dateToPickerController,
            focusNode: _dateToPickerFocusNode,
            borderType: BorderType.underline,
            fillColor: AppColor.buttonLinerOneColor,
            primaryColor: AppColor.buttonLinerOneColor,
            textInputAction: TextInputAction.next,
            useDefaultDate: false,
            onChanged: (value) {
              widget.getDateTo(value);
            },
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _dateFromPickerController.dispose();
    _dateFromPickerFocusNode.dispose();
    _dateToPickerController.dispose();
    _dateToPickerFocusNode.dispose();
    super.dispose();
  }
}

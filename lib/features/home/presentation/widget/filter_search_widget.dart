import 'package:flutter/material.dart';
import 'package:packages/Core/common/enum/text_form_field.dart';
import 'package:vinemas_v1/core/config/app_color.dart';
import 'package:packages/widget/Date_pickers/custom_date_picker.dart';
import 'package:packages/widget/Layout/custom_layout_horizontal.dart';
import 'package:packages/widget/Layout/custom_layout_vertical.dart';
import 'package:vinemas_v1/features/home/presentation/widget/genres_search_widget.dart';

class FilterSearchWidget extends StatelessWidget {
  final TextEditingController dateFromController;
  final FocusNode dateFromFocusNode;
  final TextEditingController dateToController;
  final FocusNode dateToFocusNode;
  final Function(List<int>) onGenresChanged;

  const FilterSearchWidget({
    super.key,
    required this.dateFromController,
    required this.dateFromFocusNode,
    required this.dateToController,
    required this.dateToFocusNode,
    required this.onGenresChanged,
  });

  @override
  Widget build(BuildContext context) {
    return CustomLayoutVertical(
      horizontalPadding: 0,
      topWidget: GenresSearchWidget(
        onSelectedGenresChanged: onGenresChanged,
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
            controller: dateFromController,
            focusNode: dateFromFocusNode,
            borderType: BorderType.underline,
            fillColor: AppColor.buttonLinerOneColor,
            primaryColor: AppColor.buttonLinerOneColor,
            textInputAction: TextInputAction.next,
          ),
        ),
        rightWidget: Expanded(
          child: CustomDatePicker(
            labelColor: AppColor.primaryTextColor,
            hint: 'dd/MM/YYYY',
            hintTextColor: AppColor.secondaryTextColor,
            controller: dateToController,
            focusNode: dateToFocusNode,
            borderType: BorderType.underline,
            fillColor: AppColor.buttonLinerOneColor,
            primaryColor: AppColor.buttonLinerOneColor,
            textInputAction: TextInputAction.next,
          ),
        ),
      ),
    );
  }
}

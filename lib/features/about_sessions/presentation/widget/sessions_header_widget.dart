import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:packages/widget/Switch/custom_switch.dart';
import 'package:vinemas_v1/core/config/app_color.dart';
import 'package:vinemas_v1/core/utils/format_datetime.dart';
import 'package:vinemas_v1/gen/assets.gen.dart';
import 'package:vinemas_v1/l10n/generated/app_localizations.dart';

class SessionsHeaderWidget extends StatefulWidget {
  const SessionsHeaderWidget({super.key});

  @override
  State<SessionsHeaderWidget> createState() => _SessionsHeaderWidgetState();
}

class _SessionsHeaderWidgetState extends State<SessionsHeaderWidget> {
  late TextEditingController datePickerController;

  @override
  void initState() {
    super.initState();
    datePickerController = TextEditingController(
      text: FormatDateTime.formatToAbbreviated(DateTime.now()),
    );
  }

  @override
  void dispose() {
    datePickerController.dispose();
    super.dispose();
  }

  void _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );

    if (picked != null) {
      setState(() {
        datePickerController.text = FormatDateTime.formatToAbbreviated(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 104),
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: AppColor.secondaryColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          InkWell(
            onTap: () => _selectDate(context),
            child: Column(
              children: [
                SvgPicture.asset(
                  $AssetsIconsGen().iconApp.calendar,
                  height: 32,
                ),
                SizedBox(height: 2),
                Text(datePickerController.text),
              ],
            ),
          ),
          InkWell(
            child: Column(
              children: [
                SvgPicture.asset(
                  $AssetsIconsGen().iconApp.sort,
                  height: 32,
                ),
                SizedBox(height: 2),
                Text(AppLocalizations.of(context)!.keyword_sort_by),
              ],
            ),
          ),
          Column(
            children: [
              CustomSwitch(
                activeColor: AppColor.buttonLinerOneColor,
                inactiveColor: AppColor.accentColor,
                inactiveThumbColor: AppColor.primaryIconColor,
              ),
              SizedBox(height: 2),
              Text(AppLocalizations.of(context)!.keyword_by_cinema),
            ],
          ),
        ],
      ),
    );
  }
}

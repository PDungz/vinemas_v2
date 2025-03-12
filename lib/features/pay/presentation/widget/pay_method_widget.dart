import 'package:flutter/material.dart';
import 'package:packages/widget/Radio_button/custom_radio.dart';
import 'package:vinemas_v1/core/config/app_color.dart';
import 'package:vinemas_v1/features/pay/domain/enum/pay_enum.dart';
import 'package:vinemas_v1/gen/assets.gen.dart';

class PayMethodWidget extends StatefulWidget {
  const PayMethodWidget({super.key, required this.onSelectedMethod, required this.selectedMethod});

  final Function(dynamic) onSelectedMethod;
  final PayMethodEnum selectedMethod;

  @override
  _PayMethodWidgetState createState() => _PayMethodWidgetState();
}

class _PayMethodWidgetState extends State<PayMethodWidget> {


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Select payment method",
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(color: AppColor.secondaryTextColor),
        ),
        const SizedBox(height: 12),
        // Visa
        CustomRadio<PayMethodEnum>(
          value: PayMethodEnum.visa,
          groupValue: widget.selectedMethod,
          label: "Visa Card",
          iconPath: $AssetsIconsLogoPayGen().visaLogo,
          iconColor: AppColor.primaryIconColor,
          activeColor: AppColor.buttonLinerOneColor,
          textColor: AppColor.primaryIconColor,
          padding: EdgeInsets.symmetric(horizontal: 0, vertical: 4),
          onChanged: widget.onSelectedMethod,
        ),
        // MasterCard
        CustomRadio<PayMethodEnum>(
          value: PayMethodEnum.masterCard,
          groupValue: widget.selectedMethod,
          label: "Master Card",
          iconPath: $AssetsIconsLogoPayGen().masterCardLogo,
          iconColor: AppColor.primaryIconColor,
          activeColor: AppColor.buttonLinerOneColor,
          textColor: AppColor.primaryIconColor,
          padding: EdgeInsets.symmetric(horizontal: 0, vertical: 4),
          onChanged: widget.onSelectedMethod,
        ),
      ],
    );
  }
}

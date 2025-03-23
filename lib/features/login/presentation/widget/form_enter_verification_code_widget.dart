import 'package:flutter/material.dart';
import 'package:packages/Core/common/enum/text_form_field.dart';
import 'package:packages/widget/Button/custom_button.dart';
import 'package:packages/widget/Shadow/custom_shadow.dart';
import 'package:packages/widget/Text_field/custom_text_field.dart';
import 'package:vinemas_v1/core/config/app_color.dart';
import 'package:vinemas_v1/l10n/generated/app_localizations.dart';

class FormEnterVerificationCodeWidget extends StatefulWidget {
  const FormEnterVerificationCodeWidget({
    super.key,
    required this.onTap,
    required this.isLoading,
    required this.message,
    required this.onResend,
  });

  final Function({
    required int oneCode,
    required int twoCode,
    required int threeCode,
    required int fourCode,
    required int fiveCode,
    required int sixCode,
  }) onTap;

  final Function() onResend;
  final bool isLoading;
  final String message;

  @override
  State<FormEnterVerificationCodeWidget> createState() =>
      _FormEnterVerificationCodeWidgetState();
}

class _FormEnterVerificationCodeWidgetState
    extends State<FormEnterVerificationCodeWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late final List<TextEditingController> _codeControllers;
  late final List<FocusNode> _focusNodes;

  String errorMessage = '';

  @override
  void initState() {
    _codeControllers = List.generate(6, (_) => TextEditingController());
    _focusNodes = List.generate(6, (_) => FocusNode());
    super.initState();
  }

  @override
  void dispose() {
    for (var controller in _codeControllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 60),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Form(
            key: _formKey,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children:
                  List.generate(6, (index) => _buildCodeInputField(index)),
            ),
          ),
          widget.message.isEmpty
              ? SizedBox(height: 8)
              : Padding(
                  padding: EdgeInsets.only(top: 8),
                  child: Text(
                    widget.message,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: AppColor.errorColor),
                  ),
                ),
          errorMessage.isEmpty
              ? SizedBox(height: 8)
              : Padding(
                  padding: EdgeInsets.only(top: 8),
                  child: Text(
                    errorMessage,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: AppColor.errorColor),
                  ),
                ),
          const SizedBox(height: 20),
          CustomShadow(
            blurRadius: 20,
            child: CustomButton(
              isLoading: widget.isLoading,
              backgroundColor: AppColor.buttonLinerOneColor,
              label: AppLocalizations.of(context)!.keyword_verify_now,
              onPressed: () {
                if (_formKey.currentState?.validate() ?? false) {
                  widget.onTap(
                    oneCode: int.parse(_codeControllers[0].text),
                    twoCode: int.parse(_codeControllers[1].text),
                    threeCode: int.parse(_codeControllers[2].text),
                    fourCode: int.parse(_codeControllers[3].text),
                    fiveCode: int.parse(_codeControllers[4].text),
                    sixCode: int.parse(_codeControllers[5].text),
                  );
                }
              },
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(top: 8, bottom: 36),
            child: Align(
              alignment: Alignment.center,
              child: GestureDetector(
                onTap: widget.onResend,
                child: Text.rich(
                  TextSpan(
                    text: AppLocalizations.of(context)!
                        .keyword_don_t_your_receive_any_code,
                    children: [
                      WidgetSpan(child: SizedBox(width: 8)),
                      TextSpan(
                        text: AppLocalizations.of(context)!.keyword_resend_code,
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall
                            ?.copyWith(color: AppColor.buttonLinerOneColor),
                      ),
                    ],
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall
                        ?.copyWith(color: AppColor.secondaryTextColor),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCodeInputField(int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: SizedBox(
        width: 40,
        child: CustomTextField(
          hint: '',
          controller: _codeControllers[index],
          focusNode: _focusNodes[index],
          borderType: BorderType.underline,
          fillColor: AppColor.buttonLinerOneColor,
          primaryColor: AppColor.buttonLinerOneColor,
          keyboardType: TextInputType.number,
          maxLength: 1,
          textAlign: TextAlign.center,
          contentPadding: const EdgeInsets.all(8),
          textInputAction:
              index < 5 ? TextInputAction.next : TextInputAction.done,
          onChanged: (value) {
            if (value.isNotEmpty && index < 5) {
              FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
            } else if (value.isEmpty && index > 0) {
              FocusScope.of(context).requestFocus(_focusNodes[index - 1]);
            }
          },
          validator: (value) {
            if (value == null || value.isEmpty) {
              setState(() {
                errorMessage = AppLocalizations.of(context)!
                    .error_verification_error_all_fields;
              });
              return '';
            }
            setState(() {
              errorMessage = '';
            });
            return null;
          },
        ),
      ),
    );
  }
}

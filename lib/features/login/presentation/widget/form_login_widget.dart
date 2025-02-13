import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:packages/Core/common/enum/text_form_field.dart';
import 'package:packages/widget/Button/custom_button.dart';
import 'package:packages/widget/Shadow/custom_shadow.dart';
import 'package:packages/widget/Text_field/custom_text_field.dart';
import 'package:vinemas_v1/core/config/app_color.dart';
import 'package:vinemas_v1/core/config/app_router.dart';
import 'package:vinemas_v1/core/utils/validators.dart';
import 'package:vinemas_v1/gen/assets.gen.dart';
import 'package:vinemas_v1/l10n/generated/app_localizations.dart';

class FormLoginWidget extends StatefulWidget {
  final Function({required String username, required String password}) onTap;
  final bool isLoading;
  final String message;

  const FormLoginWidget({
    super.key,
    required this.onTap,
    required this.isLoading,
    required this.message,
  });

  @override
  State<FormLoginWidget> createState() => _FormLoginWidgetState();
}

class _FormLoginWidgetState extends State<FormLoginWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late final TextEditingController _emailController;

  late final FocusNode _emailFocusNode;

  late final TextEditingController _passwordController;

  late final FocusNode _passwordFocusNode;

  @override
  void initState() {
    _emailController = TextEditingController();
    _emailFocusNode = FocusNode();
    _passwordController = TextEditingController();
    _passwordFocusNode = FocusNode();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          CustomTextField(
            label: AppLocalizations.of(context)!.keyword_email,
            labelColor: AppColor.primaryTextColor,
            hint: AppLocalizations.of(context)!.keyword_enter_email,
            hintTextColor: AppColor.secondaryTextColor,
            svgPrefixIcon: $AssetsIconsGen().iconApp.person,
            controller: _emailController,
            focusNode: _emailFocusNode,
            borderType: BorderType.underline,
            fillColor: AppColor.buttonLinerOneColor,
            primaryColor: AppColor.buttonLinerOneColor,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            validator: Validators.email(
              requiredError:
                  AppLocalizations.of(context)!.error_username_required,
              errorText: AppLocalizations.of(context)!.error_username_invalid,
            ).call,
          ),
          SizedBox(height: 20),
          CustomTextField(
            label: AppLocalizations.of(context)!.keyword_password,
            labelColor: AppColor.primaryTextColor,
            hint: AppLocalizations.of(context)!.keyword_enter_password,
            hintTextColor: AppColor.secondaryTextColor,
            svgPrefixIcon: $AssetsIconsGen().iconApp.lock,
            svgSuffixIcon: $AssetsIconsGen().iconApp.eye,
            svgSuffixIconToggled: $AssetsIconsGen().iconApp.eyeSlash,
            primaryColor: AppColor.buttonLinerOneColor,
            controller: _passwordController,
            focusNode: _passwordFocusNode,
            fillColor: AppColor.buttonLinerOneColor,
            textInputAction: TextInputAction.next,
            obscureText: true,
            borderType: BorderType.underline,
            validator: Validators.password(
                    minLengthError:
                        AppLocalizations.of(context)!.error_password_min_length,
                    requiredError:
                        AppLocalizations.of(context)!.error_password_required)
                .call,
          ),
          SizedBox(height: 12),
          widget.message.isEmpty
              ? SizedBox()
              : Padding(
                  padding: EdgeInsets.only(bottom: 12),
                  child: Text(widget.message,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(color: AppColor.errorColor)),
                ),
          Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: () => Get.toNamed(ConfigRoute.forgotPasswordPage),
              child: Text(
                AppLocalizations.of(context)!.keyword_forgot_password,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: AppColor.buttonLinerOneColor),
              ),
            ),
          ),
          SizedBox(height: 12),
          CustomShadow(
            blurRadius: 20,
            child: CustomButton(
              isLoading: widget.isLoading,
              backgroundColor: AppColor.buttonLinerOneColor,
              label: AppLocalizations.of(context)!.keyword_login,
              onPressed: () {
                if (_formKey.currentState?.validate() ?? false) {
                  widget.onTap(
                    username: _emailController.text,
                    password: _passwordController.text,
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

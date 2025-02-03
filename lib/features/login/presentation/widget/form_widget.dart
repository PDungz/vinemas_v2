import 'package:flutter/material.dart';
import 'package:packages/Core/common/enum/text_form_field.dart';
import 'package:packages/widget/Button/custom_button.dart';
import 'package:packages/widget/Text_field/custom_text_field.dart';
import 'package:vinemas_v1/core/config/app_color.dart';
import 'package:vinemas_v1/core/utils/validators.dart';
import 'package:vinemas_v1/gen/assets.gen.dart';
import 'package:vinemas_v1/l10n/generated/app_localizations.dart';

class FormWidget extends StatefulWidget {
  final Function({required String username, required String password}) onTap;
  final bool isLoading;
  final String messager;

  const FormWidget({
    super.key,
    required this.onTap,
    required this.isLoading,
    required this.messager,
  });

  @override
  State<FormWidget> createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late final TextEditingController _usernameController;

  late final FocusNode _usernameFocusNode;

  late final TextEditingController _passwordController;

  late final FocusNode _passwordFocusNode;

  @override
  void initState() {
    _usernameController = TextEditingController();
    _usernameFocusNode = FocusNode();
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
            label: AppLocalizations.of(context)!.keyword_username,
            labelColor: AppColor.primaryTextColor,
            hint: AppLocalizations.of(context)!.keyword_enter_username,
            hintTextColor: AppColor.secondaryTextColor,
            svgPrefixIcon: $AssetsIconsGen().iconApp.person,
            controller: _usernameController,
            focusNode: _usernameFocusNode,
            borderType: BorderType.underline,
            fillColor: AppColor.buttonLinerOneColor,
            primaryColor: AppColor.buttonLinerOneColor,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            validator: Validators.email(
                    requiredError:
                        AppLocalizations.of(context)!.error_username_required,
                    errorText:
                        AppLocalizations.of(context)!.error_username_invalid)
                .call,
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
          widget.messager.isEmpty
              ? SizedBox()
              : Padding(
                  padding: EdgeInsets.only(bottom: 12),
                  child: Text(widget.messager,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(color: AppColor.errorColor)),
                ),
          Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: () {},
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
          CustomButton(
              backgroundColor: AppColor.buttonLinerOneColor,
              label: AppLocalizations.of(context)!.keyword_login,
              onPressed: () {
                if (_formKey.currentState?.validate() ?? false) {
                  widget.onTap(
                    username: _usernameController.text,
                    password: _passwordController.text,
                  );
                }
              }),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:packages/Core/common/enum/text_form_field.dart';
import 'package:packages/widget/Button/custom_button.dart';
import 'package:packages/widget/Shadow/custom_shadow.dart';
import 'package:packages/widget/Text_field/custom_text_field.dart';
import 'package:vinemas_v1/core/common/enum/process_status.dart';
import 'package:vinemas_v1/core/config/app_color.dart';
import 'package:vinemas_v1/core/config/app_router.dart';
import 'package:vinemas_v1/core/utils/validators.dart';
import 'package:vinemas_v1/features/login/presentation/bloc/bloc/user_bloc.dart';
import 'package:vinemas_v1/gen/assets.gen.dart';
import 'package:vinemas_v1/l10n/generated/app_localizations.dart';

class FormLoginWidget extends StatefulWidget {
  const FormLoginWidget({
    super.key,
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
    return BlocListener<UserBloc, UserState>(
      listener: (context, state) {
        if (state is UserLoginWithEmailPasswordState &&
            state.processStatus == ProcessStatus.success) {
          Get.toNamed(ConfigRoute.homePage);
        }
      },
      child: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
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
                    errorText:
                        AppLocalizations.of(context)!.error_username_invalid,
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
                          minLengthError: AppLocalizations.of(context)!
                              .error_password_min_length,
                          requiredError: AppLocalizations.of(context)!
                              .error_password_required)
                      .call,
                ),
                SizedBox(height: 12),
                Padding(
                  padding: EdgeInsets.only(bottom: 12),
                  child: Text(
                      state is UserLoginWithEmailPasswordState
                          ? state.message ?? ''
                          : '',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: state is UserLoginWithEmailPasswordState &&
                                  state.processStatus == ProcessStatus.success
                              ? AppColor.successColor
                              : AppColor.errorColor)),
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
                    isLoading: state is UserLoginWithEmailPasswordState &&
                        state.processStatus == ProcessStatus.loading,
                    backgroundColor: AppColor.buttonLinerOneColor,
                    label: AppLocalizations.of(context)!.keyword_login,
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        BlocProvider.of<UserBloc>(context).add(
                            UserLoginWithEmailPasswordEvent(
                                email: _emailController.text,
                                password: _passwordController.text));
                      }
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

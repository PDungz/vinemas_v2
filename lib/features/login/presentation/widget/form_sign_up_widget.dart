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
import 'package:vinemas_v1/features/login/domain/entity/user.dart';
import 'package:vinemas_v1/features/login/presentation/bloc/bloc/user_bloc.dart';
import 'package:vinemas_v1/gen/assets.gen.dart';
import 'package:vinemas_v1/l10n/generated/app_localizations.dart';

class FormSignUpWidget extends StatefulWidget {
  const FormSignUpWidget({
    super.key,
  });

  @override
  State<FormSignUpWidget> createState() => _FormSignUpWidgetState();
}

class _FormSignUpWidgetState extends State<FormSignUpWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late final TextEditingController _fullNameController;

  late final FocusNode _fullNameFocusNode;

  late final TextEditingController _emailController;

  late final FocusNode _emailFocusNode;

  late final TextEditingController _passwordController;

  late final FocusNode _passwordFocusNode;

  late final TextEditingController _confirmPasswordController;

  late final FocusNode _confirmPasswordFocusNode;

  @override
  void initState() {
    _fullNameController = TextEditingController();
    _fullNameFocusNode = FocusNode();
    _emailController = TextEditingController();
    _emailFocusNode = FocusNode();
    _passwordController = TextEditingController();
    _passwordFocusNode = FocusNode();
    _confirmPasswordController = TextEditingController();
    _confirmPasswordFocusNode = FocusNode();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserBloc, UserState>(
      listener: (context, state) {
        if (state is UserRegisterWithEmailPasswordState &&
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
                  label: AppLocalizations.of(context)!.keyword_full_name,
                  labelColor: AppColor.primaryTextColor,
                  hint: AppLocalizations.of(context)!.keyword_enter_full_name,
                  hintTextColor: AppColor.secondaryTextColor,
                  svgPrefixIcon: $AssetsIconsGen().iconApp.person,
                  controller: _fullNameController,
                  focusNode: _fullNameFocusNode,
                  borderType: BorderType.underline,
                  fillColor: AppColor.buttonLinerOneColor,
                  primaryColor: AppColor.buttonLinerOneColor,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  validator: Validators.requiredWithFieldName(
                          AppLocalizations.of(context)!.keyword_full_name)
                      .call,
                ),
                SizedBox(height: 20),
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
                        AppLocalizations.of(context)!.error_email_required,
                    errorText:
                        AppLocalizations.of(context)!.error_email_invalid,
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
                SizedBox(height: 20),
                CustomTextField(
                  label: AppLocalizations.of(context)!.keyword_confirm_password,
                  labelColor: AppColor.primaryTextColor,
                  hint: AppLocalizations.of(context)!
                      .keyword_enter_confirm_password,
                  hintTextColor: AppColor.secondaryTextColor,
                  svgPrefixIcon: $AssetsIconsGen().iconApp.lock,
                  svgSuffixIcon: $AssetsIconsGen().iconApp.eye,
                  svgSuffixIconToggled: $AssetsIconsGen().iconApp.eyeSlash,
                  primaryColor: AppColor.buttonLinerOneColor,
                  controller: _confirmPasswordController,
                  focusNode: _confirmPasswordFocusNode,
                  fillColor: AppColor.buttonLinerOneColor,
                  textInputAction: TextInputAction.next,
                  obscureText: true,
                  borderType: BorderType.underline,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppLocalizations.of(context)!
                          .error_password_required;
                    }
                    if (value.length < 6) {
                      return AppLocalizations.of(context)!
                          .error_password_min_length;
                    }
                    if (value != _passwordController.text) {
                      return AppLocalizations.of(context)!
                          .error_password_not_match;
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                Padding(
                  padding: EdgeInsets.only(bottom: 12),
                  child: Text(
                      state is UserRegisterWithEmailPasswordState
                          ? state.message ?? ''
                          : '',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: state is UserRegisterWithEmailPasswordState &&
                                  state.processStatus == ProcessStatus.success
                              ? AppColor.successColor
                              : AppColor.errorColor)),
                ),
                SizedBox(height: 12),
                CustomShadow(
                  blurRadius: 20,
                  child: CustomButton(
                    isLoading: state is UserRegisterWithEmailPasswordState &&
                        state.processStatus == ProcessStatus.loading,
                    backgroundColor: AppColor.buttonLinerOneColor,
                    label: AppLocalizations.of(context)!.keyword_sign_up,
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        BlocProvider.of<UserBloc>(context).add(
                          UserRegisterWithEmailPasswordEvent(
                            user: User(
                                fullName: _fullNameController.text,
                                email: _emailController.text),
                            email: _emailController.text,
                            password: _passwordController.text,
                          ),
                        );
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

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:packages/Core/common/enum/text_form_field.dart';
import 'package:packages/widget/Button/custom_button.dart';
import 'package:packages/widget/Shadow/custom_shadow.dart';
import 'package:packages/widget/Snackbar/custom_snackbar.dart';
import 'package:packages/widget/Text_field/custom_text_field.dart';
import 'package:vinemas_v1/core/common/enum/process_status.dart';
import 'package:vinemas_v1/core/config/app_color.dart';
import 'package:vinemas_v1/core/config/app_router.dart';
import 'package:vinemas_v1/core/utils/validators.dart';
import 'package:vinemas_v1/features/login/presentation/bloc/bloc/user_bloc.dart';
import 'package:vinemas_v1/gen/assets.gen.dart';
import 'package:vinemas_v1/l10n/generated/app_localizations.dart';

class FormForgotPasswordWidget extends StatefulWidget {
  const FormForgotPasswordWidget({
    super.key,
  });

  @override
  State<FormForgotPasswordWidget> createState() =>
      _FormForgotPasswordWidgetState();
}

class _FormForgotPasswordWidgetState extends State<FormForgotPasswordWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late final TextEditingController _emailController;

  late final FocusNode _emailFocusNode;

  @override
  void initState() {
    _emailController = TextEditingController();
    _emailFocusNode = FocusNode();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserBloc, UserState>(
      listener: (context, state) {
        if (state is resetPasswordState &&
            state.processStatus == ProcessStatus.success) {
          CustomSnackbar.show(
            title: 'Notification',
            message: state.message ?? "",
            iconPath: $AssetsIconsGen().iconApp.bell,
            iconColor: AppColor.primaryTextColor,
            backgroundColor: state.processStatus == ProcessStatus.success
                ? Colors.green
                : Colors.red,
            snackPosition: SnackPosition.TOP, // Hiển thị từ trên xuống
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            borderRadius: 10,
            duration: const Duration(seconds: 2),
            isDismissible: true,
            forwardAnimationCurve: Curves.easeOutBack,
          );
          Get.toNamed(ConfigRoute.loginPage);
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
                        AppLocalizations.of(context)!.error_email_required,
                    errorText:
                        AppLocalizations.of(context)!.error_email_invalid,
                  ).call,
                ),
                SizedBox(height: 24),
                CustomShadow(
                  blurRadius: 20,
                  child: CustomButton(
                    isLoading: state is UserRegisterWithEmailPasswordState &&
                        state.processStatus == ProcessStatus.loading,
                    backgroundColor: AppColor.buttonLinerOneColor,
                    label: AppLocalizations.of(context)!.keyword_reset_password,
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        BlocProvider.of<UserBloc>(context).add(
                          resetPasswordEvent(
                            email: _emailController.text.trim(),
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

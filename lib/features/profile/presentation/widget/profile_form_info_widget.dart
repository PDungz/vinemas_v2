import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:packages/Core/common/enum/text_form_field.dart';
import 'package:packages/widget/Button/custom_button.dart';
import 'package:packages/widget/Date_pickers/custom_date_picker.dart';
import 'package:packages/widget/Layout/custom_layout_horizontal.dart';
import 'package:packages/widget/Radio_button/custom_radio_button.dart';
import 'package:packages/widget/Shadow/custom_shadow.dart';
import 'package:packages/widget/Text_field/custom_text_field.dart';
import 'package:vinemas_v1/core/common/enum/gender.dart';
import 'package:vinemas_v1/core/common/enum/process_status.dart';
import 'package:vinemas_v1/core/config/app_color.dart';
import 'package:vinemas_v1/core/utils/format_datetime.dart';
import 'package:vinemas_v1/core/utils/validators.dart';
import 'package:vinemas_v1/features/login/domain/entity/user.dart';
import 'package:vinemas_v1/features/profile/presentation/bloc/profile_bloc/profile_bloc.dart';
import 'package:vinemas_v1/l10n/generated/app_localizations.dart';

class ProfileFormInfoWidget extends StatefulWidget {
  const ProfileFormInfoWidget({super.key});

  @override
  State<ProfileFormInfoWidget> createState() => _ProfileFormInfoWidgetState();
}

class _ProfileFormInfoWidgetState extends State<ProfileFormInfoWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late final TextEditingController _fullNameController;

  late final FocusNode _fullNameFocusNode;

  late final TextEditingController _dateOfBirthController;

  late final FocusNode _dateOfBirthFocusNode;

  late final TextEditingController _phoneNumberController;

  late final FocusNode _phoneNumberFocusNode;

  late final TextEditingController _emailController;

  late final FocusNode _emailFocusNode;

  late final TextEditingController _locationController;

  late final FocusNode _locationFocusNode;

  late Gender _genderValue = Gender.unknown;

  @override
  void initState() {
    _fullNameController = TextEditingController();
    _fullNameFocusNode = FocusNode();
    _dateOfBirthController = TextEditingController();
    _dateOfBirthFocusNode = FocusNode();
    _phoneNumberController = TextEditingController();
    _phoneNumberFocusNode = FocusNode();
    _emailController = TextEditingController();
    _emailFocusNode = FocusNode();
    _locationController = TextEditingController();
    _locationFocusNode = FocusNode();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppLocalizations.of(context)!.keyword_information,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(color: AppColor.secondaryTextColor),
              ),
              BlocListener<ProfileBloc, ProfileState>(
                listener: (context, state) {
                  if (state is ProfileGetUserState) {
                    if (state.status == ProcessStatus.success) {
                      _fullNameController.text = state.user?.fullName ?? '';
                      _dateOfBirthController.text =
                          FormatDateTime.formatToDDMMYYYY(
                              state.user?.dateOfBirth ?? DateTime.now());
                      _phoneNumberController.text =
                          state.user?.phoneNumber ?? '';
                      _emailController.text = state.user?.email ?? '';
                      _locationController.text = state.user?.address ?? '';
                      setState(() {
                        _genderValue = state.user?.gender ?? Gender.unknown;
                      });
                    }
                  }
                },
                child: BlocBuilder<ProfileBloc, ProfileState>(
                  builder: (context, state) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Column(
                        children: [
                          _buildInput(
                              context: context,
                              title: AppLocalizations.of(context)!
                                  .keyword_full_name,
                              hint: AppLocalizations.of(context)!
                                  .keyword_enter_full_name,
                              controller: _fullNameController,
                              focusNode: _fullNameFocusNode,
                              validator: Validators.requiredWithFieldName(
                                      AppLocalizations.of(context)!
                                          .keyword_full_name)
                                  .call),
                          CustomLayoutHorizontal(
                            horizontalPadding: 0,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            leftWidget: Padding(
                              padding: const EdgeInsets.only(right: 24),
                              child: Text(
                                AppLocalizations.of(context)!
                                    .keyword_date_of_birth,
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ),
                            rightWidget: Expanded(
                              child: CustomDatePicker(
                                hint: AppLocalizations.of(context)!
                                    .keyword_enter_full_name,
                                hintTextColor: AppColor.secondaryTextColor,
                                controller: _dateOfBirthController,
                                focusNode: _dateOfBirthFocusNode,
                                borderType: BorderType.outline,
                                fillColor: AppColor.buttonLinerOneColor,
                                primaryColor: AppColor.buttonLinerOneColor,
                                textInputAction: TextInputAction.next,
                              ),
                            ),
                          ),
                          _buildInput(
                            context: context,
                            title: AppLocalizations.of(context)!
                                .keyword_phone_number,
                            hint: AppLocalizations.of(context)!
                                .keyword_enter_phone_number,
                            controller: _phoneNumberController,
                            focusNode: _phoneNumberFocusNode,
                            validator: Validators.phoneNumber(
                                    requiredError: AppLocalizations.of(context)!
                                        .error_phone_required,
                                    lengthError: AppLocalizations.of(context)!
                                        .error_phone_invalid_length,
                                    patternError: AppLocalizations.of(context)!
                                        .error_phone_invalid_pattern)
                                .call,
                          ),
                          _buildInput(
                            context: context,
                            title: AppLocalizations.of(context)!.keyword_email,
                            hint: AppLocalizations.of(context)!
                                .keyword_enter_email,
                            controller: _emailController,
                            focusNode: _emailFocusNode,
                            validator: Validators.email(
                              requiredError: AppLocalizations.of(context)!
                                  .error_email_required,
                              errorText: AppLocalizations.of(context)!
                                  .error_email_invalid,
                            ).call,
                          ),
                          if (state is ProfileGetUserState &&
                              state.status == ProcessStatus.success)
                            CustomLayoutHorizontal(
                              horizontalPadding: 0,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              leftWidget: Padding(
                                padding: const EdgeInsets.only(right: 24),
                                child: Text(
                                  AppLocalizations.of(context)!.keyword_gender,
                                  style: Theme.of(context).textTheme.labelLarge,
                                ),
                              ),
                              rightWidget: Expanded(
                                  child: CustomRadioButton<Gender>(
                                options: [
                                  MapEntry("Nam", Gender.male),
                                  MapEntry("Nữ", Gender.female),
                                  MapEntry("Khác", Gender.unknown),
                                ],
                                selectedValue: _genderValue,
                                onChanged: (value) {
                                  setState(() {
                                    _genderValue = value;
                                  });
                                },
                                selectedColor: AppColor.buttonLinerOneColor,
                                unselectedBorderColor:
                                    AppColor.secondaryTextColor,
                                selectedBorderColor:
                                    AppColor.buttonLinerOneColor,
                                containerPadding: EdgeInsets.symmetric(
                                    horizontal: 4,
                                    vertical: 4), // Padding tùy chỉnh
                                textStyle:
                                    Theme.of(context).textTheme.labelMedium,
                              )),
                            ),
                          _buildInput(
                            context: context,
                            title:
                                AppLocalizations.of(context)!.keyword_location,
                            hint:
                                AppLocalizations.of(context)!.keyword_location,
                            controller: _locationController,
                            focusNode: _locationFocusNode,
                            validator: Validators.required(
                                    errorText: AppLocalizations.of(context)!
                                        .error_validate)
                                .call,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  BlocBuilder<ProfileBloc, ProfileState>(
                    builder: (context, state) {
                      return CustomShadow(
                        child: CustomButton(
                            isLoading: state is ProfileUpdateUserState &&
                                state.status == ProcessStatus.loading,
                            label: AppLocalizations.of(context)!.keyword_save,
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                context.read<ProfileBloc>().add(
                                      ProfileUpdateUserEvent(
                                        user: UserEntity(
                                          email: _emailController.text,
                                          fullName: _fullNameController.text,
                                          phoneNumber:
                                              _phoneNumberController.text,
                                          address: _locationController.text,
                                          dateOfBirth:
                                              FormatDateTime.parseFromDDMMYYYY(
                                                  _dateOfBirthController.text),
                                          gender: _genderValue,
                                        ),
                                        imageFile:
                                            state is ProfileUpdateUserState
                                                ? (state).imageFile
                                                : null,
                                      ),
                                    );
                              }
                            }),
                      );
                    },
                  ),
                ],
              ),
              SizedBox(height: 8),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildInput({
    required BuildContext context,
    required String title,
    required String hint,
    required TextEditingController controller,
    required FocusNode focusNode,
    required String? Function(String?)? validator,
  }) =>
      CustomLayoutHorizontal(
        horizontalPadding: 0,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        leftWidget: Padding(
          padding: const EdgeInsets.only(right: 24),
          child: Text(
            title,
            style: Theme.of(context).textTheme.labelLarge,
          ),
        ),
        rightWidget: Expanded(
          child: CustomTextField(
            hint: hint,
            hintTextColor: AppColor.secondaryTextColor,
            controller: controller, // Corrected
            focusNode: focusNode, // Corrected
            borderType: BorderType.outline,
            fillColor: AppColor.buttonLinerOneColor,
            primaryColor: AppColor.buttonLinerOneColor,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            textStyle: Theme.of(context).textTheme.bodyMedium,
            validator: validator,
          ),
        ),
      );
}

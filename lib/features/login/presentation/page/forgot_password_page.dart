import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:packages/widget/Button/custom_icon_button.dart';
import 'package:packages/widget/Layout/custom_layout.dart';
import 'package:vinemas_v1/core/config/app_color.dart';
import 'package:vinemas_v1/core/config/app_router.dart';
import 'package:vinemas_v1/features/login/presentation/bloc/bloc/user_bloc.dart';
import 'package:vinemas_v1/features/login/presentation/widget/form_forgot_password_widget.dart';
import 'package:vinemas_v1/features/login/presentation/widget/form_title_widget.dart';
import 'package:vinemas_v1/gen/assets.gen.dart';
import 'package:vinemas_v1/l10n/generated/app_localizations.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserBloc(),
      child: Scaffold(
        body: SafeArea(
          child: CustomLayout(
            appBar: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomIconButton(
                    onPressed: () => Get.back(),
                    shape: BoxShape.circle,
                    backgroundColor: AppColor.secondaryColor,
                    svgPath: $AssetsIconsGen().iconApp.back,
                  ),
                  CustomIconButton(
                    onPressed: () => Get.toNamed(ConfigRoute.homePage),
                    shape: BoxShape.circle,
                    backgroundColor: AppColor.secondaryColor,
                    svgPath: $AssetsIconsGen().iconApp.home,
                  ),
                ],
              ),
            ),
            body: Padding(
              padding: EdgeInsets.only(top: 32),
              child: Container(
                margin: EdgeInsets.only(top: 40),
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    FormTitleWidget(
                      title:
                          AppLocalizations.of(context)!.keyword_forgot_password,
                      description: AppLocalizations.of(context)!
                          .keyword_forgot_password_des,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    FormForgotPasswordWidget(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

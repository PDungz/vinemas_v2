import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:packages/widget/Button/custom_icon_button.dart';
import 'package:packages/widget/Layout/custom_layout.dart';
import 'package:vinemas_v1/core/common/enum/process_status.dart';
import 'package:vinemas_v1/core/config/app_color.dart';
import 'package:vinemas_v1/core/config/app_router.dart';
import 'package:vinemas_v1/features/login/domain/entity/user.dart';
import 'package:vinemas_v1/features/login/presentation/bloc/bloc/user_bloc.dart';
import 'package:vinemas_v1/features/login/presentation/widget/form_sign_up_widget.dart';
import 'package:vinemas_v1/features/login/presentation/widget/title_sign_up_widget.dart';
import 'package:vinemas_v1/gen/assets.gen.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

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
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TitleSignUpWidget(),
                      BlocBuilder<UserBloc, UserState>(
                        builder: (context, state) {
                          return FormSignUpWidget(
                            isLoading: state
                                    is UserRegisterWithEmailPasswordState &&
                                state.processStatus == ProcessStatus.loading,
                            message: state is UserRegisterWithEmailPasswordState
                                ? state.message ?? ''
                                : '',
                            onTap: ({
                              required String fullName,
                              required String email,
                              required String password,
                            }) {
                              BlocProvider.of<UserBloc>(context).add(
                                UserRegisterWithEmailPasswordEvent(
                                  user: User(fullName: fullName, email: email),
                                  email: email,
                                  password: password,
                                ),
                              );
                              if (state is UserRegisterWithEmailPasswordState &&
                                  state.processStatus ==
                                      ProcessStatus.success) {
                                Get.toNamed(ConfigRoute.homePage);
                              }
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

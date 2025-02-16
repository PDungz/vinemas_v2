import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:packages/widget/Button/custom_icon_button.dart';
import 'package:packages/widget/Layout/custom_layout.dart';
import 'package:vinemas_v1/core/common/enum/process_status.dart';
import 'package:vinemas_v1/core/config/app_color.dart';
import 'package:vinemas_v1/core/config/app_router.dart';
import 'package:vinemas_v1/features/login/presentation/bloc/bloc/user_bloc.dart';
import 'package:vinemas_v1/features/login/presentation/widget/form_login_widget.dart';
import 'package:vinemas_v1/features/login/presentation/widget/other_sign_in_widget.dart';
import 'package:vinemas_v1/features/login/presentation/widget/sign_up_login_widget.dart';
import 'package:vinemas_v1/gen/assets.gen.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserBloc>(
      create: (_) => UserBloc(), // Thêm UserBloc tại đây
      child: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          return Scaffold(
            body: SafeArea(
              child: CustomLayout(
                isLoading: state is loginWithThirdPartyState &&
                    state.processStatus == ProcessStatus.loading,
                appBar: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 16.0),
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
                  padding: EdgeInsets.only(top: 42),
                  child: SingleChildScrollView(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 24.0),
                            child: SizedBox(
                              child: SvgPicture.asset(
                                $AssetsSvgGen().appIcon,
                                height: 128,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 42),
                            child: Column(
                              children: [
                                FormLoginWidget(),
                                SizedBox(height: 12),
                                OtherSignInWidget(),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 32),
                            child: SignUpLoginWidget(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

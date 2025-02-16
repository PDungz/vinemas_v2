import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:packages/widget/Snackbar/custom_snackbar.dart';
import 'package:vinemas_v1/core/common/enum/process_status.dart';
import 'package:vinemas_v1/core/config/app_color.dart';
import 'package:vinemas_v1/core/config/app_router.dart';
import 'package:vinemas_v1/features/login/domain/entity/user.dart';
import 'package:vinemas_v1/features/login/presentation/bloc/bloc/user_bloc.dart';
import 'package:vinemas_v1/features/login/presentation/widget/social_network_widget.dart';
import 'package:vinemas_v1/gen/assets.gen.dart';
import 'package:vinemas_v1/l10n/generated/app_localizations.dart';

class OtherSignInWidget extends StatelessWidget {
  const OtherSignInWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserBloc, UserState>(
      listener: (context, state) {
        if (state is loginWithThirdPartyState) {
          // Hiển thị thông báo dạng toast
          if (state.processStatus == ProcessStatus.success) {
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
            ); // Hiệu ứng xuất hiện)
          }

          // Điều hướng nếu đăng nhập thành công
          if (state.processStatus == ProcessStatus.success) {
            Get.toNamed(ConfigRoute.homePage);
          }
        }
      },
      child: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 12, bottom: 16),
                child: Text(
                  AppLocalizations.of(context)!.keyword_or_sign_in_with,
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge
                      ?.copyWith(color: AppColor.secondaryTextColor),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SocialNetworkWidget(
                      onTap: () {
                        BlocProvider.of<UserBloc>(context).add(
                            loginWithThirdPartyEvent(
                                method: 'google', user: User(email: '')));
                      },
                      socialNetworkWidget:
                          $AssetsImagesSocialNetworkGen().google.path,
                      title: "Google"),
                  SizedBox(width: 24),
                  SocialNetworkWidget(
                      onTap: () {
                        BlocProvider.of<UserBloc>(context).add(
                            loginWithThirdPartyEvent(
                                method: 'facebook', user: User(email: '')));
                      },
                      socialNetworkWidget:
                          $AssetsImagesSocialNetworkGen().facebook.path,
                      title: "Facebook"),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}

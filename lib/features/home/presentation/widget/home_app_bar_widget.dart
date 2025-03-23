import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:packages/widget/App_bar/custom_app_bar.dart';
import 'package:packages/widget/Button/custom_button.dart';
import 'package:packages/widget/Shadow/custom_shadow.dart';
import 'package:vinemas_v1/core/config/app_color.dart';
import 'package:vinemas_v1/core/config/app_router.dart';
import 'package:vinemas_v1/features/login/presentation/bloc/bloc/user_bloc.dart';
import 'package:vinemas_v1/gen/assets.gen.dart';
import 'package:vinemas_v1/l10n/generated/app_localizations.dart';

class HomeAppBarWidget extends StatelessWidget {
  const HomeAppBarWidget({super.key});

  @override
  Widget build(BuildContext context) => BlocListener<UserBloc, UserState>(
        listener: (context, state) {},
        child: CustomAppBar(
          leading: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
            ),
            child: CustomShadow(
              blurRadius: 16,
              child: SvgPicture.asset(
                $AssetsSvgGen().logo,
              ),
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                onTap: () {},
                child: Row(
                  children: [
                    SvgPicture.asset($AssetsSvgGen().location),
                    SizedBox(width: 8),
                    Text(
                      AppLocalizations.of(context)!.keyword_country,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () {},
                child: Row(
                  children: [
                    SvgPicture.asset($AssetsSvgGen().language),
                    SizedBox(width: 8),
                    Text(
                      AppLocalizations.of(context)!.keyword_locale,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                ),
              )
            ],
          ),
          actions: [
            BlocBuilder<UserBloc, UserState>(
              builder: (context, state) {
                return CustomShadow(
                  child: CustomButton(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 12,
                    ),
                    backgroundColor: AppColor.buttonLinerOneColor,
                    label: state is isUserLoggedInState &&
                            state.isUserLoggedIn == true
                        ? AppLocalizations.of(context)!.keyword_profile
                        : AppLocalizations.of(context)!.keyword_login,
                    onPressed: () {
                      if (state is isUserLoggedInState &&
                          state.isUserLoggedIn == true) {
                        Get.toNamed(ConfigRoute.profilePage);
                      } else {
                        Get.toNamed(ConfigRoute.loginPage);
                      }
                    },
                  ),
                );
              },
            ),
          ],
        ),
      );
}

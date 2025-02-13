import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:packages/widget/Button/custom_icon_button.dart';
import 'package:packages/widget/Layout/custom_layout.dart';
import 'package:packages/widget/Shadow/custom_shadow.dart';
import 'package:vinemas_v1/core/config/app_color.dart';
import 'package:vinemas_v1/core/config/app_router.dart';
import 'package:vinemas_v1/features/login/presentation/widget/form_enter_verification_code_widget.dart';
import 'package:vinemas_v1/gen/assets.gen.dart';
import 'package:vinemas_v1/l10n/generated/app_localizations.dart';

class EnterVerificationCodePage extends StatelessWidget {
  const EnterVerificationCodePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomLayout(
          backgroundWidget: Image.asset(
            $AssetsImagesBackgroundGen().cover.path,
            fit: BoxFit.contain,
          ),
          appBar: Padding(
            padding: const EdgeInsets.all(16),
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
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 54),
                Padding(
                  padding: const EdgeInsets.only(top: 48, bottom: 20),
                  child: CustomShadow(
                    blurRadius: 60,
                    borderRadius: 0,
                    shadowColor: AppColor.buttonLinerOneColor.withOpacity(0.2),
                    child: Center(
                      child: Text(
                        AppLocalizations.of(context)!
                            .keyword_enter_verification_code,
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: FormEnterVerificationCodeWidget(
                    isLoading: false,
                    message: '',
                    onTap: ({
                      required int oneCode,
                      required int twoCode,
                      required int threeCode,
                      required int fourCode,
                      required int fiveCode,
                      required int sixCode,
                    }) {},
                    onResend: () {},
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

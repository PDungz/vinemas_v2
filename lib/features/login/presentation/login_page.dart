import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vinemas_v1/features/login/presentation/widget/form_widget.dart';
import 'package:vinemas_v1/features/login/presentation/widget/other_sign_in_widget.dart';
import 'package:vinemas_v1/features/login/presentation/widget/sign_up_widget.dart';
import 'package:vinemas_v1/gen/assets.gen.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 32.0),
                  child: SizedBox(
                    child: SvgPicture.asset(
                      $AssetsSvgGen().appIcon,
                      height: 128,
                    ),
                  ),
                ),
                Column(
                  children: [
                    FormWidget(
                        onTap: (
                            {required String username,
                            required String password}) {},
                        isLoading: false,
                        messager: ""),
                    SizedBox(height: 12),
                    OtherSignInWidget(onGoogle: () {}, onFacebook: () {}),
                  ],
                ),
                SignUpWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

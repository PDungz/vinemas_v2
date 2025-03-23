import 'package:flutter/material.dart';
import 'package:packages/Core/config/app_color.dart';
import 'package:packages/gen/fonts.gen.dart';

class ThemeApp {
  static ThemeData darkTheme() {
    return ThemeData(
      // fontFamily
      fontFamily: FontFamily.roboto,

      // IconTheme
      iconTheme: const IconThemeData(
        color: AppColor.primaryIconColor,
      ),

      // Brightness
      brightness: Brightness.dark,
      primaryColor: Colors.orange,

      // ColorScheme
      colorScheme: ColorScheme.fromSwatch(
        primarySwatch: Colors.orange,
        brightness: Brightness.dark,
      ).copyWith(
        secondary: Colors.orangeAccent,
      ),

      // Scaffold
      scaffoldBackgroundColor: AppColor.primaryColor,

      // AppBarTheme
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColor.secondaryColor,
        titleTextStyle: TextStyle(
          color: AppColor.primaryTextColor,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
        iconTheme: IconThemeData(
          color: AppColor.secondaryTextColor,
        ),
      ),

      // TextTheme
      textTheme: TextTheme(
        displayLarge: TextStyle(
          color: AppColor.primaryTextColor,
          fontSize: 57,
          fontWeight: FontWeight.bold,
        ),
        displayMedium: TextStyle(
          color: AppColor.primaryTextColor,
          fontSize: 45,
          fontWeight: FontWeight.bold,
        ),
        displaySmall: TextStyle(
          color: AppColor.primaryTextColor,
          fontSize: 36,
          fontWeight: FontWeight.bold,
        ),
        headlineLarge: TextStyle(
          color: AppColor.primaryTextColor,
          fontSize: 32,
          fontWeight: FontWeight.bold,
        ),
        headlineMedium: TextStyle(
          color: AppColor.primaryTextColor,
          fontSize: 28,
          fontWeight: FontWeight.bold,
        ),
        headlineSmall: TextStyle(
          color: AppColor.primaryTextColor,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
        titleLarge: TextStyle(
          color: AppColor.primaryTextColor,
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
        titleMedium: TextStyle(
          color: AppColor.primaryTextColor,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
        titleSmall: TextStyle(
          color: AppColor.primaryTextColor,
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
        labelLarge: TextStyle(
          color: AppColor.primaryTextColor,
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
        labelMedium: TextStyle(
          color: AppColor.primaryTextColor,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
        labelSmall: TextStyle(
          color: AppColor.primaryTextColor,
          fontSize: 11,
          fontWeight: FontWeight.bold,
        ),
        bodyLarge: TextStyle(
          color: AppColor.primaryTextColor,
          fontSize: 16,
          fontWeight: FontWeight.normal,
        ),
        bodyMedium: TextStyle(
          color: AppColor.primaryTextColor,
          fontSize: 14,
          fontWeight: FontWeight.normal,
        ),
        bodySmall: TextStyle(
          color: AppColor.primaryTextColor,
          fontSize: 12,
          fontWeight: FontWeight.normal,
        ),
      ),

      // TabBarTheme
      tabBarTheme: TabBarTheme(
        indicatorColor: AppColor.buttonLinerOneColor,
        unselectedLabelStyle: TextStyle(
          color: AppColor.secondaryTextColor,
          fontSize: 16,
          fontWeight: FontWeight.w700,
        ),
        labelStyle: TextStyle(
            color: AppColor.buttonLinerOneColor,
            fontSize: 16,
            fontWeight: FontWeight.w700,
            shadows: [
              Shadow(
                blurRadius: 16,
                color: AppColor.buttonLinerOneColor.withOpacity(.5),
              )
            ]),
        indicatorSize: TabBarIndicatorSize.tab,
        dividerColor: Colors.transparent,
      ),

      // ElevatedButtonThemeData
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(
            AppColor.buttonLinerOneColor,
          ), // Màu nền
          foregroundColor: WidgetStateProperty.all(AppColor.primaryTextColor),
          elevation: WidgetStateProperty.all(5),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          textStyle: WidgetStateProperty.all(const TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 18,
          )),

          padding: WidgetStateProperty.all(
            const EdgeInsets.symmetric(
              horizontal: 30,
              vertical: 16,
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:shop_sphere/core/utils/app_color.dart';
import 'package:shop_sphere/core/utils/app_styles.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData.light().copyWith(
    bottomNavigationBarTheme:
        const BottomNavigationBarThemeData(backgroundColor: Colors.white),
    primaryColor: AppColors.primaryColor,
    scaffoldBackgroundColor: AppColors.backgroundColor,
    appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.backgroundColor,
        centerTitle: true,
        titleTextStyle: AppStyles.text26BoldBlack),
  );
  static final ThemeData darkTheme = ThemeData.dark().copyWith(
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.secondaryDarkColor,
        type: BottomNavigationBarType.fixed),
    primaryColor: AppColors.primaryColor,
    scaffoldBackgroundColor: AppColors.backgroundDarkColor,
    appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.secondaryDarkColor,
        centerTitle: true,
        titleTextStyle: AppStyles.text26BoldWhite),
  );
  static bool isLightTheme(BuildContext context) =>
      Theme.of(context).brightness == Brightness.light;
}

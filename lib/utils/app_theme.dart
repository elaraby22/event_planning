import 'package:event_planning/utils/app_colors.dart';
import 'package:event_planning/utils/app_styles.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    dialogBackgroundColor: AppColors.whiteColor,
    appBarTheme: const AppBarTheme(backgroundColor: AppColors.whiteColor),
    textTheme: TextTheme(
        bodySmall: AppStyles.bold14Black,
        bodyMedium: AppStyles.medium16Black,
        bodyLarge: AppStyles.bold20Black),
    scaffoldBackgroundColor: AppColors.whiteColor,
    primaryColor: AppColors.primaryLight,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        showUnselectedLabels: true,
        unselectedLabelStyle: AppStyles.bold12White,
        selectedLabelStyle: AppStyles.bold12White,
        elevation: 0),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: AppColors.primaryLight,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
            side: const BorderSide(color: AppColors.whiteColor, width: 4))),
  );

  static final ThemeData darkTheme = ThemeData(
    dialogBackgroundColor: AppColors.primaryLight,
    appBarTheme: const AppBarTheme(backgroundColor: AppColors.primaryDark),
    textTheme: TextTheme(
        bodySmall: AppStyles.medium14White,
        bodyMedium: AppStyles.medium16White,
        bodyLarge: AppStyles.medium20White),
    scaffoldBackgroundColor: AppColors.primaryDark,
    primaryColor: AppColors.primaryDark,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        showUnselectedLabels: true,
        unselectedLabelStyle: AppStyles.bold12White,
        selectedLabelStyle: AppStyles.bold12White,
        elevation: 0),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.primaryDark,
        shape: StadiumBorder(
            side: BorderSide(color: AppColors.whiteColor, width: 4))),
  );
}

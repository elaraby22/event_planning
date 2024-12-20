import 'package:event_planning/utils/app_colors.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
      appBarTheme: AppBarTheme(backgroundColor: AppColors.primaryLight));
  static final ThemeData darkTheme = ThemeData(
      appBarTheme: AppBarTheme(backgroundColor: AppColors.primaryDark));
}

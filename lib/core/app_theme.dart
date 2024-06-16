import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_text_styles.dart';

class AppThemes {
  // Light theme
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.primaryColor,
    focusColor: AppColors.primaryColor,
    scaffoldBackgroundColor: AppColors.lightGreyColor,
    textTheme: AppTextStyles.textTheme,
    appBarTheme: const AppBarTheme(
      actionsIconTheme: IconThemeData(color: AppColors.lightGreyColor),
      iconTheme: IconThemeData(color: AppColors.lightGreyColor),
      titleTextStyle: TextStyle(color: AppColors.lightGreyColor, fontSize: 34),
      backgroundColor: AppColors.primaryColor,
      centerTitle: true,
      elevation: 0.5,
    ),
    snackBarTheme: const SnackBarThemeData(
        backgroundColor: AppColors.darkColor,
        contentTextStyle: TextStyle(color: AppColors.lightGreyColor)),
    cardTheme: CardTheme(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0))),
    radioTheme: RadioThemeData(
        fillColor: WidgetStateProperty.all(AppColors.primaryColor)),
    textSelectionTheme:
        const TextSelectionThemeData(cursorColor: AppColors.primaryColor),
    textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
            foregroundColor:
                WidgetStateProperty.all(AppColors.lightGreyColor))),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
        foregroundColor: AppColors.lightGreyColor,
        backgroundColor: AppColors.primaryColor),
    inputDecorationTheme: InputDecorationTheme(
      focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.primaryColor, width: 2),
          borderRadius: BorderRadius.circular(14)),
      border: OutlineInputBorder(
          borderSide: const BorderSide(width: 2),
          borderRadius: BorderRadius.circular(14)),
      floatingLabelStyle: const TextStyle(color: AppColors.primaryColor),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryColor,
        foregroundColor: AppColors.lightGreyColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14.0),
        ),
      ),
    ),
  );

  // Dark theme
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.darkColor,
    scaffoldBackgroundColor: AppColors.lessdarkColor,
    textTheme: AppTextStyles.textTheme,
    appBarTheme: const AppBarTheme(
      actionsIconTheme: IconThemeData(color: AppColors.lightGreyColor),
      iconTheme: IconThemeData(color: AppColors.lightGreyColor),
      titleTextStyle: TextStyle(color: AppColors.lightGreyColor, fontSize: 34),
      color: AppColors.darkColor,
      centerTitle: true,
      elevation: 0.5,
    ),
    snackBarTheme: const SnackBarThemeData(
        backgroundColor: AppColors.darkColor,
        contentTextStyle: TextStyle(color: AppColors.lightGreyColor)),
    cardTheme: CardTheme(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0))),
    radioTheme: RadioThemeData(
        fillColor: WidgetStateProperty.all(AppColors.primaryColor)),
    textSelectionTheme:
        const TextSelectionThemeData(cursorColor: AppColors.primaryColor),
    textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
            foregroundColor: WidgetStateProperty.all(AppColors.lightGreyColor),
            elevation: WidgetStateProperty.all(0.0))),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
        foregroundColor: AppColors.lightGreyColor,
        backgroundColor: AppColors.primaryColor),
    inputDecorationTheme: InputDecorationTheme(
      focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.primaryColor, width: 2),
          borderRadius: BorderRadius.circular(14)),
      border: OutlineInputBorder(
          borderSide: const BorderSide(width: 2),
          borderRadius: BorderRadius.circular(14)),
      floatingLabelStyle: const TextStyle(color: AppColors.lightGreyColor),
    ),
    dialogTheme: const DialogTheme(backgroundColor: AppColors.lessdarkColor),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14.0),
        ),
      ),
    ),
  );
}

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/app_strings.dart';
import '../../../../core/enums/theme_enum.dart';

abstract class LocalSettingsStorage {
  ThemeEnum setTheme(ThemeEnum deviceTheme);
  void setLocale(Locale locale);
}

class LocalSettingsStorageImp implements LocalSettingsStorage {
  SharedPreferences sharedPreferences;
  LocalSettingsStorageImp(this.sharedPreferences);

  @override
  ThemeEnum setTheme(ThemeEnum deviceTheme) {
    if (deviceTheme == ThemeEnum.lightTheme) {
      sharedPreferences.setString(AppStrings.initTheme, AppStrings.lightTheme);
      return ThemeEnum.lightTheme;
    } else if (deviceTheme == ThemeEnum.darkTheme) {
      sharedPreferences.setString(AppStrings.initTheme, AppStrings.darkTheme);
      return ThemeEnum.darkTheme;
    } else {
      sharedPreferences.setString(AppStrings.initTheme, AppStrings.systemTheme);
      return ThemeEnum.systemTheme;
    }
  }

  @override
  void setLocale(Locale locale) {
    sharedPreferences.setString(AppStrings.setLang, locale.languageCode);
  }
}

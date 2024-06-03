// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/app_strings.dart';
import '../../../../core/enums/theme_enum.dart';

abstract class LocalSettingsStorage {
  ThemeEnum setTheme(ThemeEnum deviceTheme);
}

class LocalSettingsStorageImp implements LocalSettingsStorage {
  SharedPreferences sharedPreferences;
  LocalSettingsStorageImp(this.sharedPreferences);

  @override
  ThemeEnum setTheme(ThemeEnum deviceTheme) {
    if (deviceTheme == ThemeEnum.lightTheme) {
      sharedPreferences.setString(AppStrings.initTheme, AppStrings.lightTheme);
      debugPrint(sharedPreferences.getString(AppStrings.initTheme));

      return ThemeEnum.lightTheme;
    } else if (deviceTheme == ThemeEnum.darkTheme) {
      sharedPreferences.setString(AppStrings.initTheme, AppStrings.darkTheme);
      debugPrint(sharedPreferences.getString(AppStrings.initTheme));

      return ThemeEnum.darkTheme;
    } else {
      sharedPreferences.setString(AppStrings.initTheme, AppStrings.systemTheme);
      debugPrint(sharedPreferences.getString(AppStrings.initTheme));

      return ThemeEnum.systemTheme;
    }
  }
}

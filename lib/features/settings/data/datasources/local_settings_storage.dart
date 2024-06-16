import 'package:notesapp/core/enums/language_enum.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/app_strings.dart';
import '../../../../core/enums/theme_enum.dart';

abstract class LocalSettingsStorage {
  void setTheme(ThemeEnum deviceTheme);
  void setLocale(LangEnum deviceLang);
}

class LocalSettingsStorageImp implements LocalSettingsStorage {
  SharedPreferences sharedPreferences;
  LocalSettingsStorageImp(this.sharedPreferences);

  @override
  void setTheme(ThemeEnum deviceTheme) {
    if (deviceTheme == ThemeEnum.lightTheme) {
      sharedPreferences.setString(AppStrings.initTheme, AppStrings.lightTheme);
    } else if (deviceTheme == ThemeEnum.darkTheme) {
      sharedPreferences.setString(AppStrings.initTheme, AppStrings.darkTheme);
    } else {
      sharedPreferences.setString(AppStrings.initTheme, AppStrings.systemTheme);
    }
  }

  @override
  void setLocale(LangEnum deviceLang) {
    if (deviceLang == LangEnum.englishLang) {
      sharedPreferences.setString(AppStrings.setLang, AppStrings.setEnglish);
    } else if (deviceLang == LangEnum.arabicLang) {
      sharedPreferences.setString(AppStrings.setLang, AppStrings.setArabic);
    } else {
      sharedPreferences.setString(AppStrings.setLang, AppStrings.setLang);
    }
  }
}

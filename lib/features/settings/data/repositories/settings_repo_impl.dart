import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import '../../../../core/app_failures.dart';
import '../../../../core/enums/theme_enum.dart';
import '../../domain/repositories/settings_repo.dart';
import '../datasources/local_settings_storage.dart';

class SettingsRepoImpl implements SettingsRepo {
  LocalSettingsStorage localSettingsStorage;
  SettingsRepoImpl(this.localSettingsStorage);

  @override
  Either<Failure, ThemeEnum> setTheme(ThemeEnum deviceTheme) {
    try {
      var themeSelector = localSettingsStorage.setTheme(deviceTheme);
      return right(themeSelector);
    } catch (e) {
      return left(Failure("Error in setting theme"));
    }
  }

  @override
  Either<Failure, Unit> setLocale(Locale locale) {
    try {
      localSettingsStorage.setLocale(locale);
      return right(unit);
    } catch (e) {
      return left(Failure("Error in setting Language"));
    }
  }
}

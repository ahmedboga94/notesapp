import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import '../../../../core/app_failures.dart';
import '../../../../core/enums/theme_enum.dart';

abstract class SettingsRepo {
  Either<Failure, ThemeEnum> setTheme(ThemeEnum deviceTheme);
  Either<Failure, Unit> setLocale(Locale locale);
}

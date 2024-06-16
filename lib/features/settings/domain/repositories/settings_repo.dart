import 'package:dartz/dartz.dart';

import '../../../../core/app_failures.dart';
import '../../../../core/enums/language_enum.dart';
import '../../../../core/enums/theme_enum.dart';

abstract class SettingsRepo {
  Either<Failure, Unit> setTheme(ThemeEnum deviceTheme);
  Either<Failure, Unit> setLocale(LangEnum deviceLang);
}

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import '../../../../core/app_failures.dart';
import '../repositories/settings_repo.dart';

class SetLocaleUseCase {
  final SettingsRepo settingsRepo;
  SetLocaleUseCase(this.settingsRepo);

  Either<Failure, Unit> call(Locale locale) {
    return settingsRepo.setLocale(locale);
  }
}

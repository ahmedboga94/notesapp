import 'package:dartz/dartz.dart';
import 'package:notesapp/core/enums/language_enum.dart';

import '../../../../core/app_failures.dart';
import '../repositories/settings_repo.dart';

class SetLocaleUseCase {
  final SettingsRepo settingsRepo;
  SetLocaleUseCase(this.settingsRepo);

  Either<Failure, Unit> call(LangEnum deviceLang) {
    return settingsRepo.setLocale(deviceLang);
  }
}

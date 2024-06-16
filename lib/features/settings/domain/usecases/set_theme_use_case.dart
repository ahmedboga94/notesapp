import 'package:dartz/dartz.dart';

import '../../../../core/app_failures.dart';
import '../../../../core/enums/theme_enum.dart';
import '../repositories/settings_repo.dart';

class SetThemeUseCase {
  final SettingsRepo settingsRepo;
  SetThemeUseCase(this.settingsRepo);

  Either<Failure, Unit> call(ThemeEnum deviceTheme) {
    return settingsRepo.setTheme(deviceTheme);
  }
}

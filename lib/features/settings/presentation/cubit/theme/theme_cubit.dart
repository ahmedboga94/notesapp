import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/app_failures.dart';
import '../../../../../core/app_strings.dart';
import '../../../../../core/di.dart';
import '../../../../../core/enums/theme_enum.dart';
import '../../../domain/usecases/set_theme_use_case.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit(this.setThemeUseCase) : super(SystemThemeState());

  final SetThemeUseCase setThemeUseCase;

  void setTheme(ThemeEnum deviceTheme) {
    var themeSelect = setThemeUseCase.call(deviceTheme);
    themeSelect
        .fold((failSetTheme) => emit(FailureSelectedThemeState(failSetTheme)),
            (successSetTheme) {
      switch (deviceTheme) {
        case ThemeEnum.lightTheme:
          emit(LightThemeState());
        case ThemeEnum.darkTheme:
          emit(DarkThemeState());
        default:
          emit(SystemThemeState());
      }
    });
  }

  void getTheme() {
    String? themeKey = di<SharedPreferences>().getString(AppStrings.initTheme);

    switch (themeKey) {
      case AppStrings.lightTheme:
        emit(LightThemeState());
      case AppStrings.darkTheme:
        emit(DarkThemeState());
      default:
        emit(SystemThemeState());
    }
  }
}

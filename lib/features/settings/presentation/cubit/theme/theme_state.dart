part of 'theme_cubit.dart';

abstract class ThemeState {
  final ThemeEnum? selectedTheme;
  ThemeState({this.selectedTheme});
}

class SystemThemeState extends ThemeState {
  SystemThemeState({super.selectedTheme = ThemeEnum.systemTheme});
}

class LightThemeState extends ThemeState {
  LightThemeState({super.selectedTheme = ThemeEnum.lightTheme});
}

class DarkThemeState extends ThemeState {
  DarkThemeState({super.selectedTheme = ThemeEnum.darkTheme});
}

class FailureSelectedThemeState extends ThemeState {
  Failure errorMsg;
  FailureSelectedThemeState(this.errorMsg);
}

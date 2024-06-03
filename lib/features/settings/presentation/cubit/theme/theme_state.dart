part of 'theme_cubit.dart';

abstract class ThemeState {
  final ThemeEnum? selectedTheme;
  ThemeState({this.selectedTheme});
}

final class SystemThemeState extends ThemeState {
  SystemThemeState({super.selectedTheme = ThemeEnum.systemTheme});
}

final class LightThemeState extends ThemeState {
  LightThemeState({super.selectedTheme = ThemeEnum.lightTheme});
}

final class DarkThemeState extends ThemeState {
  DarkThemeState({super.selectedTheme = ThemeEnum.darkTheme});
}

final class FailureSelectedThemeState extends ThemeState {
  Failure errorMsg;
  FailureSelectedThemeState(this.errorMsg);
}

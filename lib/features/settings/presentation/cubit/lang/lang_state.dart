part of 'lang_cubit.dart';

abstract class LangState {
  LangState();
}

class EnglishLangState extends LangState {
  final Locale locale = const Locale(AppStrings.setEnglish);
}

class ArabicLangState extends LangState {
  final Locale locale = const Locale(AppStrings.setArabic);
}

class SystemLangState extends LangState {
  final Locale? locale;

  SystemLangState(this.locale);
}

class FailureSelectedLangState extends LangState {
  Failure errorMsg;
  FailureSelectedLangState(this.errorMsg);
}

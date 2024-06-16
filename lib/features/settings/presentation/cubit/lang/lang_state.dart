part of 'lang_cubit.dart';

abstract class LangState {
  final LangEnum? lang;
  const LangState({this.lang});
}

class SystemLangState extends LangState {
  SystemLangState({super.lang = LangEnum.systemLang});
}

class EnglishLangState extends LangState {
  EnglishLangState({super.lang = LangEnum.englishLang});
}

class ArabicLangState extends LangState {
  ArabicLangState({super.lang = LangEnum.arabicLang});
}

class FailureSelectedLangState extends LangState {
  Failure errorMsg;
  FailureSelectedLangState(this.errorMsg);
}

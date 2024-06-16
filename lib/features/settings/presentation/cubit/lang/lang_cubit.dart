import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/app_failures.dart';
import '../../../../../core/app_strings.dart';
import '../../../../../core/di.dart';
import '../../../../../core/enums/language_enum.dart';
import '../../../domain/usecases/set_Locale_use_case.dart';

part 'lang_state.dart';

class LangCubit extends Cubit<LangState> {
  LangCubit(this.setLocaleUseCase) : super(SystemLangState());

  final SetLocaleUseCase setLocaleUseCase;

  void setLocale(LangEnum deviceLang) {
    var setLocal = setLocaleUseCase.call(deviceLang);
    setLocal.fold(
      (failSetLang) => emit(FailureSelectedLangState(failSetLang)),
      (sucessSetLang) {
        switch (deviceLang) {
          case LangEnum.englishLang:
            emit(EnglishLangState());
          case LangEnum.arabicLang:
            emit(ArabicLangState());
          default:
            emit(SystemLangState());
        }
      },
    );
  }

  void getLang() {
    String? langKey = di<SharedPreferences>().getString(AppStrings.setLang);

    switch (langKey) {
      case AppStrings.setEnglish:
        emit(EnglishLangState());
      case AppStrings.setArabic:
        emit(ArabicLangState());
      default:
        emit(SystemLangState());
    }
  }
}

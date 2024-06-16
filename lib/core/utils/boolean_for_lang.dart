import 'package:intl/intl.dart';
import 'package:notesapp/core/app_strings.dart';

bool isDeviceLanguageArabic() {
  final String currentLocale = Intl.getCurrentLocale();
  return currentLocale.startsWith(AppStrings.setArabic);
}

bool isDeviceLanguageEnglish() {
  final String currentLocale = Intl.getCurrentLocale();
  return currentLocale.startsWith(AppStrings.setEnglish);
}

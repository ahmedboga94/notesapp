import 'package:flutter/material.dart';
import 'utils/app_localize_hepler.dart';

extension AppTranslateKeys on BuildContext {
  //Notes
  String get notesKey => translation(this).notesId;
  String get addNewNotesKey => translation(this).addNewNotesId;
  String get addNoteKey => translation(this).addNoteId;
  String get updateNoteKey => translation(this).updateNoteId;
  String get titleKey => translation(this).titleId;
  String get enterTitleNoteKey => translation(this).enterContentNoteId;
  String get contantKey => translation(this).contentId;
  String get enterContentNoteKey => translation(this).enterContentNoteId;
  String get addKey => translation(this).addId;
  String get updateKey => translation(this).updateId;
  String get noteViewkey => translation(this).noteViewId;
  String get editNoteViewKey => translation(this).editNoteViewId;

  //Settings
  String get settingsKey => translation(this).settingsId;
  String get themeKey => translation(this).themeId;
  String get lightThemeKey => translation(this).lightThemeId;
  String get darkThemeKey => translation(this).darkThemeId;
  String get systemThemeKey => translation(this).systemThemeId;
  String get selectThemeKey => translation(this).selectThemeId;
  String get okKey => translation(this).okId;

  String get languageKey => translation(this).langId;
  String get langSelectedKey => translation(this).langSelectedId;
  String get selectLanguageKey => translation(this).selectLangId;
  String get arabicKey => translation(this).arabicLangId;
  String get englishKey => translation(this).englishLang;
}

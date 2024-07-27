import 'package:flutter/material.dart';
import 'utils/app_localize_hepler.dart';

extension AppTranslateKeys on BuildContext {
  //Notes
  String get notesKey => translation(this).notesId;
  String get addNewNotesKey => translation(this).addNewNotesId;
  String get addNoteKey => translation(this).addNoteId;
  String get updateNoteKey => translation(this).updateNoteId;
  String get titleNoteKey => translation(this).titleNoteId;
  String get enterTitleNoteKey => translation(this).enterContentNoteId;
  String get contentNoteKey => translation(this).contentNoteId;
  String get enterContentNoteKey => translation(this).enterContentNoteId;
  String get addKey => translation(this).addId;
  String get updateKey => translation(this).updateId;
  String get noteViewkey => translation(this).noteViewId;
  String get editNoteViewKey => translation(this).editNoteViewId;
  String get itemSelectedKey => translation(this).itemSelectedId;
  String get noItemSelectedKey => translation(this).noItemSelectedId;

  //Reminders
  String get remindersKey => translation(this).remindersId;
  String get addNewRemindersKey => translation(this).addNewRemindersId;
  String get addReminderKey => translation(this).addReminderId;
  String get updateReminderKey => translation(this).updateReminderId;
  String get titleReminderKey => translation(this).titleReminderId;
  String get enterTitleReminderKey => translation(this).enterTitleReminderId;
  String get contentReminderKey => translation(this).contentReminderId;
  String get enterContentReminderKey =>
      translation(this).enterContentReminderId;
  String get reminderViewkey => translation(this).reminderViewId;
  String get noSelectedDateTimeKey => translation(this).noSelectedDateTimeId;

  //Settings
  String get settingsKey => translation(this).settingsId;
  String get themeKey => translation(this).themeId;
  String get lightThemeKey => translation(this).lightThemeId;
  String get darkThemeKey => translation(this).darkThemeId;
  String get systemThemeKey => translation(this).systemThemeId;
  String get selectThemeKey => translation(this).selectThemeId;
  String get okKey => translation(this).okId;
  String get cancelKey => translation(this).cancelId;
  String get deleteDescrpKey => translation(this).deleteDescrpId;

  String get languageKey => translation(this).langId;
  String get langSelectedKey => translation(this).langSelectedId;
  String get selectLanguageKey => translation(this).selectLangId;
  String get arabicKey => translation(this).arabicLangId;
  String get englishKey => translation(this).englishLang;
}

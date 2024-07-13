import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:notesapp/features/reminders/domain/entities/reminder_entity.dart';
import 'package:notesapp/features/reminders/domain/repositories/reminders_repo.dart';
import 'package:notesapp/features/reminders/presentation/cubit/reminders/reminders_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../features/notes/data/datasources/local_data_source.dart';
import '../features/notes/data/repositories/notes_repo_impl.dart';
import '../features/notes/domain/entities/note_entity.dart';
import '../features/notes/domain/repositories/notes_repo.dart';
import '../features/notes/domain/usecases/add_note_use_case.dart';
import '../features/notes/domain/usecases/delete_note_use_case.dart';
import '../features/notes/domain/usecases/get_notes_use_case.dart';
import '../features/notes/domain/usecases/update_note_use_case.dart';
import '../features/notes/presentation/cubit/notes/notes_cubit.dart';
import '../features/reminders/data/datasources/local_reminders_data_source.dart';
import '../features/reminders/data/repositories/reminders_repo_impl.dart';
import '../features/reminders/domain/usecases/add_reminder_use_case.dart';
import '../features/reminders/domain/usecases/delete_reminder_use_case.dart';
import '../features/reminders/domain/usecases/get_reminders_use_case.dart';
import '../features/reminders/domain/usecases/update_reminder_use_case.dart';
import '../features/settings/data/datasources/local_settings_storage.dart';
import '../features/settings/data/repositories/settings_repo_impl.dart';
import '../features/settings/domain/repositories/settings_repo.dart';
import '../features/settings/domain/usecases/set_Locale_use_case.dart';
import '../features/settings/domain/usecases/set_theme_use_case.dart';
import '../features/settings/presentation/cubit/lang/lang_cubit.dart';
import '../features/settings/presentation/cubit/theme/theme_cubit.dart';
import 'app_strings.dart';
import 'utils/custom_status_nav_bar_func.dart';

final di = GetIt.instance;

Future<void> initDi() async {
  //! Features
  await diSettingsFeature();
  await diNotesHomeFeature();
  await diRemindersHomeFeature();
  //core
  await diCoreAndExternal();
  //utils func
  customStatusBarAndNavigationBar();
}

Future<void> diCoreAndExternal() async {
  //External
  final sharedPref = await SharedPreferences.getInstance();
  di.registerLazySingleton(() => sharedPref);

  di.registerLazySingleton<Box<NoteEntity>>(
      () => Hive.box<NoteEntity>(AppStrings.notesBox));

  di.registerLazySingleton<Box<ReminderEntity>>(
      () => Hive.box<ReminderEntity>(AppStrings.remindersBox));
}

Future<void> diSettingsFeature() async {
  //cubit
  di.registerFactory(() => ThemeCubit(di()));
  di.registerFactory(() => LangCubit(di()));

  //use_case
  di.registerLazySingleton(() => SetThemeUseCase(di()));
  di.registerLazySingleton(() => SetLocaleUseCase(di()));

  //repo
  di.registerLazySingleton<SettingsRepo>(() => SettingsRepoImpl(di()));

  //data_sources
  di.registerLazySingleton<LocalSettingsStorage>(
      () => LocalSettingsStorageImp(di()));
}

Future<void> diNotesHomeFeature() async {
  //cubit
  di.registerFactory(() => NotesCubit(
        getNotesUseCase: di(),
        addNoteUseCase: di(),
        updateNoteUseCase: di(),
        deleteNoteUseCase: di(),
      ));

  //use_case
  di.registerLazySingleton(() => GetNotesUseCase(di()));
  di.registerLazySingleton(() => AddNoteUseCase(di()));
  di.registerLazySingleton(() => UpdateNoteUseCase(di()));
  di.registerLazySingleton(() => DeleteNoteUseCase(di()));

  //repo
  di.registerLazySingleton<NotesRepo>(() => NotesRepoImpl(di()));

  //data_sources
  di.registerLazySingleton<LocalNotesDataSource>(
      () => LocalNotesDataSourceImpl(di()));
}

Future<void> diRemindersHomeFeature() async {
  //cubit
  di.registerFactory(() => RemindersCubit(
        getRemindersUseCase: di(),
        addReminderUseCase: di(),
        updateReminderUseCase: di(),
        deleteReminderUseCase: di(),
      ));

  //use_case
  di.registerLazySingleton(() => GetRemindersUseCase(di()));
  di.registerLazySingleton(() => AddReminderUseCase(di()));
  di.registerLazySingleton(() => UpdateReminderUseCase(di()));
  di.registerLazySingleton(() => DeleteReminderUseCase(di()));

  //repo
  di.registerLazySingleton<RemindersRepo>(() => RemindersRepoImpl(di()));

  //data_sources
  di.registerLazySingleton<LocalRemindersDataSource>(
      () => LocalRemindersDataSourceImpl(di()));
}

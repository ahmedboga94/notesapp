import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
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
  //! Feature - Settings
  await diSettingsFeature();
  await diNotesHomeFeature();
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

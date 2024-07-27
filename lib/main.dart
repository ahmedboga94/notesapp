import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:notesapp/core/app_strings.dart';
import 'package:notesapp/core/utils/two_bloc_builder.dart';
import 'package:notesapp/features/reminders/presentation/cubit/reminders/reminders_cubit.dart';
import 'package:notesapp/features/settings/presentation/cubit/lang/lang_cubit.dart';

import 'core/services/app_hive_local.dart';
import 'core/app_routes.dart';
import 'core/app_theme.dart';
import 'core/di.dart';
import 'core/services/local_notification_service.dart';
import 'features/notes/presentation/cubit/notes/notes_cubit.dart';
import 'features/settings/presentation/cubit/theme/theme_cubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDi();
  await initHiveFlutter();
  await NotificationService.init();
  runApp(const NotesApp());
}

class NotesApp extends StatelessWidget {
  const NotesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ThemeCubit>(
            create: (context) => di<ThemeCubit>()..getTheme()),
        BlocProvider<LangCubit>(
            create: (context) => di<LangCubit>()..getLang()),
        BlocProvider<NotesCubit>(
            create: (context) => di<NotesCubit>()..getNotes()),
        BlocProvider<RemindersCubit>(
            create: (context) => di<RemindersCubit>()..getReminders()),
      ],
      child: TwoBlocBuilder<LangCubit, LangState, ThemeCubit, ThemeState>(
        builder: (context, lang, theme) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            title: "Notes App",
            theme: AppThemes.lightTheme,
            darkTheme: AppThemes.darkTheme,
            themeMode: theme is LightThemeState
                ? ThemeMode.light
                : theme is DarkThemeState
                    ? ThemeMode.dark
                    : ThemeMode.system,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            locale: lang is EnglishLangState
                ? const Locale(AppStrings.setEnglish)
                : lang is ArabicLangState
                    ? const Locale(AppStrings.setArabic)
                    : null,
            routerConfig: AppRoutes.router,
          );
        },
      ),
    );
  }
}

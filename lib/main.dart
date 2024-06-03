import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/app_hive_local.dart';
import 'core/app_routes.dart';
import 'core/app_theme.dart';
import 'core/di.dart';
import 'features/notes/presentation/cubit/notes/notes_cubit.dart';
import 'features/settings/presentation/cubit/theme/theme_cubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDi();
  await initHiveFlutter();
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
        BlocProvider<NotesCubit>(
            create: (context) => di<NotesCubit>()..getNotes()),
      ],
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            title: "Notes App",
            theme: AppThemes.lightTheme,
            darkTheme: AppThemes.darkTheme,
            themeMode: state is LightThemeState
                ? ThemeMode.light
                : state is DarkThemeState
                    ? ThemeMode.dark
                    : ThemeMode.system,
            routerConfig: AppRoutes.router,
          );
        },
      ),
    );
  }
}

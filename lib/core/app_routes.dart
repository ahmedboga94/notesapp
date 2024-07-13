import 'package:go_router/go_router.dart';

import '../features/notes/domain/entities/note_entity.dart';
import '../features/notes/presentation/views/add_edit_note_view/note_edit_view.dart';
import '../features/notes/presentation/views/note_details_view/note_details_view.dart';
import '../features/splash/presentation/views/splash_view/splash_view.dart';
import '../features/settings/presentation/views/settings_view.dart';
import '../features/bottom_nav/presentation/views/main_view_bottom_nav_bar.dart';

class AppRoutes {
  static const String splashView = "/";
  static const String mainView = "/mainView";
  static const String noteDetailsView = "/notesDetailsView";
  static const String noteEditView = "/noteEditView";
  static const String settingsView = "/settingsView";

  static final GoRouter router = GoRouter(
    routes: [
      GoRoute(
        path: splashView,
        builder: (context, state) => const SplashView(),
      ),
      GoRoute(
        path: mainView,
        builder: (context, state) => const MainView(),
      ),
      GoRoute(
        path: noteDetailsView,
        builder: (context, state) {
          final note = state.extra as NoteEntity;
          return NoteDetailsView(noteEntity: note);
        },
      ),
      GoRoute(
        path: noteEditView,
        builder: (context, state) {
          final note = state.extra as NoteEntity;
          return NoteEditView(noteEntity: note);
        },
      ),
      GoRoute(
        path: settingsView,
        builder: (context, state) => const SettingsView(),
      ),
    ],
  );
}

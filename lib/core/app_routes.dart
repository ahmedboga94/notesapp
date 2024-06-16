import 'package:go_router/go_router.dart';

import '../features/notes/domain/entities/note_entity.dart';
import '../features/notes/presentation/views/add_edit_note_view/note_edit_view.dart';
import '../features/notes/presentation/views/note_details_view/note_details_view.dart';
import '../features/notes/presentation/views/notes_home_view/notes_view.dart';
import '../features/notes/presentation/views/splash_view/splash_view.dart';
import '../features/settings/presentation/views/settings_view.dart';

class AppRoutes {
  static const String splashView = "/";
  static const String notesView = "/notesView";
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
        path: notesView,
        builder: (context, state) => const NotesView(),
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

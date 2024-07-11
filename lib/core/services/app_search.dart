import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:notesapp/core/app_colors.dart';
import 'package:notesapp/features/notes/domain/entities/note_entity.dart';

import '../features/notes/presentation/views/notes_home_view/widgets/custom_note_card.dart';

class AppSearchDelegate extends SearchDelegate<String> {
  final List<NoteEntity> data;

  AppSearchDelegate(this.data);

  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return theme.copyWith(
        inputDecorationTheme: const InputDecorationTheme(
            hintStyle: TextStyle(color: AppColors.lightGreyColor),
            border: InputBorder.none),
        textSelectionTheme:
            const TextSelectionThemeData(cursorColor: AppColors.lightGreyColor),
        textTheme: const TextTheme(
          titleLarge: TextStyle(color: AppColors.lightGreyColor),
        ));
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Ionicons.close),
        onPressed: () {
          if (query.isEmpty) {
            close(context, '');
          } else {
            query = '';
          }
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Ionicons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final suggestions = data.where((notes) {
      final noteTitle = notes.title.toLowerCase();
      final input = query.toLowerCase();
      return noteTitle.contains(input);
    }).toList();
    return Padding(
      padding: const EdgeInsets.all(14),
      child: ListView.builder(
        itemCount: suggestions.length,
        itemBuilder: (context, index) {
          return CustomNoteCard(noteEntity: suggestions[index]);
        },
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = data.where((notes) {
      final noteTitle = notes.title.toLowerCase();
      final input = query.toLowerCase();
      return noteTitle.contains(input);
    }).toList();
    return Padding(
      padding: const EdgeInsets.all(14),
      child: ListView.builder(
        itemCount: suggestions.length,
        itemBuilder: (context, index) {
          return CustomNoteCard(noteEntity: suggestions[index]);
        },
      ),
    );
  }
}

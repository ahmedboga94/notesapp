import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:notesapp/core/app_colors.dart';
import 'package:notesapp/features/reminders/domain/entities/reminder_entity.dart';

import '../../features/reminders/presentation/views/widgets/custom_reminder_card.dart';

class AppSearchRemindersDelegate extends SearchDelegate<String> {
  final List<ReminderEntity> dataReminders;

  AppSearchRemindersDelegate(this.dataReminders);

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
    final suggestionsReminders = dataReminders.where((reminders) {
      final reminderTitle = reminders.title.toLowerCase();
      final input = query.toLowerCase();
      return reminderTitle.contains(input);
    }).toList();

    return Padding(
      padding: const EdgeInsets.all(14),
      child: ListView.builder(
        itemCount: suggestionsReminders.length,
        itemBuilder: (context, index) {
          return CustomReminderCard(
              reminderEntity: suggestionsReminders[index]);
        },
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionsReminders = dataReminders.where((reminders) {
      final reminderTitle = reminders.title.toLowerCase();
      final input = query.toLowerCase();
      return reminderTitle.contains(input);
    }).toList();
    return Padding(
      padding: const EdgeInsets.all(14),
      child: ListView.builder(
        itemCount: suggestionsReminders.length,
        itemBuilder: (context, index) {
          return CustomReminderCard(
              reminderEntity: suggestionsReminders[index]);
        },
      ),
    );
  }
}

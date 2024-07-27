import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';
import 'package:notesapp/core/app_translate_keys.dart';
import 'package:notesapp/core/utils/two_bloc_builder.dart';
import 'package:notesapp/features/notes/presentation/cubit/notes/notes_cubit.dart';
import 'package:notesapp/features/reminders/presentation/cubit/reminders/reminders_cubit.dart';

import '../../../notes/presentation/views/notes_home_view/notes_view.dart';
import '../../../reminders/presentation/views/reminder_home_view/reminders_view.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  int _currentIndex = 0;
  final List<Widget> _screens = const [
    NotesView(),
    RemindersView(),
  ];

  @override
  Widget build(BuildContext context) {
    return TwoBlocBuilder<NotesCubit, NotesState, RemindersCubit,
        RemindersState>(
      builder: (context, notes, reminders) {
        return Scaffold(
          body: _screens[_currentIndex],
          bottomNavigationBar: Visibility(
            visible: _currentIndex == 0
                ? !context.read<NotesCubit>().isMultiSelectionEnabled
                : !context.read<RemindersCubit>().isMultiSelectionEnabled,
            child: BottomNavigationBar(
              currentIndex: _currentIndex,
              onTap: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              items: [
                BottomNavigationBarItem(
                  icon: const Icon(Ionicons.document),
                  label: context.notesKey,
                ),
                BottomNavigationBarItem(
                  icon: const Icon(Ionicons.notifications),
                  label: context.remindersKey,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

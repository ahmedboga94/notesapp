import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';
import 'package:notesapp/core/app_translate_keys.dart';
import 'package:notesapp/core/utils/two_bloc_builder.dart';
import 'package:notesapp/features/notes/presentation/cubit/notes/notes_cubit.dart';
import 'package:notesapp/features/reminders/presentation/cubit/reminders/reminders_cubit.dart';

import '../../../notes/presentation/views/notes_home_view/notes_view.dart';
import '../../../reminders/presentation/views/reminder_home_view/reminders_view.dart';
import '../cubit/bottom_nav_cubit.dart';

// Cubit for handling the current index state

class MainView extends StatelessWidget {
  const MainView({super.key});

  final List<Widget> _screens = const [
    NotesView(),
    RemindersView(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => BottomNavCubit(),
      child: TwoBlocBuilder<NotesCubit, NotesState, RemindersCubit,
          RemindersState>(
        builder: (context, notes, reminders) {
          return Scaffold(
            body: BlocBuilder<BottomNavCubit, int>(
              builder: (context, currentIndex) {
                return _screens[currentIndex];
              },
            ),
            bottomNavigationBar: Visibility(
              visible: context.read<BottomNavCubit>().state == 0
                  ? !context.read<NotesCubit>().isMultiSelectionEnabled
                  : !context.read<RemindersCubit>().isMultiSelectionEnabled,
              child: BottomNavigationBar(
                currentIndex: context.watch<BottomNavCubit>().state,
                onTap: (index) {
                  context.read<BottomNavCubit>().updateIndex(index);
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
      ),
    );
  }
}

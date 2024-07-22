import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notesapp/features/reminders/presentation/cubit/reminders/reminders_cubit.dart';

import 'custom_reminder_card.dart';

class RemindersBody extends StatelessWidget {
  const RemindersBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RemindersCubit, RemindersState>(
      builder: (context, state) {
        final noteCubit = context.read<RemindersCubit>();
        return state is SuccessRemindersState
            ? state.reminders.isNotEmpty
                ? PopScope(
                    canPop: !noteCubit.isMultiSelectionEnabled,
                    onPopInvoked: (didPop) {
                      if (noteCubit.isMultiSelectionEnabled) {
                        noteCubit.toggleMultiSelection(false);
                        noteCubit.clearSelection();
                      }
                    },
                    child: Padding(
                        padding: const EdgeInsets.all(14),
                        child: ListView.builder(
                            itemCount: state.reminders.length,
                            itemBuilder: (context, index) {
                              return CustomReminderCard(
                                reminderEntity: state.reminders[index],
                                isMultiSelection: true,
                              );
                            })),
                  )
                : Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("context.addNewNotesKey",
                            style: Theme.of(context).textTheme.headlineMedium),
                        const SizedBox(height: 20),
                        const Icon(Icons.arrow_downward,
                            size: 40, color: Colors.grey),
                      ],
                    ),
                  )
            : state is FailureRemindersState
                ? Center(
                    child: Text(
                    state.errorMsg,
                    style: Theme.of(context).textTheme.headlineLarge,
                  ))
                : const SizedBox();
      },
    );
  }
}

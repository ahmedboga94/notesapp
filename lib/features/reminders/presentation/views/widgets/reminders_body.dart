import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notesapp/core/app_assets.dart';
import 'package:notesapp/core/app_colors.dart';
import 'package:notesapp/core/app_translate_keys.dart';
import 'package:notesapp/features/reminders/presentation/cubit/reminders/reminders_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/app_strings.dart';
import '../../../../../core/di.dart';
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
                        },
                      ),
                    ),
                  )
                : Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(context.addNewRemindersKey,
                            style: Theme.of(context).textTheme.headlineSmall),
                        const SizedBox(height: 20),
                        Transform.flip(
                          flipX: di<SharedPreferences>()
                                  .getString(AppStrings.setLang) ==
                              AppStrings.setArabic,
                          child: Image.asset(
                            AppAssets.arrowAdd,
                            scale: 1.5,
                            color: AppColors.primaryColor,
                          ),
                        ),
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

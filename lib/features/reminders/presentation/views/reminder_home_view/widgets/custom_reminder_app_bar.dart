import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:ionicons/ionicons.dart';
import 'package:notesapp/core/app_colors.dart';
import 'package:notesapp/core/app_translate_keys.dart';
import 'package:notesapp/features/reminders/presentation/cubit/reminders/reminders_cubit.dart';

import '../../../../../../core/app_assets.dart';
import '../../../../../../core/app_routes.dart';
import '../../../../../../core/services/app_search.dart';
import '../../../../../../core/utils/confirm_to_delete.dart';

class CustomRemindersAppBar extends StatelessWidget {
  const CustomRemindersAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RemindersCubit, RemindersState>(
      builder: (context, state) {
        final remindersCubit = context.read<RemindersCubit>();
        final selectedItems = remindersCubit.selectedItems;
        final isMultiSelectionEnabled = remindersCubit.isMultiSelectionEnabled;
        return AppBar(
          centerTitle: isMultiSelectionEnabled ? false : true,
          leading: isMultiSelectionEnabled
              ? IconButton(
                  onPressed: () {
                    remindersCubit.clearSelection();
                    remindersCubit.toggleMultiSelection(false);
                  },
                  icon: const Icon(Ionicons.close))
              : Padding(
                  padding: const EdgeInsets.all(5),
                  child: Hero(
                      tag: AppAssets.appLogo,
                      child: Image.asset(AppAssets.appLogo)),
                ),
          title: Text(isMultiSelectionEnabled
              ? selectedItems.isNotEmpty
                  ? "${selectedItems.length} ${context.itemSelectedKey}"
                  : context.noItemSelectedKey
              : context.remindersKey),
          actions: isMultiSelectionEnabled
              ? [
                  Visibility(
                      visible: selectedItems.isNotEmpty,
                      child: IconButton(
                          icon: const Icon(Ionicons.trash_outline),
                          onPressed: () => confirmToDelete(
                              context: context,
                              onPressed: () {
                                for (var reminders in selectedItems) {
                                  remindersCubit.deleteReminder(reminders);
                                }
                                remindersCubit.clearSelection();
                                GoRouter.of(context).pop();
                              }))),
                  Visibility(
                      visible: isMultiSelectionEnabled,
                      child: IconButton(
                          icon: Icon(
                            selectedItems.length ==
                                    (state as SuccessRemindersState)
                                        .reminders
                                        .length
                                ? Ionicons.checkbox_outline
                                : Ionicons.square_outline,
                            color: AppColors.lightGreyColor,
                          ),
                          onPressed: () {
                            remindersCubit.selectAll();
                          })),
                ]
              : [
                  state is SuccessRemindersState
                      ? IconButton(
                          onPressed: () {
                            // showSearch(
                            //   context: context,
                            //   delegate: AppSearchDelegate(state.reminders),
                            // );
                          },
                          icon: const Icon(Ionicons.search))
                      : const SizedBox(),
                  IconButton(
                      onPressed: () => context.push(AppRoutes.settingsView),
                      icon: const Icon(Ionicons.settings)),
                ],
        );
      },
    );
  }
}

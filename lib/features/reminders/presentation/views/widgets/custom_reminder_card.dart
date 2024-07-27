import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
import 'package:notesapp/core/utils/confirm_to_delete.dart';
import 'package:notesapp/features/reminders/domain/entities/reminder_entity.dart';
import 'package:notesapp/features/reminders/presentation/cubit/reminders/reminders_cubit.dart';

import '../../../../../core/app_colors.dart';
import 'update_reminder_dialog_btn.dart';

class CustomReminderCard extends StatelessWidget {
  final ReminderEntity reminderEntity;
  final bool isMultiSelection;

  const CustomReminderCard(
      {super.key, required this.reminderEntity, this.isMultiSelection = false});

  @override
  Widget build(BuildContext context) {
    final noteCubit = context.read<RemindersCubit>();
    final selectedItems = noteCubit.selectedItems;
    return BlocBuilder<RemindersCubit, RemindersState>(
      builder: (context, state) {
        if (state is SuccessRemindersState) {
          final reminderDate =
              DateFormat('yyyy-MM-dd hh:mm a').format(reminderEntity.dateTime);
          return GestureDetector(
              onTap: () {
                if (noteCubit.isMultiSelectionEnabled) {
                  noteCubit.toggleSelection(reminderEntity);
                }
              },
              onLongPress: () {
                if (isMultiSelection) {
                  noteCubit.toggleMultiSelection(true);
                  noteCubit.toggleSelection(reminderEntity);
                }
              },
              child: Card(
                color: Color(reminderEntity.color),
                child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(reminderEntity.title,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium!
                                      .copyWith(color: AppColors.darkColor)),
                            ),
                            Visibility(
                              visible: !noteCubit.isMultiSelectionEnabled,
                              child: UpdateReminderDialogBtn(
                                  reminderEntity: reminderEntity),
                            ),
                            noteCubit.isMultiSelectionEnabled
                                ? IconButton(
                                    icon: Icon(
                                      selectedItems.contains(reminderEntity)
                                          ? Ionicons.checkmark_circle
                                          : Ionicons.ellipse_outline,
                                      size: 30,
                                      color: AppColors.darkColor,
                                    ),
                                    onPressed: null,
                                  )
                                : IconButton(
                                    padding: EdgeInsets.zero,
                                    constraints: const BoxConstraints(),
                                    onPressed: () => confirmToDelete(
                                        context: context,
                                        onPressed: () {
                                          context
                                              .read<RemindersCubit>()
                                              .deleteReminder(reminderEntity);
                                          GoRouter.of(context).pop();
                                        }),
                                    icon: const Icon(Ionicons.close_circle,
                                        size: 28, color: AppColors.darkColor)),
                          ],
                        ),
                        Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Opacity(
                              opacity: 0.5,
                              child: Text(reminderEntity.subTitle,
                                  maxLines: 2,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(color: AppColors.darkColor)),
                            )),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Opacity(
                              opacity: 0.7,
                              child: Text(reminderDate,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall!
                                      .copyWith(color: AppColors.darkColor)),
                            ),
                            Visibility(
                              visible: reminderEntity.dateTime
                                  .isAfter(DateTime.now()),
                              child: Switch(
                                materialTapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap,
                                value: reminderEntity.isNotificationEnabled,
                                onChanged: (value) {
                                  context
                                      .read<RemindersCubit>()
                                      .toggleNotification(
                                          value, reminderEntity);
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    )),
              ));
        } else {
          return const SizedBox();
        }
      },
    );
  }
}

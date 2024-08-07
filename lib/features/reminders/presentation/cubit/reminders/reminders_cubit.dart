import 'dart:collection';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notesapp/core/app_colors.dart';
import 'package:notesapp/core/services/local_notification_service.dart';
import 'package:notesapp/features/reminders/domain/entities/reminder_entity.dart';

import 'package:notesapp/core/app_failures.dart';
import 'package:notesapp/features/reminders/domain/usecases/get_reminders_use_case.dart';

import '../../../domain/usecases/add_reminder_use_case.dart';
import '../../../domain/usecases/delete_reminder_use_case.dart';
import '../../../domain/usecases/update_reminder_use_case.dart';

part 'reminders_state.dart';

class RemindersCubit extends Cubit<RemindersState> {
  final GetRemindersUseCase getRemindersUseCase;
  final AddReminderUseCase addReminderUseCase;
  final UpdateReminderUseCase updateReminderUseCase;
  final DeleteReminderUseCase deleteReminderUseCase;

  RemindersCubit({
    required this.getRemindersUseCase,
    required this.addReminderUseCase,
    required this.updateReminderUseCase,
    required this.deleteReminderUseCase,
  }) : super(InitialRemindersState());

  Color selectedColor = AppColors.colorsList[0];
  final HashSet<ReminderEntity> _selectedItems = HashSet();
  bool isMultiSelectionEnabled = false;
  DateTime? selectedDateTime;

  HashSet<ReminderEntity> get selectedItems => _selectedItems;

  void getReminders() {
    Either<Failure, List<ReminderEntity>> notes = getRemindersUseCase.call();
    notes.fold(
      (fail) => emit(FailureRemindersState(fail.failureMessage)),
      (success) => emit(SuccessRemindersState(success)),
    );
  }

  void addReminder(ReminderEntity addReminder) async {
    addReminder.color = selectedColor.value;
    Either<Failure, Unit> note = addReminderUseCase.call(addReminder);
    await NotificationService.showScheduleNotification(addReminder);
    foldMethod(note);
  }

  void updateReminder(ReminderEntity updateReminder) async {
    await NotificationService.cancel(updateReminder);
    updateReminder.color = selectedColor.value;
    Either<Failure, Unit> note = updateReminderUseCase.call(updateReminder);
    if (updateReminder.isNotificationEnabled) {
      await NotificationService.showScheduleNotification(updateReminder);
    } else {
      await NotificationService.cancel(updateReminder);
    }

    foldMethod(note);
  }

  void deleteReminder(ReminderEntity deleteReminder) async {
    Either<Failure, Unit> note = deleteReminderUseCase.call(deleteReminder);
    if (deleteReminder.isNotificationEnabled) {
      await NotificationService.cancel(deleteReminder);
    }

    foldMethod(note);
  }

  void changeColor(Color color) {
    selectedColor = color;
  }

  void foldMethod(Either<Failure, Unit> reminder) {
    reminder.fold(
      (fail) => emit(FailureRemindersState(fail.failureMessage)),
      (success) => getReminders(),
    );
  }

  void toggleNotification(bool isEnabled, ReminderEntity updateReminder) async {
    updateReminder.isNotificationEnabled = isEnabled;
    updateReminderUseCase.call(updateReminder);
    if (isEnabled) {
      await NotificationService.showScheduleNotification(updateReminder);
    } else {
      await NotificationService.cancel(updateReminder);
    }
    getReminders();
  }

//////////// multi selection /////////////

  void toggleMultiSelection(bool enabled) {
    isMultiSelectionEnabled = enabled;
    if (state is SuccessRemindersState) {
      emit(SuccessRemindersState((state as SuccessRemindersState).reminders));
    }
  }

  void toggleSelection(ReminderEntity reminders) {
    if (_selectedItems.contains(reminders)) {
      _selectedItems.remove(reminders);
    } else {
      _selectedItems.add(reminders);
    }
    if (state is SuccessRemindersState) {
      emit(SuccessRemindersState((state as SuccessRemindersState).reminders));
    }
  }

  void clearSelection() {
    _selectedItems.clear();
    isMultiSelectionEnabled = false;
    if (state is SuccessRemindersState) {
      emit(SuccessRemindersState((state as SuccessRemindersState).reminders));
    }
  }

  void selectAll() {
    if (state is SuccessRemindersState) {
      if (_selectedItems.length ==
          (state as SuccessRemindersState).reminders.length) {
        _selectedItems.clear();
      } else {
        _selectedItems.addAll((state as SuccessRemindersState).reminders);
      }
      emit(SuccessRemindersState((state as SuccessRemindersState).reminders));
    }
  }
}

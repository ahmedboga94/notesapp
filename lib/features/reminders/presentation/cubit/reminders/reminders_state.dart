part of 'reminders_cubit.dart';

abstract class RemindersState {}

class InitialRemindersState extends RemindersState {}

class SuccessRemindersState extends RemindersState {
  final List<ReminderEntity> reminders;

  SuccessRemindersState(this.reminders);
}

class FailureRemindersState extends RemindersState {
  final String errorMsg;

  FailureRemindersState(this.errorMsg);
}

import 'package:hive_flutter/hive_flutter.dart';
import 'package:notesapp/features/reminders/domain/entities/reminder_entity.dart';

abstract class LocalRemindersDataSource {
  List<ReminderEntity> getReminders();
  void addReminder(ReminderEntity addReminder);
  void updateReminder(ReminderEntity updateReminder);
  void deleteReminder(ReminderEntity deleteReminder);
}

class LocalRemindersDataSourceImpl implements LocalRemindersDataSource {
  final Box<ReminderEntity> reminderBox;

  LocalRemindersDataSourceImpl(this.reminderBox);
  @override
  List<ReminderEntity> getReminders() {
    return reminderBox.values.toList();
  }

  @override
  void addReminder(ReminderEntity addReminder) {
    reminderBox.add(addReminder);
  }

  @override
  void deleteReminder(ReminderEntity deleteReminder) {
    reminderBox.delete(deleteReminder.key);
  }

  @override
  void updateReminder(ReminderEntity updateReminder) {
    reminderBox.put(updateReminder.key, updateReminder);
  }
}

import 'package:dartz/dartz.dart';
import 'package:notesapp/core/app_failures.dart';
import 'package:notesapp/features/reminders/data/datasources/local_reminders_data_source.dart';
import 'package:notesapp/features/reminders/domain/entities/reminder_entity.dart';
import 'package:notesapp/features/reminders/domain/repositories/reminders_repo.dart';

class RemindersRepoImpl implements RemindersRepo {
  final LocalRemindersDataSource localRemindersDataSource;

  RemindersRepoImpl(this.localRemindersDataSource);

  @override
  Either<Failure, List<ReminderEntity>> getReminders() {
    try {
      return right(localRemindersDataSource.getReminders());
    } catch (e) {
      return left(Failure("Error in fetching Reminders"));
    }
  }

  @override
  Either<Failure, Unit> addReminder(ReminderEntity addReminder) {
    try {
      localRemindersDataSource.addReminder(addReminder);
      return right(unit);
    } catch (e) {
      return left(Failure("Error in adding Reminders"));
    }
  }

  @override
  Either<Failure, Unit> updateReminder(ReminderEntity updateReminder) {
    try {
      localRemindersDataSource.updateReminder(updateReminder);
      return right(unit);
    } catch (e) {
      return left(Failure("Error in updating Reminders"));
    }
  }

  @override
  Either<Failure, Unit> deleteReminder(ReminderEntity deleteReminder) {
    try {
      localRemindersDataSource.deleteReminder(deleteReminder);
      return right(unit);
    } catch (e) {
      return left(Failure("Error in deleting Reminders"));
    }
  }
}

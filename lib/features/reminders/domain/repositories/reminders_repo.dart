import 'package:dartz/dartz.dart';

import '../../../../core/app_failures.dart';
import '../entities/reminder_entity.dart';

abstract class RemindersRepo {
  Either<Failure, List<ReminderEntity>> getReminders();
  Either<Failure, Unit> addReminder(ReminderEntity addReminder);
  Either<Failure, Unit> updateReminder(ReminderEntity updateReminder);
  Either<Failure, Unit> deleteReminder(ReminderEntity deleteReminder);
}

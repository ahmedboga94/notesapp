import 'package:dartz/dartz.dart';

import '../../../../core/app_failures.dart';
import '../entities/reminder_entity.dart';
import '../repositories/reminders_repo.dart';

class DeleteReminderUseCase {
  final RemindersRepo remindersRepo;

  DeleteReminderUseCase(this.remindersRepo);

  Either<Failure, Unit> call(ReminderEntity deleteReminder) {
    return remindersRepo.deleteReminder(deleteReminder);
  }
}

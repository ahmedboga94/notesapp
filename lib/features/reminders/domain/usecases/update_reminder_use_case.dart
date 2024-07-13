import 'package:dartz/dartz.dart';

import '../../../../core/app_failures.dart';
import '../entities/reminder_entity.dart';
import '../repositories/reminders_repo.dart';

class UpdateReminderUseCase {
  final RemindersRepo remindersRepo;

  UpdateReminderUseCase(this.remindersRepo);

  Either<Failure, Unit> call(ReminderEntity updateReminder) {
    return remindersRepo.updateReminder(updateReminder);
  }
}

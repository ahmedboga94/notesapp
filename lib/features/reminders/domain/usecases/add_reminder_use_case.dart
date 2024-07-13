import 'package:dartz/dartz.dart';

import '../../../../core/app_failures.dart';
import '../entities/reminder_entity.dart';
import '../repositories/reminders_repo.dart';

class AddReminderUseCase {
  final RemindersRepo remindersRepo;

  AddReminderUseCase(this.remindersRepo);

  Either<Failure, Unit> call(ReminderEntity addReminder) {
    return remindersRepo.addReminder(addReminder);
  }
}

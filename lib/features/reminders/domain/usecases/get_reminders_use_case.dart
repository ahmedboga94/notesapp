import 'package:dartz/dartz.dart';

import '../../../../core/app_failures.dart';
import '../entities/reminder_entity.dart';
import '../repositories/reminders_repo.dart';

class GetRemindersUseCase {
  final RemindersRepo remindersRepo;

  GetRemindersUseCase(this.remindersRepo);

  Either<Failure, List<ReminderEntity>> call() {
    return remindersRepo.getReminders();
  }
}

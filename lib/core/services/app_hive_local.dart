import 'package:hive_flutter/adapters.dart';

import '../../features/notes/domain/entities/note_entity.dart';
import '../../features/reminders/domain/entities/reminder_entity.dart';
import '../app_strings.dart';

initHiveFlutter() async {
  await Hive.initFlutter();
  Hive.registerAdapter(NoteEntityAdapter());
  Hive.registerAdapter(ReminderEntityAdapter());
  await Hive.openBox<NoteEntity>(AppStrings.notesBox);
  await Hive.openBox<ReminderEntity>(AppStrings.remindersBox);
}

import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart';

import '../features/notes/domain/entities/note_entity.dart';
import 'app_strings.dart';

initHiveFlutter() async {
  var dir = await getApplicationDocumentsDirectory();
  await Hive.initFlutter(dir.path);
  Hive.registerAdapter(NoteEntityAdapter());
  await Hive.openBox<NoteEntity>(AppStrings.notesBox);
}

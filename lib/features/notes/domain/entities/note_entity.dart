import 'package:hive/hive.dart';

part 'note_entity.g.dart';

@HiveType(typeId: 0)
class NoteEntity extends HiveObject {
  @HiveField(0)
  String title;
  @HiveField(1)
  String subTitle;
  @HiveField(2)
  final String dateTime;
  @HiveField(3)
  int color;

  NoteEntity({
    required this.title,
    required this.subTitle,
    required this.dateTime,
    required this.color,
  });
}

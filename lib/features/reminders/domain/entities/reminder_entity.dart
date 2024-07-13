import 'package:hive/hive.dart';

part 'reminder_entity.g.dart';

@HiveType(typeId: 1)
class ReminderEntity extends HiveObject {
  @HiveField(0)
  String title;
  @HiveField(1)
  String subTitle;
  @HiveField(2)
  final String dateTime;
  @HiveField(3)
  int color;

  ReminderEntity({
    required this.title,
    required this.subTitle,
    required this.dateTime,
    required this.color,
  });
}

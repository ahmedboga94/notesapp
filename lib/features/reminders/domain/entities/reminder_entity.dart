import 'package:hive/hive.dart';

part 'reminder_entity.g.dart';

@HiveType(typeId: 1)
class ReminderEntity extends HiveObject {
  @HiveField(0)
  String title;
  @HiveField(1)
  String subTitle;
  @HiveField(2)
  DateTime dateTime;
  @HiveField(3)
  int color;
  @HiveField(4)
  bool isNotificationEnabled;

  ReminderEntity({
    required this.title,
    required this.subTitle,
    required this.dateTime,
    required this.color,
    required this.isNotificationEnabled,
  });
}

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:notesapp/features/reminders/domain/entities/reminder_entity.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import '../../features/bottom_nav/presentation/cubit/bottom_nav_cubit.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static NotificationDetails notificationDetails = const NotificationDetails(
      android: AndroidNotificationDetails(
    "channelId",
    "channelName",
    priority: Priority.high,
    importance: Importance.high,
  ));

  static onTap(NotificationResponse notificationResponse) {
    BottomNavCubit().updateIndex(1);
  }

  static Future init() async {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()!
        .requestNotificationsPermission();

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings("@mipmap/ic_launcher");
    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: onTap,
        onDidReceiveBackgroundNotificationResponse: onTap);
  }

  // to schedule a local notification
  static Future showScheduleNotification(ReminderEntity reminder) async {
    tz.initializeTimeZones();

    await flutterLocalNotificationsPlugin.zonedSchedule(
      reminder.hashCode,
      reminder.title,
      reminder.subTitle,
      tz.TZDateTime.from(reminder.dateTime, tz.local),
      notificationDetails,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  static Future cancel(ReminderEntity reminder) async {
    await flutterLocalNotificationsPlugin.cancel(reminder.hashCode);
  }

  static Future cancelAll() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }
}

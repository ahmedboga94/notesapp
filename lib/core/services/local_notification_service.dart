import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:notesapp/features/reminders/domain/entities/reminder_entity.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

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

  static Future init() async {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()!
        .requestNotificationsPermission();

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings("@mipmap/ic_launcher");
    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  // show a simple notification
  static Future showSimpleNotification(ReminderEntity reminder) async {
    await flutterLocalNotificationsPlugin.show(
      0,
      reminder.title,
      "Hello",
      notificationDetails,
      payload: "My Channel",
    );
  }

  // to schedule a local notification
  static Future showScheduleNotification(ReminderEntity reminder) async {
    tz.initializeTimeZones();
    await flutterLocalNotificationsPlugin.zonedSchedule(
        reminder.hashCode,
        reminder.title,
        reminder.title,
        tz.TZDateTime.from(DateTime.parse(reminder.dateTime), tz.local),
        notificationDetails,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        payload: reminder.title);
  }

  static Future cancel(ReminderEntity reminder) async {
    await flutterLocalNotificationsPlugin.cancel(reminder.hashCode);
  }

  // close all the notifications available
  static Future cancelAll() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }
}

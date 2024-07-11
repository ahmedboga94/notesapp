import 'package:flutter_local_notifications/flutter_local_notifications.dart';
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
  static Future showSimpleNotification(Reminder reminder) async {
    await flutterLocalNotificationsPlugin.show(
      0,
      reminder.title,
      "Hello",
      notificationDetails,
      payload: "My Channel",
    );
  }

  // to show periodic notification at regular interval
  static Future showPeriodicNotifications(Reminder reminder) async {
    await flutterLocalNotificationsPlugin.periodicallyShow(
      1,
      reminder.title,
      "sechual hi",
      RepeatInterval.everyMinute,
      notificationDetails,
      payload: "payload",
    );
  }

  // to schedule a local notification
  static Future showScheduleNotification(Reminder reminder) async {
    tz.initializeTimeZones();
    await flutterLocalNotificationsPlugin.zonedSchedule(
        reminder.hashCode,
        reminder.title,
        reminder.title,
        tz.TZDateTime.from(reminder.dateTime, tz.local),
        notificationDetails,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        payload: reminder.title);
  }

  static Future cancel(Reminder reminder) async {
    await flutterLocalNotificationsPlugin.cancel(reminder.hashCode);
  }

  // close all the notifications available
  static Future cancelAll() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }
}

import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:notesapp/core/app_translate_keys.dart';

import '../../../../core/services/check_notification_statue.dart';

class CheckNotification extends StatefulWidget {
  const CheckNotification({super.key});

  @override
  State<CheckNotification> createState() => _CheckNotificationState();
}

class _CheckNotificationState extends State<CheckNotification> {
  bool _notificationsEnabled = false;

  Future<void> checkNotificationPermission() async {
    bool enabled = await notificationsIsEnabled();
    setState(() {
      _notificationsEnabled = enabled;
    });
  }

  @override
  void initState() {
    super.initState();
    checkNotificationPermission();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(context.notificationKey),
        subtitle: Text(
          _notificationsEnabled
              ? context.enableNotificationKey
              : context.disableNotificationKey,
        ),
        leading: const Icon(Ionicons.notifications),
      ),
    );
  }
}

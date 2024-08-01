import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

import '../../../../core/services/check_notification_statue.dart';
import 'about_developer.dart';
import 'lang_chooser_card.dart';
import 'theme_chooser_card.dart';

class SettingsBody extends StatelessWidget {
  const SettingsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Column(
        children: [
          CheckNotification(),
          Divider(),
          ThemeChooserCard(),
          LangChooserCard(),
          Spacer(),
          AboutDeveloper(),
        ],
      ),
    );
  }
}

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
        title: const Text("Notifications"),
        subtitle: Text(
          _notificationsEnabled
              ? 'Notifications are enabled'
              : 'Notifications are disabled',
        ),
        leading: const Icon(Ionicons.notifications),
      ),
    );
  }
}

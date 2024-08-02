import 'package:flutter/material.dart';
import 'about_developer.dart';
import 'check_notification.dart';
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

import 'package:flutter/material.dart';
import 'package:notesapp/core/app_translate_keys.dart';
import '../widgets/settings_body.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.settingsKey)),
      body: const SettingsBody(),
    );
  }
}

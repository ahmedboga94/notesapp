import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

import 'theme_chooser_card.dart';

class SettingsBody extends StatelessWidget {
  const SettingsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Column(
        children: [
          ThemeChooserCard(),
          LangChooserCard(),
        ],
      ),
    );
  }
}

class LangChooserCard extends StatelessWidget {
  const LangChooserCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const Icon(Ionicons.language_sharp, size: 30),
        title: const Text("Language"),
        subtitle: const Text("English"),
        onTap: () {},
      ),
    );
  }
}

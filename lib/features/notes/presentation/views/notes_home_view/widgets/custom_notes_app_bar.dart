import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:ionicons/ionicons.dart';
import 'package:notesapp/core/app_translate_keys.dart';

import '../../../../../../core/app_assets.dart';
import '../../../../../../core/app_routes.dart';

class CustomNotesAppBar extends StatelessWidget {
  const CustomNotesAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Padding(
          padding: const EdgeInsets.all(5),
          child: Hero(
              tag: AppAssets.appLogo, child: Image.asset(AppAssets.appLogo))),
      title: Text(context.notesKey),
      actions: [
        IconButton(
            onPressed: () => context.push(AppRoutes.searchView),
            icon: const Icon(Ionicons.search)),
        IconButton(
            onPressed: () => context.push(AppRoutes.settingsView),
            icon: const Icon(Ionicons.settings)),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';
import 'package:notesapp/core/app_translate_keys.dart';

import '../../../../core/utils/custom_show_dialog.dart';
import '../cubit/theme/theme_cubit.dart';
import 'theme_selector_radio.dart';

class ThemeChooserCard extends StatelessWidget {
  const ThemeChooserCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return Card(
          child: ListTile(
            leading: Icon(
                state is LightThemeState
                    ? Ionicons.sunny
                    : state is DarkThemeState
                        ? Ionicons.moon
                        : Ionicons.phone_portrait,
                size: 30),
            title: Text(context.themeKey,
                style: Theme.of(context).textTheme.labelLarge),
            subtitle: Text(state is LightThemeState
                ? context.lightThemeKey
                : state is DarkThemeState
                    ? context.darkThemeKey
                    : context.systemThemeKey),
            onTap: () {
              customShowDialog(
                  context: context,
                  title: context.selectThemeKey,
                  content: const ThemeSelectorRadio());
            },
          ),
        );
      },
    );
  }
}

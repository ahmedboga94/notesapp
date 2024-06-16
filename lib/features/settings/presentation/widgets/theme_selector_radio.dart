import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notesapp/core/app_translate_keys.dart';

import '../../../../core/enums/theme_enum.dart';
import '../cubit/theme/theme_cubit.dart';

class ThemeSelectorRadio extends StatelessWidget {
  const ThemeSelectorRadio({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RadioListTile(
                title: Text(context.lightThemeKey),
                value: ThemeEnum.lightTheme,
                groupValue: state.selectedTheme,
                onChanged: (ThemeEnum? themeSelected) {
                  context.read<ThemeCubit>().setTheme(themeSelected!);
                }),
            RadioListTile(
                title: Text(context.darkThemeKey),
                value: ThemeEnum.darkTheme,
                groupValue: state.selectedTheme,
                onChanged: (ThemeEnum? themeSelected) {
                  context.read<ThemeCubit>().setTheme(themeSelected!);
                }),
            RadioListTile(
                title: Text(context.systemThemeKey),
                value: ThemeEnum.systemTheme,
                groupValue: state.selectedTheme,
                onChanged: (ThemeEnum? themeSelected) {
                  context.read<ThemeCubit>().setTheme(themeSelected!);
                }),
          ],
        );
      },
    );
  }
}

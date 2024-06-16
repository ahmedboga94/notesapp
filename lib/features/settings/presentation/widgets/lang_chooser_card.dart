import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';
import 'package:notesapp/core/app_translate_keys.dart';

import '../../../../core/app_strings.dart';
import '../../../../core/utils/custom_show_dialog.dart';
import '../cubit/lang/lang_cubit.dart';

class LangChooserCard extends StatelessWidget {
  const LangChooserCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const Icon(Ionicons.language_sharp, size: 30),
        title: Text(context.languageKey),
        subtitle: Text(context.langSelectedKey),
        onTap: () => customShowDialog(
          context: context,
          isConfirm: false,
          title: context.selectLanguageKey,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text(context.arabicKey),
                onTap: () {
                  context
                      .read<LangCubit>()
                      .setLocale((const Locale(AppStrings.setArabic)));
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                title: Text(context.englishKey),
                onTap: () {
                  context
                      .read<LangCubit>()
                      .setLocale(const Locale(AppStrings.setEnglish));
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

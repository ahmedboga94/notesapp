import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:ionicons/ionicons.dart';
import 'package:notesapp/core/app_translate_keys.dart';

import '../../../../../../core/app_assets.dart';
import '../../../../../../core/app_routes.dart';
import '../../../../../../core/app_search.dart';
import '../../../cubit/notes/notes_cubit.dart';

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
        BlocBuilder<NotesCubit, NotesState>(
          builder: (context, state) {
            if (state is SuccessNotesState) {
              return IconButton(
                  onPressed: () {
                    showSearch(
                      context: context,
                      delegate: AppSearchDelegate(state.notes),
                    );
                  },
                  icon: const Icon(Ionicons.search));
            } else {
              return const SizedBox();
            }
          },
        ),
        IconButton(
            onPressed: () => context.push(AppRoutes.settingsView),
            icon: const Icon(Ionicons.settings)),
      ],
    );
  }
}

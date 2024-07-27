import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ionicons/ionicons.dart';
import 'package:notesapp/core/app_colors.dart';
import 'package:notesapp/core/app_translate_keys.dart';

import '../../../../../../core/app_assets.dart';
import '../../../../../../core/app_routes.dart';
import '../../../../../../core/services/app_search_notes.dart';
import '../../../../../../core/utils/confirm_to_delete.dart';
import '../../../cubit/notes/notes_cubit.dart';

class CustomNotesAppBar extends StatelessWidget {
  const CustomNotesAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotesCubit, NotesState>(
      builder: (context, state) {
        final notesCubit = context.read<NotesCubit>();
        final selectedItems = notesCubit.selectedItems;
        final isMultiSelectionEnabled = notesCubit.isMultiSelectionEnabled;
        return AppBar(
          centerTitle: isMultiSelectionEnabled ? false : true,
          leading: isMultiSelectionEnabled
              ? IconButton(
                  onPressed: () {
                    notesCubit.clearSelection();
                    notesCubit.toggleMultiSelection(false);
                  },
                  icon: const Icon(Ionicons.close))
              : Padding(
                  padding: const EdgeInsets.all(5),
                  child: Hero(
                      tag: AppAssets.appLogo,
                      child: Image.asset(AppAssets.appLogo)),
                ),
          title: Text(isMultiSelectionEnabled
              ? selectedItems.isNotEmpty
                  ? "${selectedItems.length} ${context.itemSelectedKey}"
                  : context.noItemSelectedKey
              : context.notesKey),
          actions: isMultiSelectionEnabled
              ? [
                  Visibility(
                      visible: selectedItems.isNotEmpty,
                      child: IconButton(
                          icon: const Icon(Ionicons.trash_outline),
                          onPressed: () => confirmToDelete(
                              context: context,
                              onPressed: () {
                                for (var notes in selectedItems) {
                                  notesCubit.deleteNote(notes);
                                }
                                notesCubit.clearSelection();
                                GoRouter.of(context).pop();
                              }))),
                  Visibility(
                      visible: isMultiSelectionEnabled,
                      child: IconButton(
                          icon: Icon(
                            selectedItems.length ==
                                    (state as SuccessNotesState).notes.length
                                ? Ionicons.checkbox_outline
                                : Ionicons.square_outline,
                            color: AppColors.lightGreyColor,
                          ),
                          onPressed: () {
                            notesCubit.selectAll();
                          })),
                ]
              : [
                  state is SuccessNotesState
                      ? IconButton(
                          onPressed: () {
                            showSearch(
                              context: context,
                              delegate: AppSearchNotesDelegate(state.notes),
                            );
                          },
                          icon: const Icon(Ionicons.search))
                      : const SizedBox(),
                  IconButton(
                      onPressed: () => context.push(AppRoutes.settingsView),
                      icon: const Icon(Ionicons.settings)),
                ],
        );
      },
    );
  }
}

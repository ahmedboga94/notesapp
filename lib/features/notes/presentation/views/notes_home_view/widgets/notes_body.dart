import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notesapp/core/app_translate_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../../core/app_assets.dart';
import '../../../../../../core/app_colors.dart';
import '../../../../../../core/app_strings.dart';
import '../../../../../../core/di.dart';
import '../../../cubit/notes/notes_cubit.dart';
import 'custom_note_card.dart';

class NotesBody extends StatelessWidget {
  const NotesBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotesCubit, NotesState>(
      builder: (context, state) {
        final noteCubit = context.read<NotesCubit>();
        return state is SuccessNotesState
            ? state.notes.isNotEmpty
                ? PopScope(
                    canPop: !noteCubit.isMultiSelectionEnabled,
                    onPopInvoked: (didPop) {
                      if (noteCubit.isMultiSelectionEnabled) {
                        noteCubit.toggleMultiSelection(false);
                        noteCubit.clearSelection();
                      }
                    },
                    child: Padding(
                        padding: const EdgeInsets.all(14),
                        child: ListView.builder(
                            itemCount: state.notes.length,
                            itemBuilder: (context, index) {
                              return CustomNoteCard(
                                noteEntity: state.notes[index],
                                isMultiSelection: true,
                              );
                            })),
                  )
                : Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(context.addNewNotesKey,
                            style: Theme.of(context).textTheme.headlineSmall),
                        const SizedBox(height: 20),
                        Transform.flip(
                          flipX: di<SharedPreferences>()
                                  .getString(AppStrings.setLang) ==
                              AppStrings.setArabic,
                          child: Image.asset(
                            AppAssets.arrowAdd,
                            scale: 1.5,
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ],
                    ),
                  )
            : state is FailureNotesState
                ? Center(
                    child: Text(
                    state.errorMsg,
                    style: Theme.of(context).textTheme.headlineLarge,
                  ))
                : const SizedBox();
      },
    );
  }
}

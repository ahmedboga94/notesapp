import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ionicons/ionicons.dart';
import 'package:notesapp/core/utils/confirm_to_delete.dart';

import '../../../../../../core/app_colors.dart';
import '../../../../../../core/app_routes.dart';
import '../../../../domain/entities/note_entity.dart';
import '../../../cubit/notes/notes_cubit.dart';

class CustomNoteCard extends StatelessWidget {
  final NoteEntity noteEntity;
  final bool isMultiSelection;

  const CustomNoteCard(
      {super.key, required this.noteEntity, this.isMultiSelection = false});

  @override
  Widget build(BuildContext context) {
    final noteCubit = context.read<NotesCubit>();
    final selectedItems = noteCubit.selectedItems;
    return BlocConsumer<NotesCubit, NotesState>(
      builder: (context, state) {
        return state is SuccessNotesState
            ? GestureDetector(
                onTap: () {
                  if (noteCubit.isMultiSelectionEnabled) {
                    noteCubit.toggleSelection(noteEntity);
                  } else {
                    GoRouter.of(context)
                        .push(AppRoutes.noteDetailsView, extra: noteEntity);
                  }
                },
                onLongPress: () {
                  if (isMultiSelection) {
                    noteCubit.toggleMultiSelection(true);
                    noteCubit.toggleSelection(noteEntity);
                  }
                },
                child: Card(
                  color: Color(noteEntity.color),
                  child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(noteEntity.title,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineMedium!
                                        .copyWith(color: AppColors.darkColor)),
                              ),
                              noteCubit.isMultiSelectionEnabled
                                  ? IconButton(
                                      icon: Icon(
                                        selectedItems.contains(noteEntity)
                                            ? Ionicons.checkmark_circle
                                            : Ionicons.ellipse_outline,
                                        size: 30,
                                        color: AppColors.darkColor,
                                      ),
                                      onPressed: null,
                                    )
                                  : IconButton(
                                      padding: EdgeInsets.zero,
                                      constraints: const BoxConstraints(),
                                      onPressed: () => confirmToDelete(
                                          context: context,
                                          onPressed: () {
                                            context
                                                .read<NotesCubit>()
                                                .deleteNote(noteEntity);
                                            GoRouter.of(context).pop();
                                          }),
                                      icon: const Icon(Ionicons.close_circle,
                                          size: 28,
                                          color: AppColors.darkColor)),
                            ],
                          ),
                          Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: Opacity(
                                opacity: 0.5,
                                child: Text(noteEntity.subTitle,
                                    maxLines: 2,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(color: AppColors.darkColor)),
                              )),
                          Align(
                            alignment: AlignmentDirectional.bottomEnd,
                            child: Opacity(
                              opacity: 0.7,
                              child: Text(noteEntity.dateTime,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall!
                                      .copyWith(color: AppColors.darkColor)),
                            ),
                          ),
                        ],
                      )),
                ))
            : const SizedBox();
      },
      listener: (context, state) {
        if (state is SuccessNotesState) {
          if (noteCubit.isMultiSelectionEnabled && selectedItems.isEmpty) {
            // noteCubit.toggleMultiSelection(false);
          }
        }
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/enums/add_edit_note_enum.dart';
import '../../domain/entities/note_entity.dart';
import '../cubit/notes/notes_cubit.dart';
import 'add_update_note_form.dart';

class AddOrUpdateNoteView extends StatelessWidget {
  final AddUpdateNoteEnum addEditNoteEnum;
  final NoteEntity? noteEntity;

  const AddOrUpdateNoteView({
    super.key,
    required this.addEditNoteEnum,
    this.noteEntity,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: SingleChildScrollView(
          child: BlocConsumer<NotesCubit, NotesState>(
        listener: (context, state) {
          if (state is SuccessNotesState) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(addEditNoteEnum == AddUpdateNoteEnum.addNoteView
                    ? "Note Added Successfuly"
                    : "Note Updated Successfuly")));
            GoRouter.of(context).pop();
          }
          if (state is FailureNotesState) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.errorMsg)));
          }
        },
        builder: (context, state) {
          return AddUpdateNoteForm(
              addEditNoteEnum: addEditNoteEnum, noteEntity: noteEntity);
        },
      )),
    );
  }
}

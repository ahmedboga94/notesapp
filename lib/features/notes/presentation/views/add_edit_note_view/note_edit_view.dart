import 'package:flutter/material.dart';
import 'package:notesapp/core/app_translate_keys.dart';

import '../../../../../core/enums/add_edit_note_enum.dart';
import '../../../domain/entities/note_entity.dart';
import '../../widgets/add_update_note_view.dart';

class NoteEditView extends StatelessWidget {
  final NoteEntity? noteEntity;
  const NoteEditView({super.key, this.noteEntity});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.editNoteViewKey)),
      body: AddOrUpdateNoteView(
          noteEntity: noteEntity!,
          addEditNoteEnum: AddUpdateNoteEnum.editNoteView),
    );
  }
}

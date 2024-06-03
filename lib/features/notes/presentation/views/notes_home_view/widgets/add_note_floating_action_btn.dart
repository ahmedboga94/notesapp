import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

import '../../../../../../core/enums/add_edit_note_enum.dart';
import '../../../../domain/entities/note_entity.dart';
import '../../../widgets/add_update_note_view.dart';

class AddNoteFloatingActionBtn extends StatelessWidget {
  final NoteEntity? noteEntity;
  const AddNoteFloatingActionBtn({super.key, this.noteEntity});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        showModalBottomSheet(
            isScrollControlled: true,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
              topRight: Radius.circular(20.0),
              topLeft: Radius.circular(20.0),
            )),
            context: context,
            builder: (context) => Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: const AddOrUpdateNoteView(
                      addEditNoteEnum: AddUpdateNoteEnum.addNoteView),
                ));
      },
      child: const Icon(Ionicons.add),
    );
  }
}

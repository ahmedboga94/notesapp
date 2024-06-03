import 'package:flutter/material.dart';

import 'widgets/add_note_floating_action_btn.dart';
import 'widgets/custom_notes_app_bar.dart';
import 'widgets/notes_body.dart';

class NotesView extends StatelessWidget {
  const NotesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(AppBar().preferredSize.height),
          child: const CustomNotesAppBar()),
      floatingActionButton: const AddNoteFloatingActionBtn(),
      body: const NotesBody(),
    );
  }
}

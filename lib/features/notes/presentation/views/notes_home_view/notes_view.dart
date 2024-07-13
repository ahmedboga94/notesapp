import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notesapp/features/notes/presentation/cubit/notes/notes_cubit.dart';

import 'widgets/add_note_floating_action_btn.dart';
import 'widgets/custom_notes_app_bar.dart';
import 'widgets/notes_body.dart';

class NotesView extends StatelessWidget {
  const NotesView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotesCubit, NotesState>(
      builder: (context, state) {
        return Scaffold(
          appBar: PreferredSize(
              preferredSize: Size.fromHeight(AppBar().preferredSize.height),
              child: const CustomNotesAppBar()),
          floatingActionButton: Visibility(
              visible: !context.read<NotesCubit>().isMultiSelectionEnabled,
              child: const AddNoteFloatingActionBtn()),
          body: const NotesBody(),
        );
      },
    );
  }
}

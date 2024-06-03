import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../cubit/notes/notes_cubit.dart';
import 'custom_note_card.dart';

class NotesBody extends StatelessWidget {
  const NotesBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotesCubit, NotesState>(
      builder: (context, state) {
        return state is SuccessNotesState
            ? state.notes.isNotEmpty
                ? Container(
                    padding: const EdgeInsets.all(14),
                    child: ListView.builder(
                        itemCount: state.notes.length,
                        itemBuilder: (context, index) {
                          return CustomNoteCard(noteEntity: state.notes[index]);
                        }))
                : Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Add new Note from here",
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        const SizedBox(height: 20),
                        const Icon(
                          Icons.arrow_downward,
                          size: 40,
                          color: Colors.grey,
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
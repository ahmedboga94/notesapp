import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/note_entity.dart';
import '../../../domain/usecases/add_note_use_case.dart';
import '../../../domain/usecases/delete_note_use_case.dart';
import '../../../domain/usecases/get_notes_use_case.dart';
import '../../../domain/usecases/update_note_use_case.dart';
import 'package:notesapp/core/app_failures.dart';

part 'notes_state.dart';

class NotesCubit extends Cubit<NotesState> {
  final GetNotesUseCase getNotesUseCase;
  final AddNoteUseCase addNoteUseCase;
  final UpdateNoteUseCase updateNoteUseCase;
  final DeleteNoteUseCase deleteNoteUseCase;

  NotesCubit({
    required this.getNotesUseCase,
    required this.addNoteUseCase,
    required this.updateNoteUseCase,
    required this.deleteNoteUseCase,
  }) : super(InitialNotesState());

  Color currentColor = const Color(0xff6153CC);

  void getNotes() {
    Either<Failure, List<NoteEntity>> notes = getNotesUseCase.call();
    notes.fold(
      (fail) => emit(FailureNotesState(fail.failureMessage)),
      (success) => emit(SuccessNotesState(success)),
    );
  }

  void addNote(NoteEntity addNote) {
    addNote.color = currentColor.value;
    Either<Failure, Unit> note = addNoteUseCase.call(addNote);
    foldMethod(note);
  }

  void updateNote(NoteEntity updateNote) {
    updateNote.color = currentColor.value;
    Either<Failure, Unit> note = updateNoteUseCase.call(updateNote);
    foldMethod(note);
  }

  void deleteNote(NoteEntity deleteNote) {
    Either<Failure, Unit> note = deleteNoteUseCase.call(deleteNote);
    foldMethod(note);
  }

  void changeColor(Color color) {
    currentColor = color;
    emit(ColorChangedState(color));
  }

  void foldMethod(Either<Failure, Unit> note) {
    note.fold(
      (fail) => emit(FailureNotesState(fail.failureMessage)),
      (success) => getNotes(),
    );
  }
}

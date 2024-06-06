part of 'notes_cubit.dart';

abstract class NotesState {}

class InitialNotesState extends NotesState {}

class SuccessNotesState extends NotesState {
  final List<NoteEntity> notes;

  SuccessNotesState(this.notes);
}

class FailureNotesState extends NotesState {
  final String errorMsg;

  FailureNotesState(this.errorMsg);
}

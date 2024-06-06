part of 'notes_cubit.dart';

abstract class NotesState {}

final class InitialNotesState extends NotesState {}

final class SuccessNotesState extends NotesState {
  final List<NoteEntity> notes;

  SuccessNotesState(this.notes);
}

final class FailureNotesState extends NotesState {
  final String errorMsg;

  FailureNotesState(this.errorMsg);
}

class ColorChangedState extends NotesState {
  final Color color;

  ColorChangedState(this.color);
}

import 'dart:collection';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notesapp/core/app_colors.dart';

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

  Color selectedColor = AppColors.colorsList[0];
  final HashSet<NoteEntity> _selectedItems = HashSet();
  bool isMultiSelectionEnabled = false;

  HashSet<NoteEntity> get selectedItems => _selectedItems;

  void getNotes() {
    Either<Failure, List<NoteEntity>> notes = getNotesUseCase.call();
    notes.fold(
      (fail) => emit(FailureNotesState(fail.failureMessage)),
      (success) => emit(SuccessNotesState(success)),
    );
  }

  void addNote(NoteEntity addNote) {
    addNote.color = selectedColor.value;
    Either<Failure, Unit> note = addNoteUseCase.call(addNote);
    foldMethod(note);
  }

  void updateNote(NoteEntity updateNote) {
    updateNote.color = selectedColor.value;
    Either<Failure, Unit> note = updateNoteUseCase.call(updateNote);
    foldMethod(note);
  }

  void deleteNote(NoteEntity deleteNote) {
    Either<Failure, Unit> note = deleteNoteUseCase.call(deleteNote);
    foldMethod(note);
  }

  void changeColor(Color color) {
    selectedColor = color;
  }

  void foldMethod(Either<Failure, Unit> note) {
    note.fold(
      (fail) => emit(FailureNotesState(fail.failureMessage)),
      (success) => getNotes(),
    );
  }

//////////// multi selection /////////////

  void toggleMultiSelection(bool enabled) {
    isMultiSelectionEnabled = enabled;
    if (state is SuccessNotesState) {
      emit(SuccessNotesState((state as SuccessNotesState).notes));
    }
  }

  void toggleSelection(NoteEntity notes) {
    if (_selectedItems.contains(notes)) {
      _selectedItems.remove(notes);
    } else {
      _selectedItems.add(notes);
    }
    if (state is SuccessNotesState) {
      emit(SuccessNotesState((state as SuccessNotesState).notes));
    }
  }

  void clearSelection() {
    _selectedItems.clear();
    isMultiSelectionEnabled = false;
    if (state is SuccessNotesState) {
      emit(SuccessNotesState((state as SuccessNotesState).notes));
    }
  }

  void selectAll() {
    if (state is SuccessNotesState) {
      if (_selectedItems.length == (state as SuccessNotesState).notes.length) {
        _selectedItems.clear();
      } else {
        _selectedItems.addAll((state as SuccessNotesState).notes);
      }
      emit(SuccessNotesState((state as SuccessNotesState).notes));
    }
  }
}

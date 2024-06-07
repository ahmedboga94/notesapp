import 'package:hive_flutter/adapters.dart';

import '../../domain/entities/note_entity.dart';

abstract class LocalNotesDataSource {
  List<NoteEntity> getNotes();
  void addNote(NoteEntity addNote);
  void updateNote(NoteEntity updateNote);
  void deleteNote(NoteEntity deleteNote);
}

class LocalNotesDataSourceImpl implements LocalNotesDataSource {
  final Box<NoteEntity> notesBox;

  LocalNotesDataSourceImpl(this.notesBox);

  @override
  List<NoteEntity> getNotes() {
    return notesBox.values.toList();
  }

  @override
  void addNote(NoteEntity addNote) {
    notesBox.add(addNote);
  }

  @override
  void deleteNote(NoteEntity deleteNote) {
    notesBox.delete(deleteNote.key);
  }

  @override
  void updateNote(NoteEntity updateNote) {
    notesBox.put(updateNote.key, updateNote);
  }
}

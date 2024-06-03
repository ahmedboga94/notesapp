import 'package:dartz/dartz.dart';

import '../../../../core/app_failures.dart';
import '../entities/note_entity.dart';

abstract class NotesRepo {
  Either<Failure, List<NoteEntity>> getNotes();
  Either<Failure, Unit> addNote(NoteEntity addNote);
  Either<Failure, Unit> updateNote(NoteEntity updateNote);
  Either<Failure, Unit> deleteNote(NoteEntity deleteNote);
}

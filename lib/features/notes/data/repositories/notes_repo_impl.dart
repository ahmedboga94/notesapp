import 'package:dartz/dartz.dart';

import '../../../../core/app_failures.dart';
import '../../domain/entities/note_entity.dart';
import '../../domain/repositories/notes_repo.dart';
import '../datasources/local_data_source.dart';

class NotesRepoImpl implements NotesRepo {
  final LocalNotesDataSource localNotesDataSource;

  NotesRepoImpl(this.localNotesDataSource);

  @override
  Either<Failure, List<NoteEntity>> getNotes() {
    try {
      return right(localNotesDataSource.getNotes());
    } catch (e) {
      return left(Failure("Error in fetching Notes"));
    }
  }

  @override
  Either<Failure, Unit> addNote(NoteEntity addNote) {
    try {
      localNotesDataSource.addNote(addNote);
      return right(unit);
    } catch (e) {
      return left(Failure("Error in Adding Notes"));
    }
  }

  @override
  Either<Failure, Unit> deleteNote(NoteEntity deleteNote) {
    try {
      localNotesDataSource.deleteNote(deleteNote);
      return right(unit);
    } catch (e) {
      return left(Failure("Error in Deleting Notes"));
    }
  }

  @override
  Either<Failure, Unit> updateNote(NoteEntity updateNote) {
    try {
      localNotesDataSource.updateNote(updateNote);
      return right(unit);
    } catch (e) {
      return left(Failure("Error in Updating Notes"));
    }
  }
}

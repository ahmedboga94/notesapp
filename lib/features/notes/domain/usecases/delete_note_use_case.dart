import 'package:dartz/dartz.dart';

import '../../../../core/app_failures.dart';
import '../entities/note_entity.dart';
import '../repositories/notes_repo.dart';

class DeleteNoteUseCase {
  final NotesRepo notesRepo;

  DeleteNoteUseCase(this.notesRepo);

  Either<Failure, Unit> call(NoteEntity deleteNote) {
    return notesRepo.deleteNote(deleteNote);
  }
}

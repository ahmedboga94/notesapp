import 'package:dartz/dartz.dart';

import '../../../../core/app_failures.dart';
import '../entities/note_entity.dart';
import '../repositories/notes_repo.dart';

class UpdateNoteUseCase {
  final NotesRepo notesRepo;

  UpdateNoteUseCase(this.notesRepo);

  Either<Failure, Unit> call(NoteEntity updateNote) {
    return notesRepo.updateNote(updateNote);
  }
}

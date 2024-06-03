import 'package:dartz/dartz.dart';
import 'package:notesapp/features/notes/domain/entities/note_entity.dart';
import 'package:notesapp/features/notes/domain/repositories/notes_repo.dart';

import '../../../../core/app_failures.dart';

class AddNoteUseCase {
  final NotesRepo notesRepo;

  AddNoteUseCase(this.notesRepo);

  Either<Failure, Unit> call(NoteEntity addNote) {
    return notesRepo.addNote(addNote);
  }
}

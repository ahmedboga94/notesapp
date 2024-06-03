import 'package:dartz/dartz.dart';
import 'package:notesapp/features/notes/domain/entities/note_entity.dart';
import 'package:notesapp/features/notes/domain/repositories/notes_repo.dart';

import '../../../../core/app_failures.dart';

class GetNotesUseCase {
  final NotesRepo notesRepo;

  GetNotesUseCase(this.notesRepo);

  Either<Failure, List<NoteEntity>> call() {
    return notesRepo.getNotes();
  }
}

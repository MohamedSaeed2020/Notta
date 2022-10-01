import 'package:notes/data_layer/models/note_model.dart';
import 'package:notes/data_layer/repositories/notes_repos/local_notes_repository.dart';
import 'package:notes/data_layer/repositories/notes_repos/notes_base_repository.dart';
import 'package:notes/data_layer/web_services/notes_web_service.dart';

class RemoteNotesRepo extends NotesBaseRepository{
  final NotesWebService notesWebService;

  RemoteNotesRepo(this.notesWebService);
  LocalNotesRepo localNotesRepo=LocalNotesRepo();

  @override
  Future<String> addNewNote({
    required String userId,
    required String noteText,
  }) async {
    final allNotes = await notesWebService.addNewNote(
        userId: userId, noteText: noteText);
    return allNotes;
  }

  @override
  Future<List<NoteModel>> getAllNotes() async {
    final allNotes = await notesWebService.getAllNotes();
    final notes= allNotes.map((allNotes) => NoteModel.fromJson(allNotes)).toList();
    localNotesRepo.saveNotesLocally(notes: notes);
    return notes;
  }

  @override
  Future<String> updateNote({
    required String noteId,
    required String userId,
    required String noteText,
  }) async {
    final allNotes = await notesWebService.updateNote(
        noteId: noteId, userId: userId, noteText: noteText);
    return allNotes;
  }

  @override
  Future<String> deleteAllNotes() async {
    final allNotes = await notesWebService.deleteAllNotes();
    return allNotes;
  }


}

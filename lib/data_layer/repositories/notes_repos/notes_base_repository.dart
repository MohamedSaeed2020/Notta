import 'package:notes/data_layer/models/note_model.dart';

abstract class NotesBaseRepository {

  Future<String> addNewNote({
    required String userId,
    required String noteText,
  });

  Future<List<NoteModel>> getAllNotes();

  Future<String> updateNote({
    required String noteId,
    required String userId,
    required String noteText,
  });

  Future<String> deleteAllNotes();
}

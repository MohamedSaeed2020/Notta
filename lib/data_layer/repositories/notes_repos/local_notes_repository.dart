import 'dart:developer';

import 'package:notes/core/network/local/local_database_constants.dart';
import 'package:notes/core/network/local/local_database_helper.dart';
import 'package:notes/data_layer/models/note_model.dart';
import 'package:notes/data_layer/repositories/notes_repos/notes_base_repository.dart';

class LocalNotesRepo extends NotesBaseRepository {

  @override
  Future<String> addNewNote(
      {required String userId, required String noteText}) async {
    int rowNumber = await LocalDatabaseHelper.insertDataIntoDatabase('''
    ${LocalDatabaseConstants.insertDataIntoTableSql} note
    (text, placeDateTime, userId)  
    VALUES
    ("$noteText", "${DateTime.now().toIso8601String()}", "$userId")
    ''');

    return rowNumber.toString();
  }

  @override
  Future<String> deleteAllNotes() async {
    try {
      await LocalDatabaseHelper.deleteTableData('note');
      return 'deleted successfully';
    } catch (e) {
      return 'error deleting';
    }
  }

  @override
  Future<List<NoteModel>> getAllNotes() async {
    List<Map<String, Object?>> notes =
        await LocalDatabaseHelper.getDataFromDatabase('${LocalDatabaseConstants.getAllDataFromTableSql} note');
    if (notes.isNotEmpty) {
      //log('Local getAllNotes isNotEmpty: $notes');
      return notes.map((notes) => NoteModel.fromJson(notes)).toList();
    } else {
      log('Local getAllNotes: ${notes.length}');
      return [];
    }
  }

  @override
  Future<String> updateNote(
      {required String noteId,
      required String userId,
      required String noteText}) async {
    int number = await LocalDatabaseHelper.updateDataFromDatabase('''
        UPDATE note SET text = ?, userId = ?, PlaceDateTime = ?
        WHERE id = ?
      ''', [
      noteText,
      userId,
      DateTime.now().toIso8601String(),
      noteId,
    ]);
    return number.toString();
  }

  Future<void> saveNotesLocally({required List<NoteModel> notes}) async {
    await LocalDatabaseHelper.deleteTableData('note');
    for (var note in notes) {
      await LocalDatabaseHelper.insertDataIntoDatabase('''
    ${LocalDatabaseConstants.insertDataIntoTableSql} note
    (text, placeDateTime, userId) 
    VALUES
    ("${note.noteText}", "${note.notePlaceDateTime}", "${note.noteUserId}")
    ''');
    }
  }
}

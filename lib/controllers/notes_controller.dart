import 'dart:developer';

import 'package:get/get.dart';
import 'package:notes/core/helpers/app_helpers.dart';
import 'package:notes/core/network/local/cache_helper.dart';
import 'package:notes/core/network/local/storage_keys.dart';
import 'package:notes/core/routes/app_router.dart';
import 'package:notes/core/services/users_services.dart';
import 'package:notes/data_layer/models/note_model.dart';
import 'package:notes/data_layer/repositories/notes_repos/local_notes_repository.dart';
import 'package:notes/data_layer/repositories/notes_repos/notes_base_repository.dart';
import 'package:notes/data_layer/repositories/notes_repos/remote_notes_repository.dart';
import 'package:notes/data_layer/web_services/notes_web_service.dart';

class NotesController extends GetxController {
  late NotesBaseRepository notesRepo;
  List<NoteModel> allNotesList = [];
  List<NoteModel> searchedNotesList = [];
  bool isLoading = false;
  bool isSearchFieldVisible = false;
  final UsersServices usersServices = Get.find<UsersServices>();

  @override
  Future<void> onInit() async {
    super.onInit();
    switchBetweenLocalAndRemote();
  }

  void navigateToSetting() {
    Get.toNamed(AppRoutes.settingsScreen)!.then((value) async {
      switchBetweenLocalAndRemote();
    });
  }

  void switchBetweenLocalAndRemote() {
    usersServices.switchBetweenLocalAndRemote();
    notesRepo =
        CacheHelper.getData(key: StorageKeys.localStorageActivated) ?? false
            ? LocalNotesRepo()
            : RemoteNotesRepo(NotesWebService());
    getAllNotes();
  }

  void changeSearchFieldVisibility() {
    isSearchFieldVisible = !isSearchFieldVisible;
    update();
  }

  void searchNotes(String searchKeyword) {
    List<NoteModel> results = [];
    if (searchKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      getAllNotes();
    } else {
      results = searchedNotesList
          .where((note) =>
              note.noteText.toLowerCase().contains(searchKeyword.toLowerCase()))
          .toList();
      // we use the toLowerCase() method to make it case-insensitive
    }

    // Refresh the UI
    allNotesList = results;
    update();
  }

  void filterNotesByUser(String userId) {
    List<NoteModel> results = [];

    results =
        searchedNotesList.where((note) => note.noteUserId == userId).toList();
    allNotesList = results;
    update();
  }

  void addNewNote({
    required String userId,
    required String noteText,
  }) {
    isLoading = true;
    update();
    notesRepo
        .addNewNote(userId: userId, noteText: noteText)
        .then((creatingMessage) {
      AppHelpers.showSnackBar('Note Has Been Added successfully', 'success');
      isLoading = false;
      update();
      log('addNewNote success controller: $creatingMessage}');
      getAllNotes();
    }).catchError((error) {
      isLoading = false;
      update();
      log("Error in addNewNote NotesController: $error");
    });
  }

  void deleteAllNotes() {
    isLoading = true;
    update();
    notesRepo.deleteAllNotes().then((deletionMessage) {
      AppHelpers.showSnackBar('Note Has Been Deleted successfully', 'success');
      isLoading = false;
      update();
      log('deleteAllNotes success controller: $deletionMessage}');
      getAllNotes();
    }).catchError((error) {
      isLoading = false;
      update();
      log("Error in deleteAllNotes NotesController: $error");
    });
  }

  Future<void> getAllNotes() async {
    isLoading = true;
    update();
    notesRepo.getAllNotes().then((allNotes) {
      allNotesList = allNotes;
      searchedNotesList = allNotes;
      isLoading = false;
      update();
      if (searchedNotesList.isNotEmpty) {
        log('getAllNotes(${notesRepo.runtimeType}) success controller: ${allNotesList[0].noteText}');
      } else {
        log('getAllNotes(${notesRepo.runtimeType})  success Empty NotesController:');
      }
    }).catchError((error) {
      isLoading = false;
      update();
      log("Error in getAllNotes NotesController: $error");
    });
  }

  void updateNote(
      {required String noteId,
      required String userId,
      required String noteText}) {
    notesRepo
        .updateNote(noteId: noteId, userId: userId, noteText: noteText)
        .then((updateMessage) {
      AppHelpers.showSnackBar('Note Has Been Edited successfully', 'success');
      getAllNotes();
      log('updateNote success controller: $updateMessage}');
    }).catchError((error) {
      AppHelpers.showSnackBar('Error Occurred', 'error');
      log("Error in updateNote NotesController: $error");
    });
  }
}

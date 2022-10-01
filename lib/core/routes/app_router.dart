import 'package:get/get.dart';
import 'package:notes/presentations/pages/add_new_user_screen.dart';
import 'package:notes/presentations/pages/new_note_screen.dart';
import 'package:notes/presentations/pages/note_details_screen.dart';
import 'package:notes/presentations/pages/settings_screen.dart';

class AppRoutes {
  static String noteDetailsScreen = "/noteDetailsScreen";
  static String addNewUserScreen = "/addNewUserScreen";
  static String settingsScreen = "/settingsScreen";
  static String newNoteScreen = "/newNoteScreen";

  static List<GetPage> routes = [
    GetPage(name: noteDetailsScreen, page: () => const NoteDetailsScreen()),
    GetPage(name: addNewUserScreen, page: () => const AddNewUserScreen()),
    GetPage(name: settingsScreen, page: () => const SettingsScreen()),
    GetPage(name: newNoteScreen, page: () => const AddingNewNoteScreen()),
  ];
}

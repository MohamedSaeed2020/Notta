import 'package:get/get.dart';
import 'package:notes/controllers/notes_controller.dart';
import 'package:notes/controllers/settings_controller.dart';
import 'package:notes/controllers/users_controller.dart';


class Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NotesController(),
        fenix: true);
    Get.lazyPut(() => UsersController(), fenix: true);
    Get.lazyPut(() => SettingsController(), fenix: true);
  }
}

import 'package:get/get.dart';
import 'package:notes/core/network/local/cache_helper.dart';
import 'package:notes/core/network/local/storage_keys.dart';

class SettingsController extends GetxController {

  void isLocalDatabaseActivated(bool isActivated) {
    CacheHelper.saveData(
        key: StorageKeys.localStorageActivated, value: isActivated);
    update();
  }
}

import 'dart:developer';

import 'package:get/get.dart';
import 'package:notes/core/network/local/cache_helper.dart';
import 'package:notes/core/network/local/storage_keys.dart';
import 'package:notes/data_layer/models/interest_model.dart';
import 'package:notes/data_layer/models/user_model.dart';
import 'package:notes/data_layer/repositories/users_repo/local_users_repository.dart';
import 'package:notes/data_layer/repositories/users_repo/remote_users_repository.dart';
import 'package:notes/data_layer/repositories/users_repo/users_base_repository.dart';
import 'package:notes/data_layer/web_services/users_web_service.dart';

class UsersServices extends GetxService {
  List<UserModel> allUsersList = [];
  List<InterestModel> allInterestsList = [];
  late UsersBaseRepository usersRepo;


  void switchBetweenLocalAndRemote() {
    usersRepo =
        CacheHelper.getData(key: StorageKeys.localStorageActivated) ?? false
            ? LocalUsersRepo()
            : RemoteUsersRepo(UsersWebService());
    Future.wait(
      [getAllUsers(), getAllInterests()],
    );
    log('Database Type: ${CacheHelper.getData(key: StorageKeys.localStorageActivated)}');
  }

  Future<void> getAllUsers() async {
    usersRepo.getAllUsers().then((allUsers) {
      allUsersList = allUsers;
      if (allUsersList.isNotEmpty) {
        log('getAllUsers(${usersRepo.runtimeType}) success UsersController: ${allUsers[0].userName}');
      } else {
        log('getAllUsers(${usersRepo.runtimeType}) success Empty UsersController:');
      }
    }).catchError((error) {
      log("Error in getAllUsers UsersController: $error");
    });
  }

  Future<void> getAllInterests() async {
    usersRepo.getAllInterests().then((allInterests) {
      allInterestsList = allInterests;
      if (allInterestsList.isNotEmpty) {
        log('getAllInterests(${usersRepo.runtimeType}) success UsersController: ${allInterestsList[0].interestName}');
      } else {
        log('getAllInterests(${usersRepo.runtimeType}) success Empty UsersController:');
      }
    }).catchError((error) {
      log("Error in getAllInterests UsersController: $error");
    });
  }
}

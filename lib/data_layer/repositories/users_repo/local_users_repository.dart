import 'dart:developer';

import 'package:notes/core/network/local/local_database_constants.dart';
import 'package:notes/data_layer/models/interest_model.dart';
import 'package:notes/data_layer/models/user_model.dart';
import 'package:notes/data_layer/repositories/users_repo/users_base_repository.dart';

import '../../../core/network/local/local_database_helper.dart';

class LocalUsersRepo extends UsersBaseRepository {

  @override
  Future<String> addNewUser(
      {required String userName,
      required String userPassword,
      required String userEmail,
      required String imageFile,
      required String interestId}) async {
    int rowNumber = await LocalDatabaseHelper.insertDataIntoDatabase('''
    ${LocalDatabaseConstants.insertDataIntoTableSql} user
    (username, password, email, intrestId, imageAsBase64)  
    VALUES
    ("$userName", "$userPassword", "$userEmail", "$imageFile", "$interestId")
    ''');

    return rowNumber.toString();
  }

  @override
  Future<List<InterestModel>> getAllInterests() async {
    List<Map<String, Object?>> interests =
        await LocalDatabaseHelper.getDataFromDatabase('${LocalDatabaseConstants.getAllDataFromTableSql} interest');
    if (interests.isNotEmpty) {
      //log('Local getAllInterests: ${interests.length}');
      return interests
          .map((allInterests) => InterestModel.fromJson(allInterests))
          .toList();
    } else {
      log('Local getAllInterests: ${interests.length}');
      return [];
    }
  }

  @override
  Future<List<UserModel>> getAllUsers() async {
    List<Map<String, Object?>> users =
        await LocalDatabaseHelper.getDataFromDatabase('${LocalDatabaseConstants.getAllDataFromTableSql} user');
    if (users.isNotEmpty) {
      //log('Local getAllUsers isNotEmpty: ${users}');
      return users.map((users) => UserModel.fromJson(users)).toList();
    } else {
      log('Local getAllUsers: ${users.length}');
      return [];
    }
  }

  Future<void> saveInterestsLocally(
      {required List<InterestModel> interests}) async {
    await LocalDatabaseHelper.deleteTableData('interest');
    for (var interest in interests) {
      await LocalDatabaseHelper.insertDataIntoDatabase('''
    ${LocalDatabaseConstants.insertDataIntoTableSql} interest
    (intrestText) 
    VALUES
    ("${interest.interestName}")
    ''');
    }
  }

  Future<void> saveUsersLocally({required List<UserModel> users}) async {
    await LocalDatabaseHelper.deleteTableData('user');
    for (var user in users) {
      await LocalDatabaseHelper.insertDataIntoDatabase('''
    ${LocalDatabaseConstants.insertDataIntoTableSql} user
    (username, password, email, intrestId, imageAsBase64) 
    VALUES
    ("${user.userName}", "${user.userPassword}", "${user.userEmail}", "${user.userInterestId}", "${user.userImage}")
    ''');
    }
  }
}

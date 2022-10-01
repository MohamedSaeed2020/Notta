import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:notes/core/network/remote/api_end_points.dart';
import 'package:notes/core/network/remote/dio_helper.dart';

class UsersWebService {
  Future<List<dynamic>> getAllUsers() async {
    try {
      Response response = await DioHelper.getData(
        url: ApiEndPoints.allUsersEndPoint,
      );
     // log('getAllUsers web success ${response.data.toString()}');
      return response.data;
    } on DioError catch (error) {
      log('getAllUsers web error ${error.toString()}');
      throw 'getAllUsers web error';
    }
  }

  Future<List<dynamic>> getAllInterests() async {
    try {
      Response response = await DioHelper.getData(
        url: ApiEndPoints.allUserInterestsEndPoint,
      );
      //log('getAllInterests web success ${response.data.toString()}');
      return response.data;
    } on DioError catch (error) {
      log('getAllInterests web error ${error.toString()}');
      throw 'getAllInterests web error';
    }
  }

  Future<dynamic> addNewUser({
    required String userName,
    required String userPassword,
    required String userEmail,
    required String imageFile,
    required String interestId,
  }) async {
    try {
      Response response = await DioHelper.postData(
        url: ApiEndPoints.addNewUserEndPoint,
        data: {
          "Username": userName,
          "Password": userPassword,
          "Email": userEmail,
          "ImageAsBase64":imageFile,
          "IntrestId": interestId
        },
      );
      //log('addNewUser web success ${response.data.toString()}');
      return response.data;
    } on DioError catch (error) {
      log('addNewUser web error ${error.response!.data}');
    }
  }
}

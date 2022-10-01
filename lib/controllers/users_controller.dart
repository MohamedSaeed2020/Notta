import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:notes/core/helpers/app_helpers.dart';
import 'package:notes/core/network/remote/api_constants.dart';
import 'package:notes/core/network/remote/api_end_points.dart';
import 'package:notes/core/services/users_services.dart';
import 'package:notes/data_layer/models/interest_model.dart';
import 'package:notes/data_layer/models/user_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class UsersController extends GetxController {


  final UsersServices usersServices = Get.find<UsersServices>();

  bool isLoading = false;
  UserModel? userModel;
  InterestModel? interestModel;
  File? profileImage;
  var picker = ImagePicker();
  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;


  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    update();
  }

  void selectUser(UserModel selectedUserModel) {
    userModel = selectedUserModel;
    update();
  }

  void selectInterest(InterestModel selectedInterestModel) {
    interestModel = selectedInterestModel;
    update();
  }

  void getProfileImage() async {
    try {
      final pickedFile = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 50,
      );

      if (pickedFile != null) {
        profileImage = File(pickedFile.path);
        log('Picking Image Successfully: $profileImage');
        update();
      } else {
        log('Error In Picking The Image');
      }
    } catch (error) {
      log('Exception In Picking The Image: $error');
    }
  }

  void addUser({
    required String userName,
    required String userPassword,
    required String userEmail,
    required File imageFile,
    required String interestId,
  }) async {
    isLoading = true;
    update();
    usersServices.usersRepo
        .addNewUser(
            userName: userName,
            userPassword: userPassword,
            userEmail: userEmail,
            imageFile: convert.base64Encode(imageFile.readAsBytesSync()),
            interestId: interestId)
        .then((allInterests) {
      isLoading = false;
      update();
      usersServices.getAllUsers();
      AppHelpers.showSnackBar('User Added Successfully', 'success');
      log('addUser success UsersController: $allInterests');
    }).catchError((error) {
      isLoading = false;
      update();
      AppHelpers.showSnackBar("Error When Register This User", 'error');
      log("Error in addUser UsersController: $error");
    });
  }

  //NOT_USED
  void addNewUser({
    required String userName,
    required String userPassword,
    required String userEmail,
    required File imageFile,
    required String interestId,
  }) async {
    isLoading = true;
    update();
    var stream = File(imageFile.path).readAsBytes().asStream();
    var length = await imageFile.length();
    String fileName = imageFile.path.split('/').last;
    http.MultipartFile multipartFile = http.MultipartFile(
      'ImageAsBase64',
      stream,
      length,
      filename: fileName,
    );
    var uri =
        Uri.parse('${ApiConstants.baseUrl}${ApiEndPoints.addNewUserEndPoint}');
    var request = http.MultipartRequest("POST", uri);
    request.fields['Username'] = userName.toString();
    request.fields["Password"] = userPassword.toString();
    request.fields["Email"] = userEmail.toString();
    request.files.add(multipartFile);
    request.fields['IntrestId'] = interestId.toString();
    request.headers.addAll({
      'content-type': 'multipart/form-data',
    });
    var response = await request.send();

    // listen for response
    await response.stream.transform(convert.utf8.decoder).listen((value) {
      if (response.statusCode == 200 || response.statusCode == 201) {
        log('Register Success');
        AppHelpers.showSnackBar('User Added Successfully', 'success');
        isLoading = false;

        update();
      } else {
        log('Register Error $value');
        isLoading = false;
        update();
        AppHelpers.showSnackBar("Error When Register This User", 'error');
      }
    }).asFuture();
  }
}

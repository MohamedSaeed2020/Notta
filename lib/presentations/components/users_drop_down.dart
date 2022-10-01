import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes/controllers/users_controller.dart';
import 'package:notes/core/utils/app_colors.dart';
import 'package:notes/data_layer/models/user_model.dart';

class UsersDropDown extends StatelessWidget {
  const UsersDropDown({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UsersController>(builder: (controller) {
      return DropdownButtonFormField<UserModel>(
        hint: Text(controller.usersServices.allUsersList.isNotEmpty?controller.usersServices.allUsersList.first.userName.toString():''),
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.all(18),
          labelText: 'Assign To User',
          border: OutlineInputBorder(),
        ),
        dropdownColor: AppColors.whiteColor,
        isExpanded: true,
        icon: const Icon(
          Icons.arrow_drop_down_outlined,
        ),
        onChanged: (UserModel? userModel) {
          log('userModel: ${userModel?.userName}');
          controller.selectUser(userModel!);
        },
        value: controller.userModel,
        items: controller.usersServices.allUsersList
            .map<DropdownMenuItem<UserModel>>((UserModel user) {
          return DropdownMenuItem<UserModel>(
            value: user,
            child: Text(
              user.userName.toString(),
            ),
          );
        }).toList(),
      );
    });
  }
}

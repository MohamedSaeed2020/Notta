import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes/controllers/users_controller.dart';
import 'package:notes/core/utils/app_colors.dart';
import 'package:notes/data_layer/models/interest_model.dart';

class InterestsDropDown extends StatelessWidget {
  const InterestsDropDown({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UsersController>(builder: (controller) {
      return DropdownButtonFormField<InterestModel>(
        hint: Text(controller.usersServices.allInterestsList.isNotEmpty
            ? controller.usersServices.allInterestsList.first.interestName
                .toString()
            : ''),
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.all(18),
          labelText: 'Interest',
          border: OutlineInputBorder(),
        ),
        dropdownColor: AppColors.whiteColor,
        isExpanded: true,
        icon: const Icon(
          Icons.arrow_drop_down_outlined,
        ),
        onChanged: (InterestModel? interestModel) {
          log('interestName: ${interestModel?.interestName}');
          controller.selectInterest(interestModel!);
        },
        value: controller.interestModel,
        items: controller.usersServices.allInterestsList
            .map<DropdownMenuItem<InterestModel>>((InterestModel interest) {
          return DropdownMenuItem<InterestModel>(
              value: interest, child: Text(interest.interestName.toString()));
        }).toList(),
      );
    });
  }
}

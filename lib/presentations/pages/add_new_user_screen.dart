import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:notes/controllers/users_controller.dart';
import 'package:notes/core/helpers/app_helpers.dart';
import 'package:notes/core/helpers/extensions.dart';
import 'package:notes/core/shared/widgets/custom_button.dart';
import 'package:notes/core/shared/widgets/custom_labeled_form_field.dart';
import 'package:notes/core/utils/app_colors.dart';
import 'package:notes/presentations/components/interests_drop_down.dart';

class AddNewUserScreen extends StatefulWidget {
  const AddNewUserScreen({Key? key}) : super(key: key);

  @override
  State<AddNewUserScreen> createState() => _AddNewUserScreenState();
}

class _AddNewUserScreenState extends State<AddNewUserScreen> {
  final TextEditingController userNameEditingController =
      TextEditingController();
  final TextEditingController userPasswordEditingController =
      TextEditingController();
  final TextEditingController userEmailEditingController =
      TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        title: const Text(
          'Add User',
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                GetBuilder<UsersController>(builder: (controller) {
                  return Column(
                    children: [
                      CircleAvatar(
                        radius: MediaQuery.of(context).size.width * 0.15,
                        backgroundColor: AppColors.primaryColor,
                        backgroundImage: controller.profileImage == null
                            ? null
                            : FileImage(controller.profileImage!),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      InkWell(
                        highlightColor: Colors.transparent,
                        overlayColor: MaterialStateProperty.all<Color>(
                            Colors.transparent),
                        onTap: () {
                          controller.getProfileImage();
                        },
                        child: const Text(
                          'Select Image',
                          style: TextStyle(
                            color: AppColors.blackColor,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ],
                  );
                }),
                const SizedBox(
                  height: 20,
                ),
                CustomLabeledFormField(
                  textInputType: TextInputType.name,
                  controller: userNameEditingController,
                  labelText: 'User Name',
                  validate: (String? value) {
                    if (value!.isEmpty) {
                      return 'Please Enter Your Name';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                GetBuilder<UsersController>(builder: (controller) {
                  return CustomLabeledFormField(
                    suffix: controller.suffix,
                    suffixPressed: () {
                      controller.changePasswordVisibility();
                    },
                    isPassword: controller.isPassword,
                    textInputType: TextInputType.visiblePassword,
                    controller: userPasswordEditingController,
                    labelText: 'Password',
                    validate: (String? value) {
                      if (value!.isEmpty) {
                        return 'Please Enter Your Password';
                      } else if (!userPasswordEditingController.text
                          .isValidPassword()) {
                        return 'Password should have at least one upper case, '
                            'one lower case, one digit, '
                            ' one special character and must be at least 8 characters in length';
                      }
                      return null;
                    },
                  );
                }),
                const SizedBox(
                  height: 20,
                ),
                CustomLabeledFormField(
                  textInputType: TextInputType.emailAddress,
                  controller: userEmailEditingController,
                  labelText: 'Email',
                  validate: (String? value) {
                    if (value!.isEmpty) {
                      return 'Please Enter Your Email';
                    } else if (!userEmailEditingController.text
                        .isValidEmail()) {
                      return 'Incorrect Email';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                const InterestsDropDown(),
                const SizedBox(
                  height: 20,
                ),
                GetBuilder<UsersController>(builder: (controller) {
                  return controller.isLoading
                      ? const Center(
                          child: SpinKitFadingCircle(
                            color: AppColors.primaryColor,
                            size: 50.0,
                          ),
                        )
                      : CustomButton(
                          onTap: () {
                            if (formKey.currentState!.validate()) {
                              if (controller.interestModel == null) {
                                AppHelpers.showSnackBar(
                                    'Please choose an interest', 'error');
                              } else if (controller.profileImage == null) {
                                AppHelpers.showSnackBar(
                                    'Please choose an image', 'error');
                              } else {
                                controller.addUser(
                                  userName: userNameEditingController.text,
                                  userPassword:
                                      userPasswordEditingController.text,
                                  userEmail: userEmailEditingController.text,
                                  imageFile: controller.profileImage!,
                                  interestId:
                                      controller.interestModel!.interestId,
                                );
                              }
                            }
                          },
                          title: 'SAVE',
                        );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    userNameEditingController.dispose();
    userPasswordEditingController.dispose();
    userEmailEditingController.dispose();
    super.dispose();
  }
}

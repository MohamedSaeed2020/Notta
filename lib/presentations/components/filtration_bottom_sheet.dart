import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes/controllers/notes_controller.dart';
import 'package:notes/controllers/users_controller.dart';
import 'package:notes/core/shared/widgets/custom_button.dart';
import 'package:notes/core/utils/app_colors.dart';
import 'package:notes/presentations/components/users_drop_down.dart';

class FiltrationBottomSheet extends StatefulWidget {
  const FiltrationBottomSheet({Key? key}) : super(key: key);

  @override
  State<FiltrationBottomSheet> createState() => _FiltrationBottomSheetState();
}

class _FiltrationBottomSheetState extends State<FiltrationBottomSheet> {
  late UsersController usersController;

  @override
  void initState() {
    usersController = Get.find<UsersController>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(30),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: AppColors.lightGreyColor,
        border: Border.all(color: AppColors.primaryColor, width: 1),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      child: GetBuilder<NotesController>(
        builder: (controller) {
          return Column(
            children: [
              const SizedBox(
                height: 5,
              ),
              const UsersDropDown(),
              const SizedBox(
                height: 20,
              ),
              CustomButton(
                onTap: () {
                  controller
                      .filterNotesByUser(usersController.userModel!.userId);
                },
                title: 'FILTER',
              ),
              const SizedBox(
                height: 20,
              ),
              CustomButton(
                onTap: () {
                  controller
                      .getAllNotes();
                },
                title: 'RESET',
              ),
            ],
          );
        },
      ),
    );
  }
}

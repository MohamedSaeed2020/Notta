import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:notes/controllers/notes_controller.dart';
import 'package:notes/controllers/users_controller.dart';
import 'package:notes/core/helpers/app_helpers.dart';
import 'package:notes/core/shared/widgets/custom_button.dart';
import 'package:notes/core/shared/widgets/custom_labeled_form_field.dart';
import 'package:notes/core/utils/app_colors.dart';
import 'package:notes/presentations/components/users_drop_down.dart';

class AddingNewNoteScreen extends StatefulWidget {
  const AddingNewNoteScreen({Key? key}) : super(key: key);

  @override
  State<AddingNewNoteScreen> createState() => _AddingNewNoteScreenState();
}

class _AddingNewNoteScreenState extends State<AddingNewNoteScreen> {
  final TextEditingController noteTextEditingController =
      TextEditingController();
  late UsersController usersController;
  late NotesController notesController;

  @override
  void initState() {
    usersController = Get.find<UsersController>();
    notesController = Get.find<NotesController>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        title: const Text('Add Note'),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            CustomLabeledFormField(
              textInputType: TextInputType.multiline,
              controller: noteTextEditingController,
              labelText: 'Note',
              maxLines: 5,
            ),
            const SizedBox(
              height: 20,
            ),
            const UsersDropDown(),
            const SizedBox(
              height: 20,
            ),
            GetBuilder<NotesController>(
              builder: (controller) {
                return controller.isLoading
                    ? const Center(
                        child: SpinKitFadingCircle(
                          color: AppColors.primaryColor,
                          size: 50.0,
                        ),
                      )
                    : CustomButton(
                        onTap: () {
                          if (usersController.userModel == null) {
                            AppHelpers.showSnackBar(
                                'Please Assign a User To This Note', 'error');
                          } else {
                            if (noteTextEditingController.text.isEmpty) {
                              AppHelpers.showSnackBar(
                                  'Note Text is empty', 'error');
                            } else {
                              notesController.addNewNote(
                                userId: usersController.userModel!.userId,
                                noteText: noteTextEditingController.text,
                              );
                            }
                          }
                        },
                        title: 'SAVE',
                      );
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    noteTextEditingController.dispose();
    super.dispose();
  }
}

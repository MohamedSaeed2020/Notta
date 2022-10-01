import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes/controllers/notes_controller.dart';
import 'package:notes/controllers/users_controller.dart';
import 'package:notes/core/helpers/app_helpers.dart';
import 'package:notes/core/shared/widgets/custom_labeled_form_field.dart';
import 'package:notes/presentations/components/users_drop_down.dart';
import 'package:notes/core/utils/app_colors.dart';
import 'package:notes/data_layer/models/note_model.dart';

class NoteDetailsScreen extends StatefulWidget {
  const NoteDetailsScreen({Key? key}) : super(key: key);

  @override
  State<NoteDetailsScreen> createState() => _NoteDetailsScreenState();
}

class _NoteDetailsScreenState extends State<NoteDetailsScreen> {
  final TextEditingController noteTextEditingController =
      TextEditingController();
  late UsersController usersController;
  late NotesController notesController;
  late NoteModel note;


  @override
  void initState() {
    usersController = Get.find<UsersController>();
    notesController = Get.find<NotesController>();
    note = Get.arguments[0];
    noteTextEditingController.text = note.noteText;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        title: const Text('Edit Note'),
        actions: [
          IconButton(
            onPressed: () {
              if (usersController.userModel == null) {
                AppHelpers.showSnackBar(
                    'Please Assign a User To This Note', 'error');
              } else {
                if (noteTextEditingController.text.isEmpty) {
                  AppHelpers.showSnackBar('Note Text is empty', 'error');
                } else {
                  notesController.updateNote(
                    noteId: note.noteId,
                    userId: usersController.userModel!.userId,
                    noteText: noteTextEditingController.text,
                  );
                }
              }
            },
            icon: const Icon(
              Icons.save_outlined,
              color: AppColors.whiteColor,
            ),
          ),
        ],
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

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes/core/routes/app_router.dart';
import 'package:notes/core/utils/app_colors.dart';
import 'package:notes/data_layer/models/note_model.dart';

class NoteItem extends StatelessWidget {
  final NoteModel note;

  const NoteItem({Key? key, required this.note}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            note.noteText,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        IconButton(
          onPressed: () {
            Get.toNamed(AppRoutes.noteDetailsScreen, arguments: [note]);
          },
          icon: const Icon(
            Icons.edit,
            color: AppColors.greyColor,
          ),
        ),
      ],
    );
  }
}

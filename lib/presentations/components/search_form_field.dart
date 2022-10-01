import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes/controllers/notes_controller.dart';

class SearchFormField extends StatefulWidget {
  const SearchFormField({Key? key}) : super(key: key);

  @override
  State<SearchFormField> createState() => _SearchFormFieldState();
}

class _SearchFormFieldState extends State<SearchFormField> {
  final searchTextEditingController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<NotesController>(builder: (controller) {
      return TextField(
        controller: searchTextEditingController,
        onChanged: (String? searchKeyword) {
          controller.searchNotes(searchKeyword!);
        },

        decoration:  InputDecoration(
          contentPadding: const EdgeInsets.all(10),
          hintText: "Search Notes",
          suffixIcon: InkWell(
            onTap: (){
              searchTextEditingController.clear();
              controller.getAllNotes();
            },
            child: const Icon(Icons.clear),
          ),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(7.0),
            ),
          ),
        ),
      );
    });
  }
  @override
  void dispose() {
    searchTextEditingController.dispose();
    super.dispose();
  }
}

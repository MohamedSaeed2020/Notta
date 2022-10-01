import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:notes/controllers/notes_controller.dart';
import 'package:notes/core/helpers/assets_paths.dart';
import 'package:notes/core/routes/app_router.dart';
import 'package:notes/core/utils/app_colors.dart';
import 'package:notes/presentations/components/filtration_bottom_sheet.dart';
import 'package:notes/presentations/components/note_item.dart';
import 'package:notes/presentations/components/note_item_skeleton.dart';
import 'package:notes/presentations/components/notes_shimmer.dart';
import 'package:notes/presentations/components/search_form_field.dart';
import 'package:notes/presentations/components/shimmer_widget.dart';

class NotesScreen extends StatelessWidget {
  const NotesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final NotesController noteController = Get.find<NotesController>();
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        title: const Text(
          'Notes',
        ),
        actions: [
          IconButton(
            onPressed: () {
              Get.toNamed(AppRoutes.addNewUserScreen);
            },
            icon: const Icon(Icons.person_add),
          ),
          IconButton(
            onPressed: noteController.navigateToSetting,
            icon: const Icon(Icons.settings),
          ),
          IconButton(
            onPressed: () {
              noteController.deleteAllNotes();
            },
            icon: const Icon(Icons.clear_all),
          ),
          IconButton(
            onPressed: () {
              noteController.getAllNotes();
            },
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(20.0),
        child: GetBuilder<NotesController>(builder: (controller) {
          return Center(
            child: Column(
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        showModalBottomSheet(
                          enableDrag: false,
                          isDismissible: true,
                          backgroundColor: Colors.transparent,
                          barrierColor: Colors.transparent,
                          context: context,
                          isScrollControlled: true,
                          builder: (context) => SingleChildScrollView(
                            child: Container(
                              padding: EdgeInsets.only(
                                  bottom:
                                      MediaQuery.of(context).viewInsets.bottom),
                              child: const FiltrationBottomSheet(),
                            ),
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.filter_list,
                        color: AppColors.iconsColor,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        controller.changeSearchFieldVisibility();
                      },
                      icon: const Icon(
                        Icons.search,
                        color: AppColors.iconsColor,
                      ),
                    ),
                    Expanded(
                      child: Visibility(
                        visible: controller.isSearchFieldVisible,
                        child: const SearchFormField(),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: controller.isLoading
                      ?
                  /*const Center(
                          child: SpinKitFadingCircle(
                            color: AppColors.primaryColor,
                            size: 50.0,
                          ),
                        )*/
                  ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return const NoteItemSkeleton();
                    },
                    separatorBuilder:
                        (BuildContext context, int index) {
                      return const SizedBox(height: 16,);
                    },
                  )
                      : controller.allNotesList.isNotEmpty
                          ? ListView.separated(
                              physics: const BouncingScrollPhysics(),
                              itemCount: controller.allNotesList.length,
                              itemBuilder: (context, index) {
                                return NoteItem(
                                  note: controller.allNotesList[index],
                                );
                              },
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return const Divider();
                              },
                            )
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  AssetsManager.noNote,
                                  width: MediaQuery.of(context).size.width * 0.25,
                                  height:
                                      MediaQuery.of(context).size.width * 0.25,
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                const Text(
                                  "You Don't have any notes",
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                              ],
                            ),
                ),
              ],
            ),
          );
        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(AppRoutes.newNoteScreen);
        },
        child: const Icon(
          Icons.add,
          color: AppColors.whiteColor,
        ),
      ),
    );
  }
}

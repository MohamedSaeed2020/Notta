import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:notes/core/utils/app_colors.dart';
class AppHelpers {
  static void makeAppInPortraitModeOnly() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  static showSnackBar(String message, String status) {
    Get.snackbar(
      status == "error" ? 'Problem' : 'Alarm',
      message,
      //icon: Icon(Icons.person, color: Colors.white),
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor:
      status == "error" ? AppColors.lightRed : AppColors.lightGreen,
      borderRadius: 5,
      margin: const EdgeInsets.all(10),
      colorText: AppColors.whiteColor,
      duration: const Duration(seconds: 4),
      isDismissible: true,
      dismissDirection: DismissDirection.horizontal,
      forwardAnimationCurve: Curves.easeOutBack,
    );
  }

  static String getCurrentDate() {
    var now = DateTime.now();
    var formatter = DateFormat('yyyy-MM-dd');
    String nowFormattedDate = formatter.format(now);
    return nowFormattedDate;
  }

}

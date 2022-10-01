
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes/controllers/bindings.dart';
import 'package:notes/core/helpers/app_helpers.dart';
import 'package:notes/core/network/local/cache_helper.dart';
import 'package:notes/core/network/remote/dio_helper.dart';
import 'package:notes/core/routes/app_router.dart';
import 'package:notes/core/services/users_services.dart';
import 'package:notes/core/utils/palette.dart';
import 'package:notes/presentations/pages/all_notes_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AppHelpers.makeAppInPortraitModeOnly();
  DioHelper.init();
  await CacheHelper.init();
  Get.lazyPut(() => UsersServices());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Palette.primaryColor,
      ),
      initialBinding: Binding(),
      getPages: AppRoutes.routes,
      home:  const NotesScreen(),
    );
  }
}



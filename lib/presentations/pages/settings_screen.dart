
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes/controllers/settings_controller.dart';
import 'package:notes/core/network/local/cache_helper.dart';
import 'package:notes/core/network/local/storage_keys.dart';
import 'package:notes/core/utils/app_colors.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        title: const Text(
          'Options',
        ),
      ),
      body: Container(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
        height: MediaQuery.of(context).size.height * 0.15,
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Use Local Database',
                    style: TextStyle(
                      fontSize: 20,
                      color: AppColors.blackColor,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    'instead of using http calls to work with the app data, Please use SQLite for this',
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.greyColor,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            GetBuilder<SettingsController>(builder: (controller){
              return  Switch(
                inactiveThumbColor: AppColors.lightRed,
                value:CacheHelper.getData(key: StorageKeys.localStorageActivated)??false,
                onChanged: controller.isLocalDatabaseActivated
              );
            }),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homemedica_patient/controllers/theme_controller.dart';

ThemeController themeController = Get.put(ThemeController());
AppBar buildProfileAppBar(BuildContext context) {
  return AppBar(
    iconTheme: IconThemeData(
        color: themeController.isDarkModeEnabled.value?Colors.grey[100]:Colors.grey[900]
    ), // set backbutton color here which will reflect in all screens.
    leading: BackButton(),
    backgroundColor: Colors.transparent,
    elevation: 0,
  );
}
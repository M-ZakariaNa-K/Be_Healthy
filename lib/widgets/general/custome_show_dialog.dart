import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tracking_system_app/style/app_var.dart';

void showCustomeLogOutDialog(BuildContext context) {
  Get.defaultDialog(
    title: "Warning",
    middleText: "Are you sure about logging out?",
    backgroundColor: Colors.white,
    titleStyle: TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: AppVar.mainFontSize,
    ),
    middleTextStyle: TextStyle(
      color: Colors.black,
      fontSize: AppVar.littelFontSize,
    ),
    textConfirm: "Logout",
    textCancel: "Cancel",
    cancelTextColor: Colors.black,
    confirmTextColor: Colors.white,
    buttonColor: AppVar.primary,
    onConfirm: () async {
      // Get.back(); // Close the dialog
      // showDialog(
      //   context: context,
      //   barrierDismissible: false,
      //   builder: (BuildContext context) {
      //     return const Center(child: MainLoadingWidget());
      //   },
      // );
      // // ===============START function to logout==========================
      // await DioHelper.get(url: "$baseUrl/auth/logout");
      // GetStorage().remove('token');
      // GetStorage().remove('role');
      // // Hide loading indicator dialog
      // Get.back();
      // token = '';
      // role = '';
      // userEmail = '';
      // isUser = null;
      // isHallOwner = null;

      // Get.offAll(const LoginPage());
      // // ===============END function to logout==========================
      // print("User wants to log out");
      // print(token);
    },
    onCancel: () {
      print("User canceled the login");
    },
  );
}

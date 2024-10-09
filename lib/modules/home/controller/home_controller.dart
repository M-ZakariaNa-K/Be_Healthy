import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tracking_system_app/model/my_info_model.dart';
import 'package:tracking_system_app/network_util.dart';
import 'package:tracking_system_app/widgets/home/custome_message_dialog.dart';
import 'package:tracking_system_app/widgets/home/custome_sign_out_dialog.dart';
import 'package:tracking_system_app/widgets/toast/custom_toast.dart';

class HomeController extends GetxController {
  RxInt selectedCardIndex = (-1).obs;
  final TextEditingController issueDialogController = TextEditingController();
  RxBool isTextFildFilled = false.obs;
  RxBool isLoading = false.obs;
  RxBool showLottieAnimation = false.obs;
  Rx<MyInfoDataModel> myInfoModel = MyInfoDataModel(
          id: 0, name: "", phone: "", employeeNumber: "", image: null, role: "")
      .obs;
  @override
  void onInit() {
    super.onInit();
    initialize();
  }

//===========================================My Info========================================
  Future<void> initialize() async {
    isLoading.value = true;
    try {
      print("zzz");
      var response = await $.get('users/my-info');
      print(response);

      if (response != null) {
        myInfoModel.value = MyInfoDataModel.fromJson(response["data"]);
      }
    } catch (e) {
      print("Error: $e");
      CustomToast.errorToast("Opps..", "Failed to load my info");
    } finally {
      isLoading.value = false;
    }
  }
//===========================================Messaging dialog================================================================

  Future<void> sendToAdmin() async {
    isLoading.value = true;
    // Simulate sending request to the admin
    //Here i will make a post request to the server
    try {
      // await $.flipIfDemo(email: emailC.text);
      final response = await $.post('users/send-message', body: {
        "type": "issue",
        "message": issueDialogController.text,
      });

      if (response != null) {
        // await Future.delayed(Duration(seconds: 3));
        // // Show Lottie animation for 3 seconds
        showLottieAnimation.value = true;
        issueDialogController.clear();
        isTextFildFilled.value = false;
        isLoading.value = false;
        await Future.delayed(const Duration(seconds: 3));
        Get.back(); // Close the dialog after Lottie finishes
      }

      //         showLottieAnimation.value = false;

      // isLoading.value = false;
    } catch (e) {
      CustomToast.errorToast("Error", "Error because : ${e.toString()}");
    } finally {
      showLottieAnimation.value = false;
      isLoading.value = false;
    }
  }

  void exitMessageDialog() {
    Get.back(); // Close the dialog
    isTextFildFilled.value = false;
    issueDialogController.clear();
  }

// Function to show the dialog
  void showCustomMessageDialog(
      BuildContext context, HomeController homeController) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        if (MediaQuery.of(context).orientation == Orientation.landscape) {
          return SingleChildScrollView(
              child: CustomMessageDialog(
            title: homeController.myInfoModel.value.name,
            subtitle: homeController.myInfoModel.value.employeeNumber ??
                homeController.myInfoModel.value.id.toString(),
          ));
        } else {
          return CustomMessageDialog(
            title: homeController.myInfoModel.value.name,
            subtitle: homeController.myInfoModel.value.employeeNumber ??
                homeController.myInfoModel.value.id.toString(),
          );
        }
      },
    );
  }
//===========================================Sign out dialog================================================================

  void exitSignOutDialog() {
    Get.back(); // Close the dialog
  }

// Function to show the dialog
  void showCustomSignOutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomSignOutDialog();
      },
    );
  }

  Future<void> logout() async {
    isLoading.value = true;
    try {
      await $.resetUser();

      isLoading.value = false;
    } catch (e) {
      CustomToast.errorToast("Error", "Error because : ${e.toString()}");
    } finally {
      isLoading.value = false;
    }
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tracking_system_app/network_util.dart';
import 'package:tracking_system_app/routes/app_pages.dart';
import 'package:tracking_system_app/widgets/home/custome_message_dialog.dart';
import 'package:tracking_system_app/widgets/home/custome_sign_out_dialog.dart';
import 'package:tracking_system_app/widgets/toast/custom_toast.dart';

class HomeController extends GetxController {
  RxInt selectedCardIndex = (-1).obs;
  final TextEditingController homeDialogController = TextEditingController();
  RxBool isTextFildFilled = false.obs;
  RxBool isLoading = false.obs;
  RxBool showLottieAnimation = false.obs;

//===========================================Messaging dialog================================================================

  Future<void> sendToAdmin() async {
    isLoading.value = true;
    // Simulate sending request to the admin
    //Here i will make a post request to the server
    await Future.delayed(Duration(seconds: 3)); // Replace with actual request
    isLoading.value = false; // Stop loading
    isTextFildFilled.value = false;
    homeDialogController.clear();

    // Show Lottie animation for 3 seconds
    showLottieAnimation.value = true;
    await Future.delayed(Duration(seconds: 3));
    showLottieAnimation.value = false;

    Get.back(); // Close the dialog after Lottie finishes
  }

  void exitMessageDialog() {
    Get.back(); // Close the dialog
    isTextFildFilled.value = false;
    homeDialogController.clear();
  }

// Function to show the dialog
  void showCustomMessageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        if (MediaQuery.of(context).orientation == Orientation.landscape) {
          return SingleChildScrollView(
              child: CustomMessageDialog(
            title: 'Ahmad Deeb',
            subtitle: '002024',
          ));
        } else {
          return CustomMessageDialog(
            title: 'Ahmad Deeb',
            subtitle: '002024',
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

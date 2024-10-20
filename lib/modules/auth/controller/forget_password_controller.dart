import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tracking_system_app/network_util.dart';
import 'package:tracking_system_app/routes/app_pages.dart';
import 'package:tracking_system_app/widgets/general/main_loading_widget.dart';
import 'package:tracking_system_app/widgets/toast/custom_toast.dart';

class ForgetPasswordController extends GetxController {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final formKey = GlobalKey<FormState>();
  RxBool isWaitAdminApproved = false.obs;
  var statusCode = 0.obs;
  var isLoading = false.obs;

  void validateForm() {
    if (fullNameController.text.isEmpty) {
      Get.closeAllSnackbars();
      CustomToast.errorToast('Error', 'Please enter your Full Name');
      return;
    }

    if (phoneNumberController.text.isEmpty) {
      Get.closeAllSnackbars();
      CustomToast.errorToast('Error', 'Please enter your Employee ID');

      return;
    }

    // Validate phone number pattern
    final RegExp uaePhoneRegex =
        // 'regex:/^(?:5)\d{8}$/'
        // RegExp(r'^(?:50|51|52|55|56|58|2|3|4|6|7|9)\d{7}$');
        RegExp(r'^(?:5)\d{8}$');
    if (!uaePhoneRegex.hasMatch(phoneNumberController.text)) {
      Get.closeAllSnackbars();
      CustomToast.errorToast(
          'Error', 'Please enter a valid Emirates phone number');

      return;
    }

    if (passwordController.text.isEmpty) {
      Get.closeAllSnackbars();
      CustomToast.errorToast('Error', 'Please enter your password');

      return;
    } else if (passwordController.text.length < 6) {
      Get.closeAllSnackbars();
      CustomToast.errorToast('Error', 'Password must be at least 6 characters');

      return;
    }

    if (confirmPasswordController.text.isEmpty) {
      Get.closeAllSnackbars();
      CustomToast.errorToast('Error', 'Please confirm your password');

      return;
    } else if (confirmPasswordController.text != passwordController.text) {
      Get.closeAllSnackbars();
      CustomToast.errorToast('Error', 'Confirmed password does not match');

      return;
    }

    // If all validations pass, proceed
    // Show the loading dialog

    showLoadingDialog();
    sendInfoToAdmin();
  }

  void showLoadingDialog() {
    Get.dialog(
      const Center(
        child: MainLoadingWidget(),
      ),
      barrierDismissible: false, // Prevent dismissing by tapping outside
    );
  }

  Future<void> sendInfoToAdmin() async {
    isLoading.value = true;
    try {
      // await $.flipIfDemo(email: emailC.text);
      final response = await $.post('/users/reset-password', body: {
        "phone": phoneNumberController.text,
        "password": passwordController.text,
        "confirm_password": confirmPasswordController.text,
      });
      // // Close the loading dialog
      // Get.back();

//if success :

      if (response != null) {
        isWaitAdminApproved.value = true;
        Future.delayed(const Duration(seconds: 3), () {
          isWaitAdminApproved.value = false;
          Get.offAllNamed(Routes.LOGIN);
        });
      }

      isLoading.value = false;
    } catch (e) {
      // Close the dialog if an error occurs
      // if (Get.isDialogOpen!) {
      //   Get.back(); // Close any open dialog before opening a new one
      // }
      CustomToast.errorToast("Error", "Error because : ${e.toString()}");
    } finally {
      isLoading.value = false;
    }
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tracking_system_app/network_util.dart';
import 'package:tracking_system_app/routes/app_pages.dart';
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
        RegExp(r'^(?:50|51|52|55|56|58|2|3|4|6|7|9)\d{7}$');
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
    sendInfoToAdmin();
  }

  Future<void> sendInfoToAdmin() async {
    try {
      // await $.flipIfDemo(email: emailC.text);
      final response = await $.post('/users/reset-password', body: {
        "phone": phoneNumberController.text,
        "password": passwordController.text,
        "confirm_password": confirmPasswordController.text,
      });
//if success :

      if (response != null) {
        isWaitAdminApproved.value = true;
        Future.delayed(const Duration(seconds: 5), () {
          isWaitAdminApproved.value = false;
          Get.offAllNamed(Routes.LOGIN);
        });

        // User().fromJson(response['user']);
        // await User().loadInitialPortal();
        // goHome();
      }

      isLoading.value = false;
    } catch (e) {
      CustomToast.errorToast("Error", "Error because : ${e.toString()}");
    }
  }
}

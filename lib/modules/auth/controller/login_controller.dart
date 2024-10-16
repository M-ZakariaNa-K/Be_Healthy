import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tracking_system_app/alert.dart';
import 'package:tracking_system_app/network_util.dart';
import 'package:tracking_system_app/routes/app_pages.dart';
import 'package:tracking_system_app/widgets/general/main_loading_widget.dart';
import 'package:tracking_system_app/widgets/toast/custom_toast.dart';

class LoginController extends GetxController {
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  RxBool isLoading = false.obs;

  void validateForm() {
    if (phoneNumberController.text.isEmpty) {
      Get.closeAllSnackbars();
      CustomToast.errorToast('Error', 'Please enter your phone number');
      return;
    }

    // Validate phone number pattern
    final RegExp uaePhoneRegex =
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
    // If all validations pass, proceed
    login();
  }

  Future<void> login() async {
    if (Get.isDialogOpen!) {
      Get.back(); // Close any open dialog before opening a new one
    }

    // Show loading dialog with a circular progress indicator
    Get.dialog(
      const Center(
        child: MainLoadingWidget(),
      ),
      barrierDismissible:
          false, // Prevent dismissing the dialog by tapping outside
    );

    isLoading.value = true;
    try {
      final response = await $.post('/users/login', body: {
        'phone': phoneNumberController.text,
        'password': passwordController.text,
      });
      // Get.back();
      if (response != null) {
        await $.setConnectionParams(
          token: response['data']['token'],
          userRole: response['data']['role'],
        );

        // Navigate to Home page on successful login
        Get.offAllNamed(Routes.HOME);
        Alert.toast('Logged in successfully');
      }

      isLoading.value = false;
      // Get.back(); // Close the loading dialog after success
    } catch (e) {
      CustomToast.errorToast("Error", "Error because : ${e.toString()}");
    } finally {}
  }

  @override
  void dispose() {
    phoneNumberController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}

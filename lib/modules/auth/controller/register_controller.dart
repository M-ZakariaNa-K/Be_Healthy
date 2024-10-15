import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tracking_system_app/controller/radio_controller.dart';
import 'package:tracking_system_app/network_util.dart';
import 'package:tracking_system_app/routes/app_pages.dart';
import 'package:tracking_system_app/widgets/toast/custom_toast.dart';

class RegisterController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final TextEditingController fullNameController = TextEditingController();
  // final TextEditingController employeeNumberController =
  //     TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final RadioController jopTitleController =
      Get.put(RadioController(), tag: 'JopTitle');
  final List<String> radioData = ['Worker', 'Driver'];
  // final TextEditingController jopTitleController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  RxBool isWaitAdminApproved = false.obs;
  // late AnimationController lottieController;
  var isLoading = false.obs; // Add loading state
  Future<void> sendInfoToAdmin() async {
    isWaitAdminApproved.value = true;
    try {
      // await $.flipIfDemo(email: emailC.text);
      final response = await $.post('/users/register', body: {
        "name": fullNameController.text,
        "phone": phoneNumberController.text,
        // "employee_number": employeeNumberController.text,
        "role":
            jopTitleController.selectedValue.value == 0 ? "worker" : "driver",
        "password": passwordController.text,
        "confirm_password": confirmPasswordController.text,
      });

      if (response != null) {
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

  void validateForm() {
    if (fullNameController.text.isEmpty) {
      Get.closeAllSnackbars();
      CustomToast.errorToast('Error', 'Please enter your Full Name');
      return;
    }

    if (jopTitleController.selectedValue.value == null) {
      CustomToast.errorToast('Error', 'Please choose a job title');
      return;
    }
    // if (employeeNumberController.text.isEmpty) {
    //   Get.closeAllSnackbars();
    //   CustomToast.errorToast('Error', 'Please enter your employee number');
    //   return;
    // }

    if (phoneNumberController.text.isEmpty) {
      Get.closeAllSnackbars();
      CustomToast.errorToast('Error', 'Please enter your phone number');

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

  @override
  void onClose() {
    // lottieController.dispose(); // Clean up the controller when done
    super.onClose();
  }

  @override
  void dispose() {
    fullNameController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    phoneNumberController.dispose();
    // employeeNumberController.dispose();
    jopTitleController.dispose();
    super.dispose();
  }
}

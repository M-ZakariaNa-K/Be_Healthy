import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tracking_system_app/routes/app_pages.dart';

class LoginController extends GetxController {
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  void validateForm() {
    if (phoneNumberController.text.isEmpty) {
      Get.closeAllSnackbars();
      Get.snackbar(
        'Error',
        'Please enter your phone number',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    // Validate phone number pattern
    final RegExp uaePhoneRegex =
        RegExp(r'^(?:50|51|52|55|56|58|2|3|4|6|7|9)\d{7}$');
    if (!uaePhoneRegex.hasMatch(phoneNumberController.text)) {
      Get.closeAllSnackbars();
      Get.snackbar(
        'Error',
        'Please enter a valid Emirates phone number',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    if (passwordController.text.isEmpty) {
      Get.closeAllSnackbars();
      Get.snackbar(
        'Error',
        'Please enter your password',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    } else if (passwordController.text.length < 6) {
      Get.closeAllSnackbars();
      Get.snackbar(
        'Error',
        'Password must be at least 6 characters',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }
    // If all validations pass, proceed
    login();
  }

  void login() {
    Get.offAllNamed(Routes.HOME);
  }
  // LoginDataModel? userModel;

  // Future<void> loginState(
  //     {required String userName, required String password}) async {
  //   try {
  //     final response = await DioHelper.postDataWithAuth(
  //       url: '$baseUrl/auth/login',
  //       //zak
  //       data: {
  //         'login': userName,
  //         'password': password,
  //         "client_token": "ahmaddeeb"
  //       },
  //     );
  //     print("Response data: $response");
  //     if (response != null) {
  //       userModel = LoginDataModel.fromJson(response["data"]);
  //       if (userModel != null && userModel! != null) {
  //         print("zzzzzz $userModel");
  //         token = userModel!.token!;
  //         role = userModel!.role!;
  //         isUser = userModel!.role == "User";
  //         isHallOwner = userModel!.role == "HallOwner";
  //         box.write('token', token);
  //         roleBox.write('role', role);
  //         print("Token: $token, Role: $role");

  //         showToast(
  //             msg: "Logged In Successfully", backgroundColor: Colors.green);
  //         print("Navigating to DrawerPage");
  //         Get.offAll(() => const DrawerPage());
  //       } else {
  //         print("Login failed: User model or data is null");
  //       }
  //     }
  //   } catch (error) {
  //     print("Login error: $error");
  //     showToast(msg: "Login Failed", backgroundColor: Colors.red);
  //   }
  // }

  @override
  void dispose() {
    phoneNumberController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}

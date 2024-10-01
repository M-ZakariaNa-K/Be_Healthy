import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:tracking_system_app/routes/app_pages.dart';

class ForgetPasswordController extends GetxController {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController jobNumberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final formKey = GlobalKey<FormState>();
  RxBool isWaitAdminApproved = false.obs;
  var statusCode = 0.obs;
  var isLoading = false.obs;

  final _dio = Dio();

  Future<void> post({
    required String url,
    required dynamic body,
    required String theEmail,
  }) async {
    isLoading.value = true; // Start loading
    try {
      final headers = <String, dynamic>{
        'Accept': 'application/json',
      };

      final response =
          await _dio.post(url, data: body, options: Options(headers: headers));
      print(response.data);
      print('Request body: $body');
      print('Response: ${response.data}');

      if (response.statusCode == 200) {
      } else {
        statusCode.value = response.statusCode ?? 0;
      }
    } catch (e) {
      print(e);
    } finally {
      isLoading.value = false; // Stop loading
    }
  }

  // Future<void> regesterState() async {
  //   isLoading.value = true; // Show loading indicator

  //   try {
  //     final response = await DioHelper.postDataWithAuth(
  //       url: '$baseUrl/auth/register',
  //       data: {
  //         'first_name': firstNameController.text,
  //         'last_name': lastNameController.text,
  //         'username': usernameController.text,
  //         'email': emailController.text,
  //         'password': passwordController.text,
  //         'confirm_password': confirmPasswordController.text,
  //         'address': addressController.text,
  //         'phone_number': phoneNumberController.text,
  //         "client_token": "ahmaddeeb"
  //       },
  //     );

  //     // final data = response.data;
  //     if (response != null) {
  //       regesterModel = RegesterDataModel.fromJson(response["data"]);
  //       if (regesterModel != null && regesterModel != null) {
  //         token = regesterModel!.token!;
  //         userEmail = emailController.text;
  //         role = regesterModel!.role!;
  //         isUser = regesterModel!.role == "User";
  //         isHallOwner = regesterModel!.role == "HallOwner";
  //         box.write('token', token);
  //         roleBox.write('role', role);
  //         box.write('token', token);

  //         firstNameController.clear();
  //         lastNameController.clear();
  //         usernameController.clear();
  //         passwordController.clear();
  //         // emailController.clear();
  //         phoneNumberController.clear();
  //         addressController.clear();
  //         addressController.clear();
  //         confirmPasswordController.clear();
  //         Get.to(OtpPage(
  //           email: emailController.text,
  //           isForgetPassword: false,
  //         ));
  //         // Get.snackbar('Success', 'Registration successful',
  //         //     snackPosition: SnackPosition.TOP);
  //       }
  //     }
  //   } catch (error) {
  //     Get.snackbar('Error', 'Registration failed: $error',
  //         snackPosition: SnackPosition.BOTTOM);
  //   } finally {
  //     isLoading.value = false; // Hide loading indicator
  //   }
  // }
  void validateForm() {
    if (fullNameController.text.isEmpty) {
      Get.closeAllSnackbars();
      Get.snackbar(
        'Error',
        'Please enter your Full Name',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    if (jobNumberController.text.isEmpty) {
      Get.closeAllSnackbars();
      Get.snackbar(
        'Error',
        'Please enter your Employee ID',
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

    if (confirmPasswordController.text.isEmpty) {
      Get.closeAllSnackbars();
      Get.snackbar(
        'Error',
        'Please confirm your password',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    } else if (confirmPasswordController.text != passwordController.text) {
      Get.closeAllSnackbars();
      Get.snackbar(
        'Error',
        'Confirmed password does not match',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    // If all validations pass, proceed
    sendInfoToAdmin();
  }

  void sendInfoToAdmin() {
    isWaitAdminApproved.value = true;
    Future.delayed(const Duration(seconds: 5), () {
      isWaitAdminApproved.value = false;
      Get.offAllNamed(Routes.LOGIN);
    });
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tracking_system_app/controller/radio_controller.dart';
import 'package:tracking_system_app/routes/app_pages.dart';

class RegisterController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController jobNumberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final RadioController jopTitleController =
      Get.put(RadioController(), tag: 'JopTitle');
  final List<String> radioData = ['Employee', 'Driver'];
  // final TextEditingController jopTitleController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  RxBool isWaitAdminApproved = false.obs;
  // late AnimationController lottieController;
  var isLoading = false.obs; // Add loading state

  // RegesterDataModel? regesterModel;

  void register() {
    if (formKey.currentState!.validate()) {
      // regesterState();
    } else {
      // If the form is not valid, show error messages
    }
  }

  void sendInfoToAdmin() {
    isWaitAdminApproved.value = true;
    Future.delayed(const Duration(seconds: 5), () {
      isWaitAdminApproved.value = false;
      Get.offAllNamed(Routes.LOGIN);
    });
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

    if (jopTitleController.selectedValue.value == null) {
      Get.snackbar(
        'Error',
        'Please choose a job title',
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
        'Please enter your Job Number',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

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

  @override
  void onInit() {
    // Initialize the animation controller with slower speed
    // lottieController = AnimationController(
    //   vsync: this,
    //   duration: const Duration(seconds: 3), // Slow down the animation speed
    // )..repeat(); // Repeats the animation

    super.onInit();
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
    jobNumberController.dispose();
    // jopTitleController.dispose();
    super.dispose();
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tracking_system_app/modules/auth/controller/login_controller.dart';
import 'package:tracking_system_app/routes/app_pages.dart';
import 'package:tracking_system_app/style/app_var.dart';
import 'package:tracking_system_app/widgets/auth/costume_login_TextField_widget.dart';
import 'package:tracking_system_app/widgets/auth/login-defult_button.dart';

class LoginScreenMobileLayout extends GetView<LoginController> {
  const LoginScreenMobileLayout(BuildContext context, {super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor:
            MediaQuery.of(context).orientation == Orientation.landscape
                ? AppVar.primary
                : AppVar.background,
        body: OrientationBuilder(
          builder: (context, orientation) {
            final screenWidth = MediaQuery.sizeOf(context).width;
            final screenHeight = MediaQuery.sizeOf(context).height;
            final isLandscape =
                MediaQuery.of(context).orientation == Orientation.landscape;
            if (orientation == Orientation.landscape) {
              return SingleChildScrollView(
                child: LoginBody(
                  isLandscape: isLandscape,
                  screenHeight: screenHeight,
                  screenWidth: screenWidth,
                ),
              );
            } else {
              return Stack(
                children: [
                  Positioned(
                    bottom: 0,
                    child: Image(
                      width: screenWidth,
                      image: const AssetImage('assets/images/Rectingle.jpg'),
                      fit:
                          // avarige >= 895 ||
                          //         avarige == 630 && !isLandscape
                          //     ? BoxFit.fill
                          //     :
                          BoxFit.cover,
                    ),
                  ),
                  LoginBody(
                    isLandscape: isLandscape,
                    screenHeight: screenHeight,
                    screenWidth: screenWidth,
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}

class LoginBody extends StatelessWidget {
  const LoginBody({
    super.key,
    required this.isLandscape,
    required this.screenHeight,
    required this.screenWidth,
  });

  final bool isLandscape;
  final double screenHeight;
  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: 40,
          // isTablet ? 80.0 : 40.0,
          vertical: 0
          // isLandscape
          //     ? 20
          //     : 40.0, // Reduce vertical padding in landscape
          ),
      child: GetBuilder<LoginController>(
        init: LoginController(),
        builder: (controller) {
          return Form(
            key: controller.formKey,
            child: Column(
              mainAxisAlignment: isLandscape
                  ? MainAxisAlignment.start
                  : MainAxisAlignment.center, // Adjust alignment for landscape
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: isLandscape ? 20.0 : 0),
                  child: Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(1000),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(1000),
                            color: AppVar.background,
                            border:
                                Border.all(width: 3, color: AppVar.primary)),
                        width: 150,
                        height: 150,
                        child: Image.asset(
                          "assets/images/Logo1.png",
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                    height: isLandscape
                        ? screenHeight * 0.05
                        : screenWidth * 0.15), // Adjust spacing
                const SizedBox(height: 20),
                const Padding(
                  padding: EdgeInsets.only(bottom: 30.0, top: 30),
                  child: Text(
                    "Sign In",
                    style: TextStyle(
                      color: AppVar.seconndTextColor,
                      fontSize: 40,
                      shadows: [
                        Shadow(
                          color: Color.fromARGB(255, 79, 79, 79),
                          offset: Offset(2, 4),
                          blurRadius: 5,
                        ),
                      ],
                    ),
                  ),
                ),
                CustomeLoginTextFormField(
                  hintText: 'Phone Number',
                  inputType: TextInputType.number,
                  title: 'Phone Number',
                  prefixIcon: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          'assets/images/uae_flag.png',
                          width: 24,
                          height: 24,
                        ),
                        const SizedBox(width: 5),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          decoration: const BoxDecoration(
                              border: Border(
                            right: BorderSide(
                              color: AppVar.seconndTextColor,
                              width: 1.0,
                            ),
                          )),
                          child: const Text(
                            '+971',
                            style: TextStyle(
                              fontSize: 14,
                              color: AppVar.seconndTextColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  controller: controller.phoneNumberController,
                  validator: null,
                ),
                CustomeLoginTextFormField(
                  prefixIcon: null,
                  inputType: TextInputType.text,
                  hintText: '••••••••••••••••',
                  title: 'Password',
                  controller: controller.passwordController,
                  validator: null,
                ),
                GestureDetector(
                  onTap: () {
                    Get.toNamed(Routes.FORGOT_PASSWORD);
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "Forgot password?",
                        style: TextStyle(
                            fontSize: 13, color: AppVar.seconndTextColor),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                LoginDefultButton(
                  fontsize: AppVar.mainFontSize,
                  buttonColor: const Color(0xff1CB26B),
                  borderColor: Colors.transparent,
                  textColor: AppVar.seconndTextColor,
                  title: "SIGN IN",
                  onPressed: () {
                    if (controller.formKey.currentState!.validate()) {
                      controller.validateForm();
                    }
                  },
                ),
                const SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.only(bottom: 30.0),
                  child: Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Don't have an account? ",
                          style: TextStyle(
                            color: AppVar.seconndTextColor,
                            fontSize: AppVar.littelFontSize,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.toNamed(Routes.REGISTER);
                          },
                          child: DecoratedBox(
                            decoration: const BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      color: Colors.white, width: 1.0)),
                            ),
                            child: Text(
                              "Sign up",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: AppVar.littelFontSize,
                                color: const Color(0xff1CB26B),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
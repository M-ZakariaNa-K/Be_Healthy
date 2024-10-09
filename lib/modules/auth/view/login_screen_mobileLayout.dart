import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tracking_system_app/modules/auth/controller/login_controller.dart';
import 'package:tracking_system_app/modules/auth/view/login_body.dart';
import 'package:tracking_system_app/style/app_var.dart';

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
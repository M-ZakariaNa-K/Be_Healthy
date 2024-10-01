import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tracking_system_app/routes/app_pages.dart';

class SplashController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> scaleAnimation;
  late Animation<double> opacityAnimation;

  @override
  void onInit() {
    super.onInit();

    // Initialize the animation controller
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(
          milliseconds: 2000), // Increased duration for smoothness
    );

    // Define the scale animation (Tweens from 0.5 to 1.0)
    scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.easeOutCubic, // Use a smoother cubic easing curve
      ),
    );

    // Define the opacity animation
    opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.easeInOut, // Keep opacity smooth
      ),
    );

    // Start the animation
    animationController.forward();

    // Navigate to login after a delay
    Future.delayed(const Duration(seconds: 5), () {
      Get.offNamed(Routes.LOGIN);
    });
  }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }
}

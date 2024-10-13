import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tracking_system_app/modules/splash/controller/splash_controller.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final SplashController controller = Get.put(SplashController());

    return Scaffold(
      backgroundColor: const Color(0xff146635),
      body: Center(
        child: GetBuilder<SplashController>(
          builder: (_) => AnimatedBuilder(
            animation: controller.animationController,
            builder: (context, child) {
              return Opacity(
                opacity: controller.opacityAnimation.value,
                child: Transform.scale(
                  scale: controller.scaleAnimation.value, // Scale animation
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(
                      100, // For a circular shape
                    ),
                    child: SizedBox(
                      width: 300,
                      height: 300,
                      child: SvgPicture.asset(
                        "assets/images/Logo-1.svg",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:tracking_system_app/modules/auth/controller/register_controller.dart';
import 'package:tracking_system_app/style/app_var.dart';
import 'package:tracking_system_app/widgets/auth/regester_form_widget.dart';

class RegesterScreenTapletLayout extends GetView<RegisterController> {
  const RegesterScreenTapletLayout(BuildContext context, {super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppVar.primary,
        body: OrientationBuilder(
          builder: (context, orientation) {
            final screenWidth = MediaQuery.sizeOf(context).width;
            final screenHeight = MediaQuery.sizeOf(context).height;
            final isTablet =
                screenWidth > 600; // Adjust the breakpoint as needed
            final isLandscape =
                MediaQuery.of(context).orientation == Orientation.landscape;
            return SingleChildScrollView(
              child: Stack(
                children: [
                  if (!isLandscape)
                    Positioned(
                      child: Image(
                        width: screenWidth,
                        image: const AssetImage('assets/images/Rectingle.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),

                  // Waiting for admin approval (Lottie Animation)
                  Obx(() {
                    if (controller.isWaitAdminApproved.value) {
                      return Positioned(
                        bottom: MediaQuery.sizeOf(context).height * 0.25,
                        right: 0,
                        left: 0,
                        child: Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(1000),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(1000),
                                    color: AppVar.background,
                                    border: Border.all(
                                        width: 3, color: AppVar.primary)),
                                width: 150,
                                height: 150,
                                child: Image.asset(
                                  "assets/images/Logo1.png",
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Center(
                              child: LottieBuilder.asset(
                                repeat: false,
                                "assets/Lottie/Animation - 1726871315481.json",
                                width: 200,
                                height: 200,
                                fit: BoxFit.fill,
                              ),
                            ),
                            const SizedBox(height: 20),
                            const Text(
                              "Done!",
                              style: TextStyle(
                                color: Color(0xff1CB26B),
                                fontSize: 30,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 20),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 15),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 1,
                                  color: const Color(0xff1CB26B),
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Text(
                                "Waiting for admin approval",
                                style: TextStyle(
                                  color: AppVar.seconndTextColor,
                                  fontSize: 16,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      );
                    } else {
                      return Container();
                    }
                  }),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 30),
                    child: Obx(
                      () => Opacity(
                        opacity: controller.isWaitAdminApproved.value ? 0 : 1,
                        child: RegesterFormWidget(
                            controller: controller,
                            isLandscape: isLandscape,
                            isTablet: isTablet,
                            screenWidth: screenWidth,
                            screenHeight: screenHeight),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

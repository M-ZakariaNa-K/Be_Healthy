import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tracking_system_app/modules/home/controller/home_controller.dart';
import 'package:tracking_system_app/style/app_var.dart';
import 'package:tracking_system_app/widgets/general/main_loading_widget.dart';

class CustomSignOutDialog extends StatelessWidget {
  CustomSignOutDialog({super.key});

  final HomeController homeController = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10), // Border radius of 20
      ),
      backgroundColor: Colors.white, // Dialog background color
      child: Padding(
        padding: const EdgeInsets.all(20.0), // Padding inside the dialog
        child: SizedBox(
          width: isLandscape ? MediaQuery.sizeOf(context).width * 0.4 : null,
          child: Stack(
            children: [
              Obx(
                () => Column(
                  mainAxisSize: MainAxisSize
                      .min, // Adjusts the height of the dialog based on its content
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    const SizedBox(
                        height: 5), // Spacing between title and subtitle
                    const Center(
                      child: Text(
                        "Sign Out",
                        style: TextStyle(
                          fontSize: 22.85,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(
                        height: 20), // Spacing between subtitle and text field
                    const Center(
                      child: Text(
                        "Do you want to log out?",
                        style: TextStyle(
                          color: Color(0xff878787),
                          fontSize: 13.33,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(
                        height: 20), // Spacing between text field and button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        //-------------------Cancel button-------------------
                        GestureDetector(
                          onTap: () {
                            homeController.exitSignOutDialog();
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            decoration: BoxDecoration(
                              border:
                                  Border.all(color: const Color(0xffD6D6D6)),
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Text(
                              "Cancel",
                              style: TextStyle(
                                color: AppVar.textColor,
                                fontSize: 13.33,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        //-------------------Log out-------------------------
                        GestureDetector(
                          onTap: () async {
                            //Here u will LOGOUT
                            await homeController.logout();
                            // homeController.sendToAdmin();
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            decoration: BoxDecoration(
                              color: const Color(0xffFE8C00),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Text(
                              "Log Out",
                              style: TextStyle(
                                color: AppVar.seconndTextColor,
                                fontSize: 13.33,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    if (homeController.isLoading.value)
                      const SizedBox(child: MainLoadingWidget())
                  ],
                ),
              ),
              Positioned(
                right: 0,
                top: 0,
                child: GestureDetector(
                  onTap: () {
                    homeController.exitSignOutDialog();
                  },
                  child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          border: Border.all(
                              width: 1, color: const Color(0xffEDEDED)),
                          borderRadius: BorderRadius.circular(5)),
                      child: const Icon(
                        size: 18,
                        Icons.close_rounded,
                        color: AppVar.textColor,
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:tracking_system_app/modules/home/controller/home_controller.dart';
import 'package:tracking_system_app/style/app_var.dart';
import 'package:tracking_system_app/widgets/general/main_loading_widget.dart';

class CustomMessageDialog extends StatelessWidget {
  final String title;
  final String subtitle;
  CustomMessageDialog({super.key, required this.title, required this.subtitle});

  final HomeController homeController = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20), // Border radius of 20
      ),
      backgroundColor: Colors.white, // Dialog background color
      child: Padding(
        padding: const EdgeInsets.all(20.0), // Padding inside the dialog
        child: Stack(
          children: [
            Column(
              mainAxisSize: MainAxisSize
                  .min, // Adjusts the height of the dialog based on its content
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                Row(
                  children: [
                    Text(
                      "${homeController.myInfoModel.value.role.capitalize} name: ",
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      title,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5), // Spacing between title and subtitle
                Row(
                  children: [
                    Text(
                      "${homeController.myInfoModel.value.role.capitalize} ID: ",
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                    height: 40), // Spacing between subtitle and text field

                // Big Text Form Field
                TextFormField(
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppVar.textColor,
                  ),
                  onChanged: (value) {
                    if (value != "") {
                      homeController.isTextFildFilled.value = true;
                    } else {
                      homeController.isTextFildFilled.value = false;
                    }
                  },
                  controller: homeController.issueDialogController,
                  maxLines: 9, // Makes the text field large
                  decoration: InputDecoration(
                    hintText: 'Enter Your Problem',
                    hintStyle: const TextStyle(
                      color: Color(0xffBFBFBF),
                      fontSize: 12,
                    ),
                    // Customize the border color and radius

                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide:
                          const BorderSide(color: AppVar.textColor, width: 2.0),
                    ),
                    // Customize error design
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide:
                          const BorderSide(color: Colors.red, width: 2.0),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide:
                          const BorderSide(color: Colors.redAccent, width: 2.0),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        10,
                      ),
                      borderSide: const BorderSide(
                          color: Color.fromARGB(255, 125, 125, 125),
                          width: 1.0), // Rounded border for the text field
                    ),
                  ),
                ),
                const SizedBox(
                    height: 20), // Spacing between text field and button
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    // mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        DateFormat('EEE, MMM d, y')
                            .format(DateTime.now())
                            .toString(),
                        style:
                            const TextStyle(fontSize: 11, color: Colors.grey),
                      ),
                      const Spacer(),
                      Obx(
                        () => homeController.isLoading.value
                            ? const SizedBox(child: MainLoadingWidget())
                            :
                            // Show Lottie animation when the request is successful
                            Obx(() {
                                if (homeController.showLottieAnimation.value) {
                                  return Center(
                                    child: SizedBox(
                                      width: 50,
                                      height: 50,
                                      child: Lottie.asset(
                                        repeat: false,
                                        fit: BoxFit.fill,
                                        'assets/Lottie/Animation - 1726871315481.json', // Path to your Lottie animation file
                                      ),
                                    ),
                                  );
                                } else {
                                  return GestureDetector(
                                    onTap: !homeController
                                                .isTextFildFilled.value ||
                                            homeController.isLoading.value
                                        ? null // Disable onTap when loading
                                        : () {
                                            homeController.sendToAdmin();
                                          },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5, horizontal: 10),
                                      decoration: BoxDecoration(
                                        color: homeController.isLoading.value
                                            ? Colors.transparent
                                            : homeController
                                                    .isTextFildFilled.value
                                                ? const Color(0xff3AD189)
                                                : Colors.transparent,
                                        border: !homeController
                                                .isTextFildFilled.value
                                            ? Border.all(color: AppVar.primary)
                                            : null,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Text(
                                        "Send to admin",
                                        style: TextStyle(
                                          color: !homeController
                                                  .isTextFildFilled.value
                                              ? AppVar.primary
                                              : AppVar.seconndTextColor,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  );
                                }
                              }),
                      ),
                    ],
                  ),
                ),
                // Button
              ],
            ),
            Positioned(
              left: 20,
              top: 75,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: const Text(
                  "Your Problem",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: AppVar.textColor,
                  ),
                ),
              ),
            ),
            Positioned(
              right: 0,
              top: 0,
              child: GestureDetector(
                onTap: () {
                  homeController.exitMessageDialog();
                },
                child: Container(
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        border: Border.all(
                            width: 1, color: const Color(0xffEDEDED)),
                        borderRadius: BorderRadius.circular(5)),
                    child: const Icon(
                      Icons.close_rounded,
                      color: AppVar.textColor,
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

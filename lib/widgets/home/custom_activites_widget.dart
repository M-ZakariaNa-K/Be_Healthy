import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tracking_system_app/modules/home/controller/home_controller.dart';
import 'package:tracking_system_app/style/app_var.dart';

class CustomActivitiesCardWidget extends StatelessWidget {
  const CustomActivitiesCardWidget({
    super.key,
    required this.imageName,
    required this.label,
    required this.onTap,
    required this.homeController,
    required this.index, // Add the index of the card
    required this.width,
    required this.height,
  });

  final String imageName;
  final String label;
  final void Function()? onTap;
  final HomeController homeController;
  final int index; // Index for the card
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    // final isLandscape =
    //     MediaQuery.of(context).orientation == Orientation.landscape;
    final isTaplet = MediaQuery.of(context).size.width > 800;
    final dataFontSize = screenWidth *
        (isTaplet ? 0.03 : 0.07); // Smaller font size in landscape
    return GestureDetector(
      onTap: () {
        homeController.selectedCardIndex.value = index;
        if (onTap != null) onTap!(); // Call the onTap callback
      },
      child: Obx(
        () => AnimatedScale(
          scale: homeController.selectedCardIndex.value == index
              ? 1.0
              : 0.9, // Scale only the selected card
          duration: const Duration(milliseconds: 300),
          child: Container(
            width: width,
            height: height,
            margin: const EdgeInsets.symmetric(vertical: 20),
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: homeController.selectedCardIndex.value == index
                  ? const Color(0xff3AD189)
                  : AppVar.background,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                  color: const Color(0xff3AD189),
                  width: 1) // Add border for selected card
              ,
              boxShadow: [
                BoxShadow(
                  color: homeController.selectedCardIndex.value == index
                      ? Colors.black
                          .withOpacity(0.4) // Stronger shadow for selected card
                      : Colors.black.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius:
                      homeController.selectedCardIndex.value == index ? 3 : 3,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  imageName,
                  width: isTaplet ? 100 : 60,
                  height: isTaplet ? 100 : 60,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 25.0),
                  child: SizedBox(
                    child: Text(
                      label,
                      style: TextStyle(
                        fontSize: isTaplet ? dataFontSize : 16,
                        color: homeController.selectedCardIndex.value == index
                            ? AppVar.background
                            : AppVar.textColor,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
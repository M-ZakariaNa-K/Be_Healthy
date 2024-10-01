import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tracking_system_app/modules/home/controller/home_controller.dart';
import 'package:tracking_system_app/style/app_var.dart';
import 'package:tracking_system_app/widgets/home/activites_widget.dart';

class HomeView extends StatelessWidget {
  final HomeController homeController = Get.put(HomeController());

  HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final isTaplet = MediaQuery.of(context).size.width > 800 &&
        MediaQuery.of(context).size.height > 800;

    final dataFontSize =
        screenWidth * (0.066); // Smaller font size in landscape
    final screenHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Stack(
        children: [
          // Background image

          SizedBox(
            width: double.infinity,
            child: Image.asset(
              'assets/images/HomeBackground.png', // Path to your image
              fit: BoxFit.cover,
            ),
          ),

          // Apply a blur effect over the background image
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(
                  sigmaX: 1, sigmaY: 1), // Adjust blur intensity
              child: Container(
                color: AppVar.primary
                    .withOpacity(.9), // Semi-transparent color over the blur
              ),
            ),
          ),
          // Apply a blur effect over the background image
          Positioned(
            bottom: 0,
            child: Container(
              width: MediaQuery.sizeOf(context).width,
              height: isLandscape
                  ? isTaplet
                      ? screenHeight * 0.3
                      : screenHeight * 0.1
                  : screenHeight * 0.5,
              color: AppVar.background,
            ),
          ),
          // Scaffold with transparent background to allow blur to be seen
          Scaffold(
            resizeToAvoidBottomInset: true,
            backgroundColor: Colors.transparent, // Transparent scaffold
            appBar: AppBar(
              backgroundColor: Colors.transparent, // Transparent app bar
              leading: IconButton(
                onPressed: () {
                  homeController.showCustomSignOutDialog(context);
                },
                icon: Icon(
                  size: isTaplet ? 40 : null,
                  Icons.logout,
                  color: AppVar.seconndTextColor,
                ),
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    homeController.showCustomMessageDialog(context);
                  },
                  icon: Icon(
                    size: isTaplet ? 40 : null,
                    Icons.messenger_outline,
                    color: AppVar.seconndTextColor,
                  ),
                ),
              ],
            ),

            // Main content
            body: OrientationBuilder(builder: (context, orientation) {
              return SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.only(
                    top: 20.0,
                    bottom: MediaQuery.of(context)
                        .viewInsets
                        .bottom, // Keyboard padding
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //===========================Welcome Message========================
                      Padding(
                        padding: EdgeInsets.only(
                            right: isTaplet ? 40 : 20,
                            left: isTaplet ? 40 : 20,
                            bottom: 0),
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: SizedBox(
                                width: isTaplet ? 90 : 60,
                                height: isTaplet ? 90 : 60,
                                child: Image.asset(
                                  "assets/images/user.png",
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: isTaplet ? 8 : 4,
                              right: isTaplet ? 8 : 4,
                              child: Container(
                                width: 10,
                                height: 10,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(1000.0),
                                  color:
                                      const Color.fromARGB(255, 13, 218, 119),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      //----------------------------
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: isTaplet ? 40 : 20),
                        child: Text(
                          "Hi Ahmad!",
                          style: TextStyle(
                            fontFamily: "Allerta",
                            fontSize: dataFontSize,
                            color: AppVar.seconndTextColor,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      //----------------------------
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: isTaplet ? 40 : 20),
                        child: Text(
                          "ID: 002024",
                          style: TextStyle(
                            fontSize: 18,
                            color: AppVar.seconndTextColor,
                          ),
                        ),
                      ),
                      //----------------------------
                      const SizedBox(height: 50), // Adjust spacing

                      //===========================End Welcome Message========================
                      ActivitesWidget(homeController: homeController),
                    ],
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}

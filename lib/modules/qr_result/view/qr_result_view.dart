import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:tracking_system_app/modules/qr_scan/controller/qr_scan_controller.dart';
import 'package:tracking_system_app/style/app_var.dart';

class QRResultPage extends StatelessWidget {
  final QrScanController qrController = Get.put(QrScanController());

  QRResultPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: PopScope(
        onPopInvokedWithResult: (popDisposition, result) {
          qrController
              .closeScreen(); // Call closeScreen when back button is pressed
          return; // Allow the pop (back) action to happen
        },
        child: Stack(
          children: [
            Scaffold(
              backgroundColor: const Color(0xffDEFEEF),
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                leading: IconButton(
                  color: AppVar.primary,
                  onPressed: () {
                    qrController.closeScreen();
                    Get.back();
                  },
                  icon: const Icon(Icons.arrow_back_ios_new),
                ),
              ),
              body: Center(
                child: Container(
                  padding: const EdgeInsets.all(40),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: const Color(0xffD9FFE3),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        spreadRadius: 2.0,
                        blurRadius: 10.0,
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20.0),
                        child: Text(
                          "Success",
                          style: TextStyle(
                            color: AppVar.primary,
                            fontSize: 40,
                          ),
                        ),
                      ),
                      QrImageView(
                        data: qrController.code.value,
                        size: 150,
                        version: QrVersions.auto,
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: 220,
                        child: Text(
                          qrController.code.value,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppVar.primary,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Obx(() {
                        return AnimatedSwitcher(
                          duration: const Duration(
                              milliseconds: 300), // Smooth transition duration
                          child: qrController.showLottieAnimationInResult.value
                              ? SizedBox(
                                  key: const ValueKey(
                                      'lottie'), // Key to distinguish widgets
                                  width: 62,
                                  height: 62,
                                  child: Lottie.asset(
                                    'assets/Lottie/Animation - 1726871315481.json',
                                    repeat: false,
                                    fit: BoxFit.fill,
                                  ),
                                )
                              : GestureDetector(
                                  key: const ValueKey(
                                      'copyButton'), // Key to distinguish widgets
                                  onTap: () async {
                                    await Clipboard.setData(ClipboardData(
                                        text: qrController.code.value));
                                    qrController.showLottieAnimationFunction();
                                  },
                                  child: AnimatedOpacity(
                                    duration: const Duration(milliseconds: 300),
                                    opacity: qrController
                                            .showLottieAnimationInResult.value
                                        ? 0.0
                                        : 1.0,
                                    child: AnimatedContainer(
                                      duration:
                                          const Duration(milliseconds: 300),
                                      margin: const EdgeInsets.only(bottom: 20),
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5, horizontal: 20),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.transparent,
                                        border: Border.all(
                                          color: AppVar.primary,
                                          width: 2,
                                        ),
                                      ),
                                      child: Text(
                                        "Copy",
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: AppVar.primary,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                        );
                      }),

                      // Container(
                      //   margin: const EdgeInsets.only(bottom: 20),
                      //   padding: const EdgeInsets.symmetric(
                      //       vertical: 5, horizontal: 20),
                      //   decoration: BoxDecoration(
                      //       borderRadius: BorderRadius.circular(10),
                      //       color: Colors.transparent,
                      //       border: Border.all(
                      //         color: AppVar.primary,
                      //         width: 2,
                      //       )),
                      //   child: Text(
                      //     "Copy",
                      //     style: TextStyle(
                      //       fontSize: 20,
                      //       color: AppVar.primary,
                      //       fontWeight: FontWeight.bold,
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
            ),

            Positioned(
              top: -62,
              right: -62,
              child: Container(
                width: 150,
                height: 150,
                // margin: const EdgeInsets.only(bottom: 20),
                // padding:
                //     const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10000),
                    color: Colors.transparent,
                    border: Border.all(
                      color: AppVar.primary,
                      width: 1,
                    )),
              ),
            ),
            Positioned(
              bottom: 220,
              right: -110,
              child: Opacity(
                opacity: .1,
                child: Container(
                  width: 150,
                  height: 150,
                  // margin: const EdgeInsets.only(bottom: 20),
                  // padding:
                  //     const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10000),
                      color: AppVar.primary,
                      border: Border.all(
                        color: AppVar.primary,
                        width: 1,
                      )),
                ),
              ),
            ),
            Positioned(
              bottom: 300,
              left: -10,
              child: Opacity(
                opacity: .1,
                child: Container(
                  width: 50,
                  height: 50,
                  // margin: const EdgeInsets.only(bottom: 20),
                  // padding:
                  //     const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10000),
                      color: AppVar.primary,
                      border: Border.all(
                        color: AppVar.primary,
                        width: 1,
                      )),
                ),
              ),
            ),
            Positioned(
              top: 100,
              left: -40,
              child: Opacity(
                opacity: .1,
                child: Container(
                  width: 100,
                  height: 100,
                  // margin: const EdgeInsets.only(bottom: 20),
                  // padding:
                  //     const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10000),
                      color: AppVar.primary,
                      border: Border.all(
                        color: AppVar.primary,
                        width: 1,
                      )),
                ),
              ),
            ),
            Positioned(
              top: 100,
              right: 40,
              child: Opacity(
                opacity: .1,
                child: Container(
                  width: 50,
                  height: 50,
                  // margin: const EdgeInsets.only(bottom: 20),
                  // padding:
                  //     const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10000),
                      color: AppVar.primary,
                      border: Border.all(
                        color: AppVar.primary,
                        width: 1,
                      )),
                ),
              ),
            ),
            // Positioned(
            //   top: -100,
            //   left: 0,
            //   right: 0,
            //   child: SizedBox(
            //     width: double.infinity,
            //     child: Image.asset(
            //       'assets/images/HomeBackground.png', // Path to your image
            //       fit: BoxFit.cover,
            //     ),
            //   ),
            // ),
            // Positioned(
            //   bottom: -240,
            //   left: -20,
            //   right: 0,
            //   child: SizedBox(
            //     width: double.infinity,
            //     child: Image.asset(
            //       'assets/images/HomeBackground.png', // Path to your image
            //       fit: BoxFit.cover,
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qr_scanner_overlay/qr_scanner_overlay.dart';
import 'package:tracking_system_app/modules/qr_scan/controller/qr_scan_controller.dart';
import 'package:tracking_system_app/style/app_var.dart';
import 'package:tracking_system_app/widgets/general/main_loading_widget.dart';

class QrScanView extends StatelessWidget {
  QrScanView({
    super.key,
  });
  final QrScanController qrController = Get.put(QrScanController());

  @override
  Widget build(BuildContext context) {
    final isTaplet = MediaQuery.of(context).size.width > 800 &&
        MediaQuery.of(context).size.height > 800;
    return SafeArea(
      child: PopScope(
        onPopInvokedWithResult: (popDisposition, result) async {
          
          qrController.resetOrientation();
          // SystemChrome.setPreferredOrientations([
          //   DeviceOrientation.portraitUp,
          //   DeviceOrientation.portraitDown,
          //   DeviceOrientation.landscapeLeft,
          //   DeviceOrientation.landscapeRight,
          // ]);
          // await _resetOrientation(); // Reset orientation when leaving
          return; // Allow the pop (back) action to happen
        },
        child: Scaffold(
          backgroundColor: const Color(0xffDEFEEF),
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            leading: IconButton(
              onPressed: () async {
                // Stop the camera and dispose of the controller manually
                //NOTE: U will put this line before go to any page from the home page
                await qrController.disposeCamera();
                // SystemChrome.setPreferredOrientations([
                //   DeviceOrientation.portraitUp,
                //   DeviceOrientation.portraitDown,
                //   DeviceOrientation.landscapeLeft,
                //   DeviceOrientation.landscapeRight,
                // ]);
                // await _resetOrientation(); // Reset orientation when leaving
                //  Get.delete<QrScanController>();
                Get.back();
              },
              icon: Icon(
                Icons.arrow_back_ios_new,
                color: AppVar.primary,
              ),
            ),
            actions: [
              Obx(() => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: IconButton(
                      onPressed: qrController.toggleFlash,
                      icon: Icon(
                        Icons.flash_on,
                        color: qrController.isFlashOn.value
                            ? Colors.white
                            : AppVar.primary,
                      ),
                    ),
                  )),
            ],
          ),
          body: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            child: Column(
              children: <Widget>[
                const Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Text(
                          "Scan QR here:",
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Expanded(
                  flex: 2,
                  child: Stack(
                    children: [
                      GestureDetector(
                        onTap:
                            qrController.retryScanner, // Tap to retry scanner

                        child: SizedBox(
                          child: MobileScanner(
                            controller: qrController.cameraController,
                            onDetect: (barcodeCapture) {
                              print(
                                  '=================================================================');
                              print('${barcodeCapture.barcodes}');
                              print(
                                  '=================================================================');
                              final barcodes = barcodeCapture.barcodes;
                              if (barcodes.isNotEmpty) {
                                for (final barcode in barcodes) {
                                  if (barcode.rawValue != null) {
                                    WidgetsBinding.instance
                                        .addPostFrameCallback((_) {
                                      qrController
                                          .onDetectBarcode(barcode.rawValue!);
                                    });
                                    break;
                                  }
                                }
                              }
                            },

                            // controller: qrController.cameraController,
                            // onDetect: (barcodeCapture) {
                            // if (!qrController.isScanCompleted.value) {
                            // final barcodes = barcodeCapture.barcodes;
                            // if (barcodes.isNotEmpty) {
                            //   for (final barcode in barcodes) {
                            //     if (barcode.rawValue != null) {
                            //       qrController.code.value = barcode.rawValue!;
                            //       qrController.isScanCompleted.value = true;
                            //       //go to Qr result page
                            //       Get.toNamed(Routes.QR_RESULT);
                            //       break;
                            //     }
                            //   }
                            // }

                            // }
                            // },
                            errorBuilder: (context, error, child) {
                              return Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.error_outline,
                                      color: Colors.red,
                                      size: 80,
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      'An error occurred: ${error.errorDetails?.details ?? error.toString()}',
                                      style: const TextStyle(
                                        color: Colors.red,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    // const SizedBox(height: 20),
                                    // ElevatedButton(
                                    //   onPressed: qrController.retryScanner,
                                    //   child: const Text("Retry"),
                                    // ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      QRScannerOverlay(
                        overlayColor: Colors.black26,
                        borderColor: const Color(0xff3AD189),
                        borderRadius: 22,
                        borderStrokeWidth: 5,
                        scanAreaWidth: 250,
                        scanAreaHeight: 250,
                      ),
                      // Loading indicator with blur effect
                      Obx(() {
                        if (qrController.isLoading.value) {
                          return Container(
                            color: Colors.black
                                .withOpacity(0.6), // Blurred background
                            child: const Center(
                              child: MainLoadingWidget(), // Loading spinner
                            ),
                          );
                        }
                        return const SizedBox.shrink();
                      }),
                    ],
                  ),
                ),
                const Spacer(),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white,
                    border: Border.all(
                      color: AppVar.textColor,
                      width: 2,
                    ),
                  ),
                  child: Obx(
                    () => Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Check In Container

                        Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          decoration: BoxDecoration(
                            borderRadius:
                                qrController.scanningKind.value == "check_in"
                                    ? BorderRadius.circular(13)
                                    : null,
                            color: qrController.scanningKind.value == "check_in"
                                ? AppVar.primary
                                : Colors.transparent,
                          ),
                          child: Text(
                            "Check In  ",
                            style: TextStyle(
                              color:
                                  qrController.scanningKind.value == "check_in"
                                      ? Colors.white
                                      : Colors.grey,
                              fontWeight: FontWeight.bold,
                              fontSize: isTaplet ? 20 : 12,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          decoration: BoxDecoration(
                            border: qrController.scanningKind.value !=
                                        "delivered" &&
                                    qrController.scanningKind.value ==
                                        "check_out"
                                ? const Border(
                                    left: BorderSide(
                                      width: 1,
                                    ),
                                  )
                                : qrController.scanningKind.value !=
                                            "delivered" &&
                                        qrController.scanningKind.value ==
                                            "check_in"
                                    ? const Border(
                                        right: BorderSide(
                                          width: 1,
                                        ),
                                      )
                                    : null,
                            borderRadius: qrController.scanningKind.value ==
                                    "delivered"
                                ? BorderRadius.circular(15)
                                : qrController.scanningKind.value == "check_in"
                                    ? const BorderRadius.only(
                                        topRight: Radius.circular(15),
                                        bottomRight: Radius.circular(15),
                                      )
                                    : const BorderRadius.only(
                                        topLeft: Radius.circular(15),
                                        bottomLeft: Radius.circular(15),
                                      ),
                            color:
                                qrController.scanningKind.value == "delivered"
                                    ? AppVar.primary
                                    : Colors.transparent,
                          ),
                          child: Text(
                            "Delivered",
                            style: TextStyle(
                              color:
                                  qrController.scanningKind.value == "delivered"
                                      ? Colors.white
                                      : Colors.grey,
                              fontWeight: FontWeight.bold,
                              fontSize: isTaplet ? 20 : 12,
                            ),
                          ),
                        ),
                        // Check Out Container
                        Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          decoration: BoxDecoration(
                            borderRadius:
                                qrController.scanningKind.value == "check_out"
                                    ? BorderRadius.circular(13)
                                    : null,
                            color:
                                qrController.scanningKind.value == "check_out"
                                    ? AppVar.primary
                                    : Colors.transparent,
                          ),
                          child: Text(
                            "Check Out",
                            style: TextStyle(
                              color:
                                  qrController.scanningKind.value == "check_out"
                                      ? Colors.white
                                      : Colors.grey,
                              fontWeight: FontWeight.bold,
                              fontSize: isTaplet ? 20 : 12,
                            ),
                          ),
                        ),
                      ],
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

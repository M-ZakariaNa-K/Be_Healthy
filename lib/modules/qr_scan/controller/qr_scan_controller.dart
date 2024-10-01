import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tracking_system_app/routes/app_pages.dart';
import 'package:tracking_system_app/shared/shared.dart';

//NOTE FROM ZAKARIA: if u want to go to any page from the scan page, u should make this:
/*qrController.disposeCamera(); Get.back(); */
//EXPECT QR result Page

class QrScanController extends GetxController {
  // Observable variables
  RxBool isScanCompleted = false.obs;
  RxBool isFlashOn = false.obs;
  RxString code = "".obs;
  RxString scanningKind = "".obs;
  MobileScannerController? cameraController;
  RxBool isLoading = false.obs;
  RxBool showLottieAnimationInResult = false.obs;

  // @override
  // void onReady() {
  //   super.onReady();

  //   startCamera();
  // }
  // Lock orientation to portrait when the page is built
  Future<void> lockOrientation() async {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }

  // // Unlock orientation when leaving   the page
  Future<void> resetOrientation() async {
    isFlashOn.value = false;
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

//I need it JUST when i open the page in first time
  @override
  void onInit() {
    super.onInit();
    // Lock orientation to portrait when the QRScan view is initialized
    lockOrientation();
    disposeCamera();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      requestCameraPermission();
    });

    if (isCameraStarted) {
      startCamera();
    }
    isCameraStarted = true;
  }

  Future<void> disposeCamera() async {
    // Reset orientation to allow all orientations when leaving the QRScan view
    resetOrientation();

    isFlashOn.value = false;
    if (cameraController != null) {
      await cameraController!.stop();
      cameraController!.dispose();
      cameraController = null; // Ensure it's set to null after disposal
    }

    //i call it cause the cameraController being null in all time()and i want it to be null and after go back to the page be MobileScannerController()
    cameraController ??= MobileScannerController();
    print('cameraController ddiisisisisisis: ${cameraController}');
  }

  Future<void> startCamera() async {
    // Check if the camera is already initialized to avoid creating multiple instances
    cameraController ??= MobileScannerController();
    print(
        'cameraController STARRT=========================: ${cameraController}');
    if (cameraController != null) {
      await cameraController!
          .start(); // Start the camera when HomeView is ready
    }
    print("Camera started");
  }

  // Stop and dispose of the camera when the controller is destroyed
  @override
  void onClose() {
    Get.delete<QrScanController>();

    super.onClose();
  }

  // Close screen and reset the scan state
  void closeScreen() {
    isScanCompleted.value = false;
  }

  // Toggle flash
  void toggleFlash() {
    print(cameraController);
    if (cameraController != null) {
      isFlashOn.value = !isFlashOn.value;

      cameraController!.toggleTorch();
    }
  }

  // Retry the scanner after stopping and restarting the camera
  Future<void> retryScanner() async {
    isFlashOn.value = false;
    await cameraController?.stop();
    // await Future.delayed(const Duration(milliseconds: 500));
    await cameraController?.start();
  } //=============================Server side================================================================

  Future<void> makePostRequest(String qrCodeData) async {
    try {
      isLoading.value = true; // Show loading indicator
      //DELETE FUTURE DELAYED WHEN U LINK WITH API
      Future.delayed(const Duration(seconds: 5), () {
        isLoading.value = false; // Hide loading indicator
        // Delay the navigation to the next frame to avoid calling setState() during build
        // WidgetsBinding.instance.addPostFrameCallback((_) {
        // });
        Get.toNamed(Routes.QR_RESULT);
      });

      // If you're using a server-side API, uncomment the following lines and replace '/your-endpoint' with your actual endpoint URL
      // final response = await $.post('/your-endpoint', body: {
      //   'qr_data': qrCodeData,
      //   // Add other necessary data here
      // });

      // isLoading.value = false; // Hide loading indicator

      // if (response != null && response['status'] == 'success') {
      //   // Navigate to QR result page
      //   Get.toNamed(Routes.QR_RESULT);
      // } else {
      //   // Show error Snackbar on failure
      //   Get.snackbar('Error', 'Failed to process the QR code. Please try again.');
      // }
    } catch (e) {
      isLoading.value = false;
      Get.snackbar('Error', 'An unexpected error occurred. Please try again.');
    }
  }

  void onDetectBarcode(String qrData) {
    if (!isScanCompleted.value) {
      code.value = qrData;
      isScanCompleted.value = true;
      // Make POST request with scanned QR data
      makePostRequest(qrData);
    }
  }

  //--------------------------RESULT VIEW-----------------------------------------
  Future<void> showLottieAnimationFunction() async {
    // Show Lottie animation for 3 seconds
    showLottieAnimationInResult.value = true;
    await Future.delayed(const Duration(seconds: 3));
    showLottieAnimationInResult.value = false;
  }

  //=========================================================== PIREMISSION--------------------------------
  Future<void> requestCameraPermission() async {
    PermissionStatus status = await Permission.camera.status;

    if (status.isDenied || status.isPermanentlyDenied) {
      // Request the permission again
      status = await Permission.camera.request();
    }

    if (status.isPermanentlyDenied) {
      // The user permanently denied permission, open app settings
      openAppSettings();
    } else if (status.isGranted) {
      // Permission granted, continue with your scanner
    }
  }
}

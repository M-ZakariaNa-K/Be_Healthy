import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tracking_system_app/controller/life_cycle_controller.dart';
import 'package:tracking_system_app/model/qr_scan_model.dart';
import 'package:tracking_system_app/network_util.dart';
import 'package:tracking_system_app/routes/app_pages.dart';
import 'package:tracking_system_app/shared/shared.dart';
import 'package:tracking_system_app/widgets/toast/custom_toast.dart';

//NOTE FROM ZAKARIA: if u want to go to any page from the scan page, u should make this:
/*qrController.disposeCamera(); Get.back(); */
//EXPECT QR result Page

class QrScanController extends GetxController {
  // Observable variables
  RxBool isScanCompleted = false.obs;
  RxBool isFlashOn = false.obs;
  RxString code = "".obs;
  Rx<QrScanDataModel> qrScanModel = QrScanDataModel(
    customerName: "",
    bagId: 0,
    newState: "",
  ).obs;
  RxString customerName = "".obs;
  RxInt bagId = 0.obs;
  RxString scanningKind = "".obs;
  MobileScannerController? cameraController;
  RxBool isLoading = false.obs;
  RxBool showLottieAnimationInResult = false.obs;

  // Add this to track the current view for LIFECICLE CONTOROLLER

  // Lock orientation to portrait when the page is built
  Future<void> lockOrientation() async {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }

  // // Unlock orientation when leaving   the page
  Future<void> resetOrientation() async {
    final liefCycleController = Get.find<LifecycleController>();
    liefCycleController.exitQrScanView();
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

  Future<void> sendToServerSide(
      String qrCodeData) async {
    isLoading.value = true; // Show loading indicator
    try {
      // if (snapshot.data == ConnectivityResult.none) {
      //   // Show an error message if there is no internet connection
      //   CustomToast.errorToast("No Internet",
      //       "Please check your internet connection and try again.");
      //   isLoading.value = false; // Hide loading indicator
      //   return; // Exit the method
      // } else {
      //DELETE FUTURE DELAYED WHEN U LINK WITH API

      print('code.value,: ${code.value}');
      final response = await $.getQrScan(
        code.value,
      );
      if (response != null) {
        print("zzzzzzzzz");
        isScanCompleted.value = false;
        qrScanModel.value = QrScanDataModel.fromJson(response["data"]);
        print(response);
        Get.toNamed(Routes.QR_RESULT);
      }

      isLoading.value = false;
      // }
    } catch (e) {
      isScanCompleted.value = false;
      isLoading.value = false;
      CustomToast.errorToast("Error", "Error because : ${e.toString()}");
    } finally {
      isLoading.value = false;
    }
  }

  void onDetectBarcode(
      String qrData) {
    if (!isScanCompleted.value && !isLoading.value) {
      code.value = qrData;

      // Make POST request with scanned QR data

      sendToServerSide(qrData);
    }
  }

  // Method to handle the case when there is no internet
  void handleNoInternet(String qrCodeData) {
    // Cache the scanned code
    code.value = qrCodeData;

    // Print the cached code
    print("Cached QR Code: ${code.value}");

    // Show error message to the user
    CustomToast.errorToast(
        "No Internet", "Please check your internet connection and try again.");
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

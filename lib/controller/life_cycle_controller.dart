import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tracking_system_app/modules/qr_scan/controller/qr_scan_controller.dart';

class LifecycleController extends GetxController with WidgetsBindingObserver {
  RxBool isInQrScanView = false.obs;

  void enterQrScanView() {
    isInQrScanView.value = true;
  }

  void exitQrScanView() {
    isInQrScanView.value = false;
  }

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void onClose() {
    WidgetsBinding.instance.removeObserver(this);
    super.onClose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      // Check if the user is in the QRScanView before turning off the flash
      if (isInQrScanView.value) {
        final qrScanController = Get.put(QrScanController());
        qrScanController.isFlashOn.value = false;
        print(
            "App in background, QR scanner is active, turning off the flash.");
      }
      print("app in background");
    } else if (state == AppLifecycleState.resumed) {
      if (isInQrScanView.value) {
        final qrScanController = Get.put(QrScanController());
        qrScanController.isFlashOn.value = false;
        print("App resumed, QR scanner is active, turning off the flash.");
      }
      // You can handle what should happen when the app is resumed, if needed
      print("App resumed");
    }
  }

}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tracking_system_app/modules/qr_scan/controller/qr_scan_controller.dart';

class LifecycleController extends GetxController with WidgetsBindingObserver {
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
      // App is in background
      final qrScanController = Get.put(QrScanController());
      qrScanController.isFlashOn.value = false;
      print("App in background");
    } else if (state == AppLifecycleState.resumed) {
      final qrScanController = Get.put(QrScanController());
      qrScanController.isFlashOn.value = false;

      // App is in foreground
      print("App resumed");
    }
  }
}

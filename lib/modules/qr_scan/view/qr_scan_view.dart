import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qr_scanner_overlay/qr_scanner_overlay.dart';
import 'package:tracking_system_app/controller/life_cycle_controller.dart';
import 'package:tracking_system_app/modules/qr_scan/controller/qr_scan_controller.dart';
import 'package:tracking_system_app/style/app_var.dart';
import 'package:tracking_system_app/widgets/general/main_loading_widget.dart';
import 'package:tracking_system_app/widgets/qr_scann/status_types_row_widget.dart';

class QrScanView extends StatefulWidget {
  const QrScanView({
    super.key,
  });

  @override
  State<QrScanView> createState() => _QrScanViewState();
}

class _QrScanViewState extends State<QrScanView> {
  final QrScanController qrController = Get.put(QrScanController());
  @override
  void initState() {
    super.initState();
    checkConnectivity();
  }

  void checkConnectivity() async {
    var result = await Connectivity().checkConnectivity();
    log("result[0].name ${result[0].name}");
  }

  @override
  Widget build(BuildContext context) {
    final isTaplet = MediaQuery.of(context).size.width > 800 &&
        MediaQuery.of(context).size.height > 800;
    return SafeArea(
      child: StreamBuilder<ConnectivityResult>(
          stream:
              Connectivity().onConnectivityChanged.map((list) => list.first),
          builder: (context, snapshot) {
            return PopScope(
              onPopInvokedWithResult: (popDisposition, result) async {
                qrController.resetOrientation();
                await qrController.disposeCamera();
                return; // Allow the pop (back) action to happen
              },
              child: Scaffold(
                backgroundColor: const Color(0xffDEFEEF),
                appBar: _buildAppBar(qrController),
                body: snapshot.data == ConnectivityResult.none
                    ? _noInternetWidget()
                    : _buildScannerBody(isTaplet),
              ),
            );
          }),
    );
  }

  Widget _buildScannerBody(bool isTablet) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const Expanded(
            child: Center(
              child: Text(
                "Scan QR here:",
                style: TextStyle(color: Colors.black54, fontSize: 16),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            flex: 2,
            child: Stack(
              children: [
                GestureDetector(
                  onTap: qrController.retryScanner,
                  child: MobileScanner(
                    controller: qrController.cameraController,
                    onDetect: _onDetectBarcode,
                    errorBuilder: _buildErrorWidget,
                  ),
                ),
                _buildScannerOverlay(),
                _buildLoadingOverlay(),
              ],
            ),
          ),
          const Spacer(),
          StatusTypesRowWidget(qrController: qrController, isTaplet: isTablet),
        ],
      ),
    );
  }

  void _onDetectBarcode(BarcodeCapture barcodeCapture) {
    final barcodes = barcodeCapture.barcodes;
    if (barcodes.isNotEmpty) {
      for (final barcode in barcodes) {
        if (barcode.rawValue != null) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            qrController.onDetectBarcode(barcode.rawValue!);

            // : (BarcodeCapture capture) {
            //     if (!qrController
            //         .isScanCompleted.value) {
            //       qrController.isScanCompleted.value =
            //           true;
            //       String code = capture.barcodes
            //               .firstWhereOrNull(
            //                   (barcode) =>
            //                       barcode != null)
            //               ?.rawValue ??
            //           "";
            //       print("code11111: $code");
            //       Get.toNamed(Routes.QR_RESULT);
            //     }
            //   },
          });
          break;
        }
      }
    }
  }

  AppBar _buildAppBar(QrScanController qrController) {
    return AppBar(
      backgroundColor: Colors.transparent,
      leading: IconButton(
        onPressed: () async {
          // Stop the camera and dispose of the controller manually
          //NOTE: U will put this line before go to any page from the home page

          await qrController.disposeCamera();
          final lifeCycleController = Get.find<LifecycleController>();
          lifeCycleController.exitQrScanView();
          Get.back();
        },
        icon: Icon(Icons.arrow_back_ios_new, color: AppVar.primary),
      ),
      actions: [
        Obx(() {
          return Padding(
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
          );
        }),
      ],
    );
  }

  Widget _noInternetWidget() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image(
            image: AssetImage("assets/images/no-internet.png"),
            width: 150,
            height: 150,
          ),
          SizedBox(height: 10),
          Text(
            "Connect to Internet and try again",
            style: TextStyle(
              color: Colors.black54,
              fontSize: 16,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildLoadingOverlay() {
    return Obx(() {
      if (qrController.isLoading.value) {
        return Container(
          color: Colors.black.withOpacity(0.6),
          child: const Center(
            child: MainLoadingWidget(),
          ),
        );
      }
      return const SizedBox.shrink();
    });
  }
}

Widget _buildErrorWidget(
    BuildContext context, MobileScannerException error, Widget? child) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.error_outline, color: Colors.red, size: 80),
        const SizedBox(height: 10),
        Text(
          'An error occurred: ${error.errorDetails?.details ?? error.toString()}',
          style: const TextStyle(
              color: Colors.red, fontSize: 18, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}

Widget _buildScannerOverlay() {
  return QRScannerOverlay(
    overlayColor: Colors.black26,
    borderColor: const Color(0xff3AD189),
    borderRadius: 22,
    borderStrokeWidth: 5,
    scanAreaWidth: 250,
    scanAreaHeight: 250,
  );
}

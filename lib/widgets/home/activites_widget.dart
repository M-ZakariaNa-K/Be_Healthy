import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tracking_system_app/controller/life_cycle_controller.dart';
import 'package:tracking_system_app/modules/home/controller/home_controller.dart';
import 'package:tracking_system_app/modules/qr_scan/controller/qr_scan_controller.dart';
import 'package:tracking_system_app/routes/app_pages.dart';
import 'package:tracking_system_app/style/app_var.dart';
import 'package:tracking_system_app/widgets/home/custom_activites_widget.dart';
import 'package:tracking_system_app/widgets/home/note_widget.dart';

class ActivitesWidget extends StatelessWidget {
  const ActivitesWidget({
    super.key,
    required this.homeController,
  });
  final HomeController homeController;
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    // final isLandscape =
    //     MediaQuery.of(context).orientation == Orientation.landscape;
    final isTaplet = MediaQuery.of(context).size.width > 800;
    final dataFontSize =
        screenWidth * (0.066); // Smaller font size in landscape
    return Center(
      child: Container(
        padding:
            EdgeInsets.symmetric(vertical: 20, horizontal: isTaplet ? 40 : 20),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(60),
            topRight: Radius.circular(60),
          ),
          color: AppVar.background,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //==============Activites====================
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Text(
                "Activities",
                style: TextStyle(
                  fontSize: isTaplet ? dataFontSize - 20 : dataFontSize,
                  color: AppVar.textColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CustomActivitiesCardWidget(
                  width: isTaplet ? 200 : null,
                  height: isTaplet ? 300 : null,
                  imageName: "assets/images/boxes (1).png",
                  label: "Check In",
                  onTap: () {
                    final qrScanController = Get.put(QrScanController());
                    qrScanController.scanningKind.value = "check_in";
                    // Lock orientation to portrait when the QRScan view is initialized
                    qrScanController.lockOrientation();
                    // -===============U can see why i put this command in LifeCycleController.===========
                    final liefCycleController = Get.find<LifecycleController>();
                    liefCycleController.enterQrScanView();

                    Get.toNamed(Routes.QR_SCANN);
                  },
                  homeController: homeController,
                  index: 0,
                ),
                CustomActivitiesCardWidget(
                  width: isTaplet ? 200 : null,
                  height: isTaplet ? 300 : null,
                  imageName: "assets/images/scooter.png",
                  label: "Delivered",
                  onTap: () {
                    final qrScanController = Get.put(QrScanController());
                    qrScanController.scanningKind.value = "delivered";
                    qrScanController.lockOrientation();
                              final liefCycleController = Get.find<LifecycleController>();
                    liefCycleController.enterQrScanView();

                    Get.toNamed(Routes.QR_SCANN);
                  },
                  homeController: homeController,
                  index: 1,
                ),
                CustomActivitiesCardWidget(
                  width: isTaplet ? 200 : null,
                  height: isTaplet ? 300 : null,
                  imageName: "assets/images/Character (1).png",
                  label: "Check Out",
                  onTap: () {
                    final qrScanController = Get.put(QrScanController());
                    qrScanController.scanningKind.value = "check_out";
                    qrScanController.lockOrientation();
                    final liefCycleController = Get.find<LifecycleController>();
                    liefCycleController.enterQrScanView();

                    Get.toNamed(Routes.QR_SCANN);
                  },
                  homeController: homeController,
                  index: 2,
                ),
              ],
            ),
            //==============Notes:====================
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20.0),
              child: Text(
                "Explanations",
                style: TextStyle(
                  fontSize: isTaplet ? dataFontSize - 20 : dataFontSize,
                  color: AppVar.textColor,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            //----------------------
            const NoteWidget(
              title: "Check In: ",
              content: "The bag entered the warehous",
            ),
            Divider(
              thickness: 2,
              color: AppVar.secondary,
            ),
            //----------------------
            const NoteWidget(
              title: "Delivered: ",
              content: "The bag arrived to the client",
            ),
            Divider(
              thickness: 2,
              color: AppVar.secondary,
            ),
            //----------------------
            const NoteWidget(
              title: "Check Out: ",
              content: "The bag leave the warehous",
            ),
            //----------------------
          ],
        ),
      ),
    );
  }
}

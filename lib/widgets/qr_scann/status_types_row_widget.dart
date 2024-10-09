
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tracking_system_app/modules/qr_scan/controller/qr_scan_controller.dart';
import 'package:tracking_system_app/style/app_var.dart';

class StatusTypesRowWidget extends StatelessWidget {
  const StatusTypesRowWidget({
    super.key,
    required this.qrController,
    required this.isTaplet,
  });

  final QrScanController qrController;
  final bool isTaplet;

  @override
  Widget build(BuildContext context) {
    return Container(
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
            Container(
              padding: const EdgeInsets.symmetric(
                  vertical: 10, horizontal: 20),
              decoration: BoxDecoration(
                borderRadius:
                    qrController.scanningKind.value ==
                            "check_in"
                        ? BorderRadius.circular(13)
                        : null,
                color:
                    qrController.scanningKind.value ==
                            "check_in"
                        ? AppVar.primary
                        : Colors.transparent,
              ),
              child: Text(
                "Check In  ",
                style: TextStyle(
                  color:
                      qrController.scanningKind.value ==
                              "check_in"
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
                border: qrController
                                .scanningKind.value !=
                            "delivered" &&
                        qrController
                                .scanningKind.value ==
                            "check_out"
                    ? const Border(
                        left: BorderSide(
                          width: 1,
                        ),
                      )
                    : qrController.scanningKind.value !=
                                "delivered" &&
                            qrController.scanningKind
                                    .value ==
                                "check_in"
                        ? const Border(
                            right: BorderSide(
                              width: 1,
                            ),
                          )
                        : null,
                borderRadius: qrController
                            .scanningKind.value ==
                        "delivered"
                    ? BorderRadius.circular(15)
                    : qrController.scanningKind.value ==
                            "check_in"
                        ? const BorderRadius.only(
                            topRight:
                                Radius.circular(15),
                            bottomRight:
                                Radius.circular(15),
                          )
                        : const BorderRadius.only(
                            topLeft:
                                Radius.circular(15),
                            bottomLeft:
                                Radius.circular(15),
                          ),
                color:
                    qrController.scanningKind.value ==
                            "delivered"
                        ? AppVar.primary
                        : Colors.transparent,
              ),
              child: Text(
                "Delivered",
                style: TextStyle(
                  color:
                      qrController.scanningKind.value ==
                              "delivered"
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
                    qrController.scanningKind.value ==
                            "check_out"
                        ? BorderRadius.circular(13)
                        : null,
                color:
                    qrController.scanningKind.value ==
                            "check_out"
                        ? AppVar.primary
                        : Colors.transparent,
              ),
              child: Text(
                "Check Out",
                style: TextStyle(
                  color:
                      qrController.scanningKind.value ==
                              "check_out"
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
    );
  }
}
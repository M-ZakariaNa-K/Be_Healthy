import 'package:get/get.dart';
import 'package:tracking_system_app/modules/qr_scan/controller/qr_scan_controller.dart';

class QrScanBinding extends Bindings {
  @override
  void dependencies() {
    // Lazy load HomeController only when HomeView is accessed
    //IT's verrrrryyyyyyyyyyy important to be the permanent :true, cause if u close the controller of this camera, u will have an exception
    //and u will not be able to fix the problem untel u rebuild the app code
    Get.put<QrScanController>(QrScanController(), permanent: true);
    // Get.lazyPut<QrScanController>(() => QrScanController());
  }
}

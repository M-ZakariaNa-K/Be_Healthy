import 'package:get/get.dart';
import 'package:tracking_system_app/modules/qr_result/controller/qr_result_controller.dart';
class QrResultBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<QrResultCntroller>(
      QrResultCntroller()
    ,permanent: true);
  }
}

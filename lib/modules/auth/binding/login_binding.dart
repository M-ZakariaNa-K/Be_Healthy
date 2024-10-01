import 'package:get/get.dart';
import 'package:tracking_system_app/modules/auth/controller/login_controller.dart';
class LoginBinding extends Bindings {
  @override
  void dependencies() {
  Get.lazyPut<LoginController>(
      () => LoginController(),
    );}
}

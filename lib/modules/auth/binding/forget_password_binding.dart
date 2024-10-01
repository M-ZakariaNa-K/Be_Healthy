import 'package:get/get.dart';
import 'package:tracking_system_app/modules/auth/controller/forget_password_controller.dart';

class ForgetPasswordBinding extends Bindings {
  @override
  void dependencies() {
Get.lazyPut<ForgetPasswordController>(
      () => ForgetPasswordController(),
    );
  }
}

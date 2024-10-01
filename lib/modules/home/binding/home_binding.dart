import 'package:get/get.dart';
import 'package:tracking_system_app/modules/home/controller/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    // Lazy load HomeController only when HomeView is accessed
    Get.lazyPut<HomeController>(() => HomeController());
  }
}

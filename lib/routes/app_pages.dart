import 'package:get/get.dart';
import 'package:tracking_system_app/modules/auth/binding/forget_password_binding.dart';
import 'package:tracking_system_app/modules/auth/binding/login_binding.dart';
import 'package:tracking_system_app/modules/auth/binding/register_binding.dart';
import 'package:tracking_system_app/modules/auth/view/forget_password_view.dart';
import 'package:tracking_system_app/modules/auth/view/login_view.dart';
import 'package:tracking_system_app/modules/auth/view/regester_view.dart';
import 'package:tracking_system_app/modules/home/binding/home_binding.dart';
import 'package:tracking_system_app/modules/home/view/home_view.dart';
import 'package:tracking_system_app/modules/qr_result/binding/qr_result_binding.dart';
import 'package:tracking_system_app/modules/qr_result/view/qr_result_view.dart';
import 'package:tracking_system_app/modules/qr_scan/binding/qr_scan_binding.dart';
import 'package:tracking_system_app/modules/qr_scan/view/qr_scan_view.dart';
import 'package:tracking_system_app/modules/splash/splash_screen.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => const RegesterView(),
      binding: RegisterBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.FORGOT_PASSWORD,
      page: () => ForgetPasswordView(),
      binding: ForgetPasswordBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.QR_RESULT,
      page: () => QRResultPage(),
      binding: QrResultBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.QR_SCANN,
      page: () => QrScanView(),
      binding: QrScanBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(name: _Paths.SPLASH_SCREEN, page: () => const SplashScreen()),
  ];
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tracking_system_app/controller/life_cycle_controller.dart';
import 'package:tracking_system_app/network_util.dart';
import 'package:tracking_system_app/routes/app_pages.dart';
import 'package:tracking_system_app/shared/shared.dart';
import 'package:tracking_system_app/style/app_var.dart';

void main() async {
  //its important to put this command for sharedprefernces initialize
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences _pref = await SharedPreferences.getInstance();
  sharedLoginToken = _pref.getString('token');
  if (sharedLoginToken != null) {
    $.token1 = sharedLoginToken;
    $.role = _pref.getString('role');
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize the LifecycleController using Get.put
    Get.put(LifecycleController());
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Traking System',
      theme: AppVar.lightTheme,
      darkTheme: AppVar.darkTheme,
      themeMode: ThemeMode.system,
      initialRoute: sharedLoginToken != null
          ? Routes.HOME
          : Routes
              .SPLASH_SCREEN, // This should match the constant for the home route
      getPages: AppPages.routes,
    );
  }
}

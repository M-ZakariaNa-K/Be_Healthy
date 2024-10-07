import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tracking_system_app/controller/life_cycle_controller.dart';
import 'package:tracking_system_app/routes/app_pages.dart';
import 'package:tracking_system_app/style/app_var.dart';

void main() {
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
      // home: SplashScreen(),
      initialRoute:
          Routes.LOGIN, // This should match the constant for the home route
      getPages: AppPages.routes,
    );
  }
}

// class QRResultPage extends StatelessWidget {
//   final String code;
//   final Function() closeScreen;
//   const QRResultPage({super.key, required this.code, required this.closeScreen});

//   @override
//   Widget build(BuildContext context) {
//     //PopScop:  to  make the QR result ready for scanning again when pressed the defult back button in the mobile
//     return PopScope(
//       onPopInvokedWithResult: (popDisposition, result) {
//         closeScreen(); // Call closeScreen when back button is pressed
//         return; // Allow the pop (back) action to happen
//       },
//       // onWillPop: () async {
//       //   closeScreen(); // Call closeScreen when back button is pressed
//       //   return true; // Allow the back action to happen
//       // },
//       child: Scaffold(
//         appBar: AppBar(
//           leading: IconButton(
//               onPressed: () {
//                 closeScreen();
//                 Get.back();
//               },
//               icon: const Icon(Icons.arrow_back)),
//         ),
//         body: Padding(
//           padding: const EdgeInsets.all(60),
//           child: Column(
//             children: [
//               QrImageView(
//                 data: "",
//                 size: 300,
//                 version: QrVersions.auto,
//               ),
//               const Text(
//                 "Scanned QR",
//                 style: TextStyle(
//                   color: Colors.black,
//                   fontSize: 25,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               const SizedBox(
//                 height: 10,
//               ),
//               Text(
//                 code,
//                 textAlign: TextAlign.center,
//               ),
//               const SizedBox(
//                 height: 20,
//               ),
//               SizedBox(
//                 height: 60,
//                 width: MediaQuery.sizeOf(context).width - 150,
//                 child: ElevatedButton(
//                     onPressed: () {
//                       Clipboard.setData(ClipboardData(text: code));
//                     },
//                     child: const Text("Copy")),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

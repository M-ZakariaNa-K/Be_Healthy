// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:lottie/lottie.dart';
// import 'package:tracking_system_app/modules/auth/controller/forget_password_controller.dart';
// import 'package:tracking_system_app/style/app_var.dart';
// import 'package:tracking_system_app/widgets/auth/login-defult_button.dart';
// import '../../../widgets/auth/costume_login_TextField_widget.dart';

// class ForgetPasswordView extends GetView<ForgetPasswordController> {
//   ForgetPasswordView({super.key});
//   final forgetPasswordController =
//       Get.put(ForgetPasswordController(), permanent: false);

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         appBar: AppBar(
//           backgroundColor: Colors.transparent,
//           leading: IconButton(
//             icon: Icon(Icons.arrow_back_ios_new,
//                 color:
//                     MediaQuery.of(context).orientation == Orientation.landscape
//                         ? AppVar.background
//                         : AppVar.primary),
//             onPressed: () {
//               Get.back();
//             },
//           ),
//         ),
//         backgroundColor:
//             MediaQuery.of(context).orientation == Orientation.landscape
//                 ? AppVar.primary
//                 : AppVar.background,
//         body: OrientationBuilder(
//           builder: (context, orientation) {
//             if (orientation == Orientation.landscape) {
//               return ListView(
//                 children: [
//                   Obx(() {
//                     if (controller.isWaitAdminApproved.value) {
//                       return Positioned(
//                         bottom: MediaQuery.sizeOf(context).height * 0.15,
//                         right: 0,
//                         left: 0,
//                         child: Column(
//                           children: [
//                             Center(
//                               child: LottieBuilder.asset(
//                                 "assets/Lottie/Animation - 1726871315481.json",
//                                 width: 200,
//                                 height: 200,
//                                 repeat: false,
//                                 fit: BoxFit.fill,
//                               ),
//                             ),
//                             const SizedBox(height: 20),
//                             const Text(
//                               "Done!",
//                               style: TextStyle(
//                                 color: Color(0xff1CB26B),
//                                 fontSize: 30,
//                               ),
//                               textAlign: TextAlign.center,
//                             ),
//                             Container(
//                               margin: const EdgeInsets.symmetric(vertical: 20),
//                               padding: const EdgeInsets.symmetric(
//                                   vertical: 5, horizontal: 15),
//                               decoration: BoxDecoration(
//                                 border: Border.all(
//                                   width: 1,
//                                   color: const Color(0xff1CB26B),
//                                 ),
//                                 borderRadius: BorderRadius.circular(10),
//                               ),
//                               child: const Text(
//                                 "Waiting for admin approval",
//                                 style: TextStyle(
//                                   color: AppVar.seconndTextColor,
//                                   fontSize: 16,
//                                 ),
//                                 textAlign: TextAlign.center,
//                               ),
//                             ),
//                           ],
//                         ),
//                       );
//                     } else {
//                       return Container(); // Return an empty container when not showing the Lottie animation
//                     }
//                   }),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 40.0),
//                     child: Column(children: [
//                       Padding(
//                         padding: const EdgeInsets.symmetric(vertical: 20.0),
//                         child: Center(
//                           child: ClipRRect(
//                             borderRadius: BorderRadius.circular(100),
//                             child: SizedBox(
//                               width: 200,
//                               height: 200,
//                               child: Image.asset(
//                                 "assets/images/Logo1.png",
//                                 fit: BoxFit.fill,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                       SizedBox(
//                           // height: constraints.maxHeight * 0.14,
//                           ),
//                       Obx(
//                         () => Opacity(
//                           opacity: controller.isWaitAdminApproved.value ? 0 : 1,
//                           child: Form(
//                             key: forgetPasswordController.formKey,
//                             child: Stack(
//                               alignment: Alignment.topCenter,
//                               children: [
//                                 //1======================
//                                 Container(
//                                   margin:
//                                       const EdgeInsets.symmetric(vertical: 40),
//                                   padding: const EdgeInsets.symmetric(
//                                       vertical: 20, horizontal: 20),
//                                   decoration: BoxDecoration(
//                                     border: Border.all(
//                                         width: 1, color: AppVar.background),
//                                     borderRadius: BorderRadius.circular(20),
//                                   ),
//                                   child: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       //1
//                                       CustomeLoginTextFormField(
//                                         isFilledTextFild: false,
//                                         filledTextFildData: "",
//                                         prefixIcon: null,
//                                         inputType: TextInputType.text,
//                                         hintText: 'Full Name',
//                                         title: 'Full Name',
//                                         controller:
//                                             controller.fullNameController,
//                                         validator: null,
//                                       ),
//                                       CustomeLoginTextFormField(
//                                         isFilledTextFild: false,
//                                         filledTextFildData: "",
//                                         prefixIcon: null,
//                                         inputType: TextInputType.text,
//                                         hintText: 'Employee ID',
//                                         title: 'Employee ID',
//                                         controller:
//                                             controller.jobNumberController,
//                                         validator: null,
//                                       ),
//                                       CustomeLoginTextFormField(
//                                         prefixIcon: null,
//                                         inputType: TextInputType.text,
//                                         hintText: 'New Password',
//                                         title: 'Password',
//                                         controller:
//                                             controller.passwordController,
//                                         validator: null,
//                                         isFilledTextFild: false,
//                                         filledTextFildData: "",
//                                       ),
//                                       CustomeLoginTextFormField(
//                                         prefixIcon: null,
//                                         inputType: TextInputType.text,
//                                         hintText: 'Confirm New Password',
//                                         title: 'Password',
//                                         controller: controller
//                                             .confirmPasswordController,
//                                         validator: null,
//                                         isFilledTextFild: false,
//                                         filledTextFildData: "",
//                                       ),
//                                       const SizedBox(
//                                         height: 30,
//                                       ),
//                                       //4
//                                       Center(
//                                         child: SizedBox(
//                                           width: 150,
//                                           child: LoginDefultButton(
//                                             fontsize: AppVar.littelFontSize,
//                                             buttonColor:
//                                                 const Color(0xff1CB26B),
//                                             borderColor: Colors.transparent,
//                                             textColor: AppVar.seconndTextColor,
//                                             title: "Send to admin",
//                                             onPressed: () {
//                                               if (controller
//                                                   .formKey.currentState!
//                                                   .validate()) {
//                                                 controller.validateForm();
//                                               }
//                                             },
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 //2======================
//                                 Positioned(
//                                   top: 25,
//                                   child: Container(
//                                       padding: const EdgeInsets.symmetric(
//                                           vertical: 5, horizontal: 15),
//                                       decoration: BoxDecoration(
//                                         border: Border.all(
//                                             width: 1, color: AppVar.background),
//                                         borderRadius: BorderRadius.circular(20),
//                                         color: AppVar.primary,
//                                       ),
//                                       child: const Text(
//                                         "Forget Password",
//                                         style: TextStyle(
//                                           color: AppVar.seconndTextColor,
//                                         ),
//                                       )),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                     ]),
//                   )
//                 ],
//               );
//             } else {
//               return SingleChildScrollView(
//                 child: Stack(
//                   children: [
//                     // Rotated border container behind the image
//                     // Positioned(
//                     //   top: 270,
//                     //   right: constraints.maxWidth *
//                     //       0.1, // Adjust based on screen size
//                     //   child: Transform.rotate(
//                     //     angle: 0.47,
//                     //     child: Container(
//                     //       width: constraints.maxWidth *
//                     //           1.5, // Adjust based on screen size
//                     //       height: constraints.maxHeight *
//                     //           1.2, // Adjust based on screen size
//                     //       decoration: BoxDecoration(
//                     //         boxShadow: const [
//                     //           BoxShadow(
//                     //             color: Color(0xffD1D2D2),
//                     //             spreadRadius: 0.0,
//                     //             blurRadius: 0.0,
//                     //             offset: Offset(-8.0, -8.0),
//                     //           ),
//                     //         ],
//                     //         color: AppVar.primary, // Border color
//                     //         borderRadius: BorderRadius.circular(
//                     //             60), // Rounded border corners
//                     //       ),
//                     //     ),
//                     //   ),
//                     // ),
//                     SizedBox(
//                       width: double.infinity,
//                       height: MediaQuery.sizeOf(context).width + 20,
//                       child: Image.asset(
//                         'assets/images/Rectingle.jpg',
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                     // Using Obx to observe the isWaitAdminApproved state
//                     Obx(() {
//                       if (controller.isWaitAdminApproved.value) {
//                         return Positioned(
//                           bottom: MediaQuery.sizeOf(context).height * 0.15,
//                           right: 0,
//                           left: 0,
//                           child: Column(
//                             children: [
//                               Center(
//                                 child: LottieBuilder.asset(
//                                   "assets/Lottie/Animation - 1726871315481.json",
//                                   width: 200,
//                                   height: 200,
//                                   repeat: false,
//                                   fit: BoxFit.fill,
//                                 ),
//                               ),
//                               const SizedBox(height: 20),
//                               const Text(
//                                 "Done!",
//                                 style: TextStyle(
//                                   color: Color(0xff1CB26B),
//                                   fontSize: 30,
//                                 ),
//                                 textAlign: TextAlign.center,
//                               ),
//                               Container(
//                                 margin:
//                                     const EdgeInsets.symmetric(vertical: 20),
//                                 padding: const EdgeInsets.symmetric(
//                                     vertical: 5, horizontal: 15),
//                                 decoration: BoxDecoration(
//                                   border: Border.all(
//                                     width: 1,
//                                     color: const Color(0xff1CB26B),
//                                   ),
//                                   borderRadius: BorderRadius.circular(10),
//                                 ),
//                                 child: const Text(
//                                   "Waiting for admin approval",
//                                   style: TextStyle(
//                                     color: AppVar.seconndTextColor,
//                                     fontSize: 16,
//                                   ),
//                                   textAlign: TextAlign.center,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         );
//                       } else {
//                         return Container(); // Return an empty container when not showing the Lottie animation
//                       }
//                     }),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 40.0),
//                       child: Column(
//                         children: [
//                           Padding(
//                             padding: const EdgeInsets.symmetric(vertical: 20.0),
//                             child: Center(
//                               child: ClipRRect(
//                                 borderRadius: BorderRadius.circular(100),
//                                 child: SizedBox(
//                                   width: 200,
//                                   height: 200,
//                                   child: Image.asset(
//                                     "assets/images/Logo1.png",
//                                     fit: BoxFit.fill,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                           SizedBox(
//                               // height: constraints.maxHeight * 0.14,
//                               ),
//                           Obx(
//                             () => Opacity(
//                               opacity:
//                                   controller.isWaitAdminApproved.value ? 0 : 1,
//                               child: Form(
//                                 key: forgetPasswordController.formKey,
//                                 child: Stack(
//                                   alignment: Alignment.topCenter,
//                                   children: [
//                                     //1======================
//                                     Container(
//                                       margin: const EdgeInsets.symmetric(
//                                           vertical: 40),
//                                       padding: const EdgeInsets.symmetric(
//                                           vertical: 20, horizontal: 20),
//                                       decoration: BoxDecoration(
//                                         border: Border.all(
//                                             width: 1, color: AppVar.background),
//                                         borderRadius: BorderRadius.circular(20),
//                                       ),
//                                       child: Column(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         children: [
//                                           //1
//                                           CustomeLoginTextFormField(
//                                             isFilledTextFild: false,
//                                             filledTextFildData: "",
//                                             prefixIcon: null,
//                                             inputType: TextInputType.text,
//                                             hintText: 'Full Name',
//                                             title: 'Full Name',
//                                             controller:
//                                                 controller.fullNameController,
//                                             validator: null,
//                                           ),
//                                           CustomeLoginTextFormField(
//                                             isFilledTextFild: false,
//                                             filledTextFildData: "",
//                                             prefixIcon: null,
//                                             inputType: TextInputType.text,
//                                             hintText: 'Employee ID',
//                                             title: 'Employee ID',
//                                             controller:
//                                                 controller.jobNumberController,
//                                             validator: null,
//                                           ),
//                                           CustomeLoginTextFormField(
//                                             prefixIcon: null,
//                                             inputType: TextInputType.text,
//                                             hintText: 'New Password',
//                                             title: 'Password',
//                                             controller:
//                                                 controller.passwordController,
//                                             validator: null,
//                                             isFilledTextFild: false,
//                                             filledTextFildData: "",
//                                           ),
//                                           CustomeLoginTextFormField(
//                                             prefixIcon: null,
//                                             inputType: TextInputType.text,
//                                             hintText: 'Confirm New Password',
//                                             title: 'Password',
//                                             controller: controller
//                                                 .confirmPasswordController,
//                                             validator: null,
//                                             isFilledTextFild: false,
//                                             filledTextFildData: "",
//                                           ),
//                                           const SizedBox(
//                                             height: 30,
//                                           ),
//                                           //4
//                                           Center(
//                                             child: SizedBox(
//                                               width: 150,
//                                               child: LoginDefultButton(
//                                                 fontsize: AppVar.littelFontSize,
//                                                 buttonColor:
//                                                     const Color(0xff1CB26B),
//                                                 borderColor: Colors.transparent,
//                                                 textColor:
//                                                     AppVar.seconndTextColor,
//                                                 title: "Send to admin",
//                                                 onPressed: () {
//                                                   if (controller
//                                                       .formKey.currentState!
//                                                       .validate()) {
//                                                     controller.validateForm();
//                                                   }
//                                                 },
//                                               ),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                     //2======================
//                                     Positioned(
//                                       top: 25,
//                                       child: Container(
//                                           padding: const EdgeInsets.symmetric(
//                                               vertical: 5, horizontal: 15),
//                                           decoration: BoxDecoration(
//                                             border: Border.all(
//                                                 width: 1,
//                                                 color: AppVar.background),
//                                             borderRadius:
//                                                 BorderRadius.circular(20),
//                                             color: AppVar.primary,
//                                           ),
//                                           child: const Text(
//                                             "Forget Password",
//                                             style: TextStyle(
//                                               color: AppVar.seconndTextColor,
//                                             ),
//                                           )),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               );
//             }
//           },
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:tracking_system_app/modules/auth/view/forget_password_screen_mobile_layout.dart';
import 'package:tracking_system_app/modules/auth/view/forget_password_screen_tablet_layout.dart';
// ignore: must_be_immutable
class ForgetPasswordView extends StatelessWidget {
  const ForgetPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);

    final horizontalPadding = mediaQueryData.size.width;

    return LayoutBuilder(builder: (context, constraints) {
      if (horizontalPadding <= 850) {
        return ForgetPasswordScreenMobileLayout(context);
      } else {
        return ForgetPasswordScreenTapletLayout(context);
        // return TabletLayoutLoginScreen(context);
      }
    });
  }
}

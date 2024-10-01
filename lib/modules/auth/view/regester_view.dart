// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:lottie/lottie.dart';
// import 'package:tracking_system_app/controller/radio_controller.dart';
// import 'package:tracking_system_app/modules/auth/controller/register_controller.dart';
// import 'package:tracking_system_app/style/app_var.dart';
// import 'package:tracking_system_app/widgets/auth/costume_login_TextField_widget.dart';
// import 'package:tracking_system_app/widgets/auth/login-defult_button.dart';

// import '../../../routes/app_pages.dart';

// class RegisterView extends GetView<RegisterController> {
//   const RegisterView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final registerController = Get.put(RegisterController(), permanent: false);

//     return SafeArea(
//       child: Scaffold(
//         backgroundColor:
//             MediaQuery.of(context).orientation == Orientation.landscape
//                 ? AppVar.primary
//                 : AppVar.background,
//         body: LayoutBuilder(
//           builder: (context, constraints) {
//             final screenWidth = constraints.maxWidth;
//             final screenHeight = constraints.maxHeight;
//             final isTablet = screenWidth > 600; // Breakpoint for tablet
//             final isLandscape =
//                 MediaQuery.of(context).orientation == Orientation.landscape;

//             return SingleChildScrollView(
//               child: ConstrainedBox(
//                 constraints: BoxConstraints(
//                   minHeight: screenHeight,
//                 ),
//                 child: Stack(
//                   children: [
//                     // Background Image
//                     Positioned(
//                       bottom: 0,
//                       left: 0,
//                       right: 0,
//                       child: Padding(
//                         padding: EdgeInsets.only(top: 0
//                             // screenHeight > 1000
//                             //     ? screenHeight * 0.0
//                             //     : screenWidth > 1000
//                             //         ? screenHeight * 0.30
//                             //         : screenHeight * 0.25,
//                             ), // Adjust padding based on screen size
//                         child: SizedBox(
//                           width: double.infinity,
//                           height: screenHeight > 800 && screenWidth > 500
//                               ? screenHeight
//                               : screenWidth > 800
//                                   ? 30
//                                   : screenHeight * 0.8,
//                           child: Image.asset(
//                             'assets/images/Rectingle.jpg',
//                             fit: BoxFit.cover,
//                           ),
//                         ),
//                       ),
//                     ),
//                     // Waiting for admin approval (Lottie Animation)
//                     Obx(() {
//                       if (controller.isWaitAdminApproved.value) {
//                         return Positioned(
//                           bottom: MediaQuery.sizeOf(context).height * 0.25,
//                           right: 0,
//                           left: 0,
//                           child: Column(
//                             children: [
//                               Center(
//                                 child: LottieBuilder.asset(
//                                   repeat: false,
//                                   "assets/Lottie/Animation - 1726871315481.json",
//                                   width: 200,
//                                   height: 200,
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
//                         return Container();
//                       }
//                     }),
//                     Padding(
//                       padding: EdgeInsets.symmetric(
//                         horizontal: isTablet
//                             ? 60.0
//                             : 40.0, // Adjust padding for tablets
//                       ),
//                       child: Column(
//                         children: [
//                           Padding(
//                             padding: const EdgeInsets.only(bottom: 40.0),
//                             child: Center(
//                               child: ClipRRect(
//                                 borderRadius: BorderRadius.circular(
//                                   1000,
//                                 ), // Circle Image
//                                 child: SizedBox(
//                                   width: isTablet
//                                       ? 300
//                                       : 200, // Adjust size for tablets
//                                   height: isTablet ? 300 : 200,
//                                   child: Image.asset(
//                                     MediaQuery.of(context).orientation ==
//                                             Orientation.landscape
//                                         ? "assets/images/Logo.png"
//                                         : "assets/images/Logo1.png",
//                                     fit: BoxFit.fill,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                           Obx(
//                             () => Opacity(
//                               opacity:
//                                   controller.isWaitAdminApproved.value ? 0 : 1,
//                               child: GetBuilder<RegisterController>(
//                                 init: RegisterController(),
//                                 builder: (controller) {
//                                   return Form(
//                                     key: controller.formKey,
//                                     child: Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         const SizedBox(height: 20),
//                                         const Padding(
//                                           padding: EdgeInsets.only(
//                                               bottom: 10.0, top: 0),
//                                           child: Text(
//                                             "Sign Up",
//                                             style: TextStyle(
//                                               color: AppVar.seconndTextColor,
//                                               fontSize: 40,
//                                               shadows: [
//                                                 Shadow(
//                                                   color: Color.fromARGB(
//                                                       255, 79, 79, 79),
//                                                   offset: Offset(2, 4),
//                                                   blurRadius: 5,
//                                                 ),
//                                               ],
//                                             ),
//                                           ),
//                                         ),
//                                         const SizedBox(height: 30),
//                                         // Custom Text Fields for Full Name, Job Title, etc.
//                                         CustomeLoginTextFormField(
//                                           isFilledTextFild: false,
//                                           filledTextFildData: "",
//                                           prefixIcon: null,
//                                           inputType: TextInputType.text,
//                                           hintText: 'Full Name',
//                                           title: 'Full Name',
//                                           controller:
//                                               controller.fullNameController,
//                                           validator: null,
//                                         ),
//                                         // CustomDropdownWidget(
//                                         //   title: '',
//                                         //   hintText: 'Select Job Title',
//                                         //   items: controller.jobTitles,
//                                         //   selectedValue: controller
//                                         //           .selectedJobTitle!
//                                         //           .value
//                                         //           .isEmpty
//                                         //       ? null
//                                         //       : controller.selectedJobTitle!
//                                         //           .value, // Ensure it's null or a valid value
//                                         //   onChanged: (value) {
//                                         //     if (value != null) {
//                                         //       controller
//                                         //               .selectedJobTitle!.value =
//                                         //           value; // Update the selected job title
//                                         //     }
//                                         //   },
//                                         //   prefixIcon:
//                                         //       null, // Optional prefix icon for the dropdown
//                                         //   dropdownColor: Colors
//                                         //       .transparent, // Customize the dropdown background
//                                         //   textStyle: const TextStyle(
//                                         //       color: Colors.black,
//                                         //       fontSize:
//                                         //           16), // Customize text style
//                                         //   hintStyle: const TextStyle(
//                                         //       color: Colors
//                                         //           .grey), // Customize hint text style
//                                         // ),
//                                         const SizedBox(height: 15),
//                                         const Text(
//                                           "Job Title:",
//                                           style: TextStyle(
//                                               color: Color(0xffC9DBD3)),
//                                         ),
//                                         _buildRadioButtonGroup(
//                                             "Jop Title",
//                                             controller.jopTitleController,
//                                             context),
//                                         // CustomeLoginTextFormField(
//                                         //   isFilledTextFild: false,
//                                         //   filledTextFildData: "",
//                                         //   prefixIcon: null,
//                                         //   inputType: TextInputType.text,
//                                         //   hintText: 'Job Title',
//                                         //   title: 'Job Title',
//                                         //   controller:
//                                         //       controller.jopTitleController,
//                                         //   validator: null,
//                                         // ),
//                                         CustomeLoginTextFormField(
//                                           isFilledTextFild: false,
//                                           filledTextFildData: "",
//                                           prefixIcon: null,
//                                           inputType: TextInputType.text,
//                                           hintText: 'Job Number',
//                                           title: 'Job Number',
//                                           controller:
//                                               controller.jobNumberController,
//                                           validator: null,
//                                         ),
//                                         CustomeLoginTextFormField(
//                                           isFilledTextFild: false,
//                                           filledTextFildData: "",
//                                           hintText: 'Phone Number',
//                                           inputType: TextInputType.number,
//                                           title: 'Phone Number',
//                                           prefixIcon: Padding(
//                                             padding: const EdgeInsets.symmetric(
//                                                 horizontal: 8.0),
//                                             child: Row(
//                                               mainAxisSize: MainAxisSize.min,
//                                               children: [
//                                                 Image.asset(
//                                                   'assets/images/uae_flag.png',
//                                                   width: 24,
//                                                   height: 24,
//                                                 ),
//                                                 const SizedBox(width: 5),
//                                                 Container(
//                                                   padding: const EdgeInsets
//                                                       .symmetric(horizontal: 5),
//                                                   decoration:
//                                                       const BoxDecoration(
//                                                           border: Border(
//                                                     right: BorderSide(
//                                                       color: AppVar
//                                                           .seconndTextColor,
//                                                       width: 1.0,
//                                                     ),
//                                                   )),
//                                                   child: const Text(
//                                                     '+971',
//                                                     style: TextStyle(
//                                                       fontSize: 14,
//                                                       color: AppVar
//                                                           .seconndTextColor,
//                                                       fontWeight:
//                                                           FontWeight.bold,
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                           ),
//                                           controller:
//                                               controller.phoneNumberController,
//                                           validator: null,
//                                         ),
//                                         CustomeLoginTextFormField(
//                                           prefixIcon: null,
//                                           inputType: TextInputType.text,
//                                           hintText: 'Password',
//                                           title: 'Password',
//                                           controller:
//                                               controller.passwordController,
//                                           validator: null,
//                                           isFilledTextFild: false,
//                                           filledTextFildData: "",
//                                         ),
//                                         CustomeLoginTextFormField(
//                                           prefixIcon: null,
//                                           inputType: TextInputType.text,
//                                           hintText: 'Confirm Password',
//                                           title: 'Password',
//                                           controller: controller
//                                               .confirmPasswordController,
//                                           validator: null,
//                                           isFilledTextFild: false,
//                                           filledTextFildData: "",
//                                         ),
//                                         const SizedBox(height: 50),
//                                         // Sign Up Button
//                                         LoginDefultButton(
//                                           fontsize: isTablet
//                                               ? 20
//                                               : AppVar
//                                                   .mainFontSize, // Adjust font size for tablets
//                                           buttonColor: const Color(0xff1CB26B),
//                                           borderColor: Colors.transparent,
//                                           textColor: AppVar.seconndTextColor,
//                                           title: "SIGN UP",
//                                           onPressed: () {
//                                             if (controller.formKey.currentState!
//                                                 .validate()) {
//                                               controller.validateForm();
//                                             }
//                                           },
//                                         ),
//                                         const SizedBox(height: 10),
//                                         Padding(
//                                           padding: const EdgeInsets.only(
//                                               bottom: 10.0),
//                                           child: Center(
//                                             child: Row(
//                                               mainAxisSize: MainAxisSize.min,
//                                               children: [
//                                                 Text(
//                                                   "Already have an account? ",
//                                                   style: TextStyle(
//                                                     color:
//                                                         AppVar.seconndTextColor,
//                                                     fontSize:
//                                                         AppVar.littelFontSize,
//                                                   ),
//                                                 ),
//                                                 GestureDetector(
//                                                   onTap: () {
//                                                     Get.offAllNamed(
//                                                         Routes.LOGIN);
//                                                   },
//                                                   child: DecoratedBox(
//                                                     decoration: const BoxDecoration(
//                                                         border: Border(
//                                                             bottom: BorderSide(
//                                                                 color: Colors
//                                                                     .white,
//                                                                 width: 1.0))),
//                                                     child: Text(
//                                                       "Sign In",
//                                                       style: TextStyle(
//                                                         color: const Color(
//                                                             0xff1CB26B),
//                                                         fontSize: AppVar
//                                                             .littelFontSize,
//                                                         fontWeight:
//                                                             FontWeight.bold,
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   );
//                                 },
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }

//   Widget _buildRadioButtonGroup(
//       String title, RadioController controller1, BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: _buildRadioButtons(controller.radioData, controller1, context),
//     );
//   }

//   List<Widget> _buildRadioButtons(List<String> radioData,
//       RadioController controller, BuildContext context) {
//     return List<Widget>.generate(
//       radioData.length,
//       (index) {
//         return SizedBox(
//           width: MediaQuery.sizeOf(context).width * .5 - 60,
//           child: Obx(() => RadioListTile<int>(
//                 contentPadding: EdgeInsets.zero,
//                 activeColor: AppVar.secondary,
//                 title: Text(
//                   radioData[index],
//                   style: TextStyle(fontSize: 12, color: AppVar.background),
//                 ),
//                 value: index,
//                 groupValue: controller.selectedValue.value,
//                 onChanged: (int? value) {
//                   controller.setSelectedValue(value!);
//                 },
//               )),
//         );
//       },
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:tracking_system_app/modules/auth/view/regester_screen_mobile_layout.dart';
import 'package:tracking_system_app/modules/auth/view/regester_screen_tablet_layout.dart';

// ignore: must_be_immutable
class RegesterView extends StatelessWidget {
  const RegesterView({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);

    final horizontalPadding = mediaQueryData.size.width;

    return LayoutBuilder(builder: (context, constraints) {
      if (horizontalPadding <= 850) {
        return RegesterScreenMobileLayout(context);
      } else {
        return RegesterScreenTapletLayout(context);
        // return TabletLayoutLoginScreen(context);
      }
    });
  }
}

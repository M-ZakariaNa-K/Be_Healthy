import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:tracking_system_app/controller/radio_controller.dart';
import 'package:tracking_system_app/modules/auth/controller/register_controller.dart';
import 'package:tracking_system_app/style/app_var.dart';
import 'package:tracking_system_app/widgets/auth/costume_login_TextField_widget.dart';
import 'package:tracking_system_app/widgets/auth/login-defult_button.dart';

import '../../../routes/app_pages.dart';

class RegesterScreenTapletLayout extends GetView<RegisterController> {
  const RegesterScreenTapletLayout(BuildContext context, {super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppVar.primary,
        body: OrientationBuilder(
          builder: (context, orientation) {
            final screenWidth = MediaQuery.sizeOf(context).width;
            final screenHeight = MediaQuery.sizeOf(context).height;
            final isTablet =
                screenWidth > 600; // Adjust the breakpoint as needed
            final isLandscape =
                MediaQuery.of(context).orientation == Orientation.landscape;
            return SingleChildScrollView(
              child: Stack(
                children: [
                  if (!isLandscape)
                    Positioned(
                      child: Image(
                        width: screenWidth,
                        image: const AssetImage('assets/images/Rectingle.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),

                  // Waiting for admin approval (Lottie Animation)
                  Obx(() {
                    if (controller.isWaitAdminApproved.value) {
                      return Positioned(
                        bottom: MediaQuery.sizeOf(context).height * 0.25,
                        right: 0,
                        left: 0,
                        child: Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(1000),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(1000),
                                    color: AppVar.background,
                                    border: Border.all(
                                        width: 3, color: AppVar.primary)),
                                width: 150,
                                height: 150,
                                child: Image.asset(
                                  "assets/images/Logo1.png",
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Center(
                              child: LottieBuilder.asset(
                                repeat: false,
                                "assets/Lottie/Animation - 1726871315481.json",
                                width: 200,
                                height: 200,
                                fit: BoxFit.fill,
                              ),
                            ),
                            const SizedBox(height: 20),
                            const Text(
                              "Done!",
                              style: TextStyle(
                                color: Color(0xff1CB26B),
                                fontSize: 30,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 20),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 15),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 1,
                                  color: const Color(0xff1CB26B),
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Text(
                                "Waiting for admin approval",
                                style: TextStyle(
                                  color: AppVar.seconndTextColor,
                                  fontSize: 16,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      );
                    } else {
                      return Container();
                    }
                  }),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40,
                        // isTablet ? 80.0 : 40.0,
                        vertical: 30
                        // isLandscape
                        //     ? 20
                        //     : 40.0, // Reduce vertical padding in landscape
                        ),
                    child: Obx(
                      () => Opacity(
                        opacity: controller.isWaitAdminApproved.value ? 0 : 1,
                        child: Form(
                          key: controller.formKey,
                          child: Column(
                            mainAxisAlignment: isLandscape
                                ? MainAxisAlignment.start
                                : MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(1000),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(1000),
                                        color: AppVar.background,
                                        border: Border.all(
                                            width: 3, color: AppVar.primary)),
                                    width: 150,
                                    height: 150,
                                    child: Image.asset(
                                      "assets/images/Logo1.png",
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                  height: isLandscape
                                      ? screenHeight * 0.05
                                      : screenWidth * 0.15), // Adjust spacing
                              const SizedBox(height: 20),
                              const Padding(
                                padding: EdgeInsets.only(bottom: 10.0, top: 0),
                                child: Text(
                                  "Sign Up",
                                  style: TextStyle(
                                    color: AppVar.seconndTextColor,
                                    fontSize: 40,
                                    shadows: [
                                      Shadow(
                                        color: Color.fromARGB(255, 79, 79, 79),
                                        offset: Offset(2, 4),
                                        blurRadius: 5,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 30),
                              // Custom Text Fields for Full Name, Job Title, etc.
                              CustomeLoginTextFormField(
                                isFilledTextFild: false,
                                filledTextFildData: "",
                                prefixIcon: null,
                                inputType: TextInputType.text,
                                hintText: 'Full Name',
                                title: 'Full Name',
                                controller: controller.fullNameController,
                                validator: null,
                              ),

                              const SizedBox(height: 15),
                              const Text(
                                "Job Title:",
                                style: TextStyle(color: Color(0xffC9DBD3)),
                              ),
                              _buildRadioButtonGroup("Jop Title",
                                  controller.jopTitleController, context),

                               CustomeLoginTextFormField(
                            isFilledTextFild: false,
                            filledTextFildData: "",
                            prefixIcon: null,
                            inputType: TextInputType.text,
                            hintText: 'Employee Number',
                            title: 'Employee Number',
                            controller: controller.employeeNumberController,
                            validator: null,
                          ),
                              CustomeLoginTextFormField(
                                isFilledTextFild: false,
                                filledTextFildData: "",
                                hintText: 'Phone Number',
                                inputType: TextInputType.number,
                                title: 'Phone Number',
                                prefixIcon: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Image.asset(
                                        'assets/images/uae_flag.png',
                                        width: 24,
                                        height: 24,
                                      ),
                                      const SizedBox(width: 5),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 5),
                                        decoration: const BoxDecoration(
                                            border: Border(
                                          right: BorderSide(
                                            color: AppVar.seconndTextColor,
                                            width: 1.0,
                                          ),
                                        )),
                                        child: const Text(
                                          '+971',
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: AppVar.seconndTextColor,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                controller: controller.phoneNumberController,
                                validator: null,
                              ),
                              CustomeLoginTextFormField(
                                prefixIcon: null,
                                inputType: TextInputType.text,
                                hintText: 'Password',
                                title: 'Password',
                                controller: controller.passwordController,
                                validator: null,
                                isFilledTextFild: false,
                                filledTextFildData: "",
                              ),
                              CustomeLoginTextFormField(
                                prefixIcon: null,
                                inputType: TextInputType.text,
                                hintText: 'Confirm Password',
                                title: 'Password',
                                controller:
                                    controller.confirmPasswordController,
                                validator: null,
                                isFilledTextFild: false,
                                filledTextFildData: "",
                              ),
                              const SizedBox(height: 50),
                              // Sign Up Button
                              LoginDefultButton(
                                fontsize: isTablet
                                    ? 20
                                    : AppVar
                                        .mainFontSize, // Adjust font size for tablets
                                buttonColor: const Color(0xff1CB26B),
                                borderColor: Colors.transparent,
                                textColor: AppVar.seconndTextColor,
                                title: "SIGN UP",
                                onPressed: () {
                                  if (controller.formKey.currentState!
                                      .validate()) {
                                    controller.validateForm();
                                  }
                                },
                              ),
                              const SizedBox(height: 10),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10.0),
                                child: Center(
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        "Already have an account? ",
                                        style: TextStyle(
                                          color: AppVar.seconndTextColor,
                                          fontSize: AppVar.littelFontSize,
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Get.offAllNamed(Routes.LOGIN);
                                        },
                                        child: DecoratedBox(
                                          decoration: const BoxDecoration(
                                              border: Border(
                                                  bottom: BorderSide(
                                                      color: Colors.white,
                                                      width: 1.0))),
                                          child: Text(
                                            "Sign In",
                                            style: TextStyle(
                                              color: const Color(0xff1CB26B),
                                              fontSize: AppVar.littelFontSize,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildRadioButtonGroup(
      String title, RadioController controller1, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: _buildRadioButtons(controller.radioData, controller1, context),
    );
  }

  List<Widget> _buildRadioButtons(List<String> radioData,
      RadioController controller, BuildContext context) {
    return List<Widget>.generate(
      radioData.length,
      (index) {
        return SizedBox(
          width: MediaQuery.sizeOf(context).width * .5 - 60,
          child: Obx(() => RadioListTile<int>(
                contentPadding: EdgeInsets.zero,
                activeColor: AppVar.secondary,
                title: Text(
                  radioData[index],
                  style: TextStyle(fontSize: 12, color: AppVar.background),
                ),
                value: index,
                groupValue: controller.selectedValue.value,
                onChanged: (int? value) {
                  controller.setSelectedValue(value!);
                },
              )),
        );
      },
    );
  }
}

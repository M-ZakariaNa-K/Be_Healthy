import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tracking_system_app/modules/home/controller/home_controller.dart';
import 'package:tracking_system_app/widgets/home/customers_list_widget.dart';

class HomeViewCustomersIconWidget extends StatelessWidget {
  const HomeViewCustomersIconWidget({
    super.key,
    required this.controller,
  });

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Obx(() {
        return Stack(
          children: [
            AnimatedPositioned(
              duration: const Duration(milliseconds: 100),
              child: GestureDetector(
                /*to leave the interface when i click anywhere*/
                onTap: () {
                  controller.isDocumentsIconPressed.value = false;
                },
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 300),
                  opacity: controller.isDocumentsIconPressed.value ? 0.9 : 0.0,
                  child: Container(
                    width: controller.isDocumentsIconPressed.value
                        ? MediaQuery.sizeOf(context).width
                        : 0,
                    height: controller.isDocumentsIconPressed.value
                        ? MediaQuery.sizeOf(context).height
                        : 0,
                    color: const Color(0xffD4D4D4),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 0,
              child: IconButton(
                color: Colors.white,
                onPressed: () {
                  // Get.back();
                  controller.isDocumentsIconPressed.value =
                      !controller.isDocumentsIconPressed.value;
                },
                icon: const Icon(Icons.arrow_back_ios_new),
              ),
            ),
            // Display the Data on the Right Side
            if (controller.isDocumentsIconPressed.value)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: CustomersListWidget(controller: controller),
              ),
          ],
        );
      }),
    );
  }
}

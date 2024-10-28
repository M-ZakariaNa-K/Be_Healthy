import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tracking_system_app/modules/home/controller/home_controller.dart';

class CustomersListWidget extends StatelessWidget {
  const CustomersListWidget({
    super.key,
    required this.controller,
  });

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    final isTaplet = MediaQuery.of(context).size.width > 800 &&
        MediaQuery.of(context).size.height > 800;
    return Obx(() {
      // if (controller.isCustomersLoading.value) {
      //   return const Center(child: MainLoadingWidget());
      // }
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30),
        child: ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: controller.customersList.length,
          itemBuilder: (context, index) {
            final item = controller.customersList[index];
            return GestureDetector(
              // onTap: () => controller.selectItem(item),
              child: Container(
                width: double.infinity,
                margin: const EdgeInsets.only(top: 5),
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7),
                  border: Border.all(color: Colors.grey),
                  // color: controller.selectedDocumentType.value == item
                  //     ? const Color(0xffC0D5FA)
                  //     :
                  color: Colors.white,
                ),
                child: Text(
                  "${item.name} / Bags Id: ${item.bags}",
                  style: TextStyle(
                    fontSize: isTaplet ? 24 : 13,
                    color: const Color.fromARGB(255, 0, 0, 0),
                    decoration: TextDecoration.none,
                  ),
                ),
              ),
            );
          },
        ),
      );
    });
  }
}

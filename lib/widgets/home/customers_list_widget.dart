import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tracking_system_app/modules/home/controller/home_controller.dart';
import 'package:tracking_system_app/style/app_var.dart';

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
      if (controller.customersList.isEmpty) {
        return Center(
            child: Container(
          alignment: Alignment.center,
          height: MediaQuery.sizeOf(context).height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 100),
                width: 100,
                height: 100,
                child: Image.asset(
                  color: AppVar.primary,
                  "assets/images/customer.png",
                  // "assets/images/documents_icon.png",
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                "There is no customers for you",
                style: TextStyle(
                  fontSize: isTaplet ? 36 : 16,
                  fontFamily: "ABeeZee",
                  color: AppVar.primary,
                  decoration: TextDecoration.none,
                ),
              ),
            ],
          ),
        ));
      }
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30),
        child: Column(
          children: [
            Text(
              "My Costomers",
              style: TextStyle(
                fontSize: 30,
                color: AppVar.primary,
                decoration: TextDecoration.none,
              ),
            ),
            Divider(
              color: AppVar.secondary,
              thickness: 2,
              endIndent: 20,
              indent: 20,
            ),
            ListView.builder(
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
          ],
        ),
      );
    });
  }
}

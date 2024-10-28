import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tracking_system_app/model/customers_list_model.dart';
import 'package:tracking_system_app/model/my_info_model.dart';
import 'package:tracking_system_app/network_util.dart';
import 'package:tracking_system_app/widgets/home/custome_message_dialog.dart';
import 'package:tracking_system_app/widgets/home/custome_sign_out_dialog.dart';
import 'package:tracking_system_app/widgets/toast/custom_toast.dart';

class HomeController extends GetxController {
  RxInt selectedCardIndex = (-1).obs;
  final TextEditingController issueDialogController = TextEditingController();
  RxBool isTextFildFilled = false.obs;
  RxBool isLoading = false.obs;
  RxBool isMyInfoLoading = false.obs;
  RxBool showLottieAnimation = false.obs;
  Rx<MyInfoDataModel> myInfoModel = MyInfoDataModel(
          id: 0, name: "", phone: "", employeeNumber: "", image: null, role: "")
      .obs;
  //==============Zak's Editation=======================
  RxBool isDocumentsIconPressed = false.obs;
  // to toggle the visibility of the dropdown items
  RxBool isDropdownOpen = false.obs;
  RxList<CustomerListDataModel> filteredCustomers =
      <CustomerListDataModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    initialize();
  }

//===========================================My Info========================================
  Future<void> initialize() async {
    isMyInfoLoading.value = true;
    try {
      var response = await $.get('users/my-info');
      print(response);

      if (response != null) {
        myInfoModel.value = MyInfoDataModel.fromJson(response["data"]);
      }
    } catch (e) {
      print("Error: $e");
      CustomToast.errorToast("Opps..", "Failed to load my info");
    } finally {
      isMyInfoLoading.value = false;
    }
  }
//===========================================Messaging dialog================================================================

  Future<void> sendToAdmin() async {
    isLoading.value = true;
    // Simulate sending request to the admin
    //Here i will make a post request to the server
    try {
      // await $.flipIfDemo(email: emailC.text);
      final response = await $.post('users/send-message', body: {
        "type": "issue",
        "message": issueDialogController.text,
      });

      if (response != null) {
        // await Future.delayed(Duration(seconds: 3));
        // // Show Lottie animation for 3 seconds
        showLottieAnimation.value = true;
        issueDialogController.clear();
        isTextFildFilled.value = false;
        isLoading.value = false;
        await Future.delayed(const Duration(seconds: 3));
        Get.back(); // Close the dialog after Lottie finishes
      }

      //         showLottieAnimation.value = false;

      // isLoading.value = false;
    } catch (e) {
      CustomToast.errorToast("Error", "Error because : ${e.toString()}");
    } finally {
      showLottieAnimation.value = false;
      isLoading.value = false;
    }
  }

  void exitMessageDialog() {
    Get.back(); // Close the dialog
    isTextFildFilled.value = false;
    issueDialogController.clear();
  }

// Function to show the dialog
  void showCustomMessageDialog(
      BuildContext context, HomeController homeController) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        if (MediaQuery.of(context).orientation == Orientation.landscape) {
          return SingleChildScrollView(
              child: CustomMessageDialog(
            title: homeController.myInfoModel.value.name,
            subtitle: homeController.myInfoModel.value.employeeNumber ??
                homeController.myInfoModel.value.id.toString(),
          ));
        } else {
          return CustomMessageDialog(
            title: homeController.myInfoModel.value.name,
            subtitle: homeController.myInfoModel.value.employeeNumber ??
                homeController.myInfoModel.value.id.toString(),
          );
        }
      },
    );
  }
//===========================================Sign out dialog================================================================

  void exitSignOutDialog() {
    Get.back(); // Close the dialog
  }

// Function to show the dialog
  void showCustomSignOutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomSignOutDialog();
      },
    );
  }

  Future<void> logout() async {
    isLoading.value = true;
    try {
      await $.resetUser();

      isLoading.value = false;
    } catch (e) {
      CustomToast.errorToast("Error", "Error because : ${e.toString()}");
    } finally {
      isLoading.value = false;
    }
  }

  // list for filtered search results

  // Method to toggle dropdown visibility
  void toggleDropdown() {
    isDropdownOpen.value = !isDropdownOpen.value;
  }

  // // Method to select an item and close the dropdown
  // void selectItem(DocumentTypeModel item) {
  //   selectedDocumentType.value = item;
  //   // myDocumentsController.choosenRecentUploadedDocumentType.value = item.name;
  //   isDropdownOpen.value = false; // Close the dropdown after selecting
  //   filteredDocumentTypes.value = documentTypesList; // Reset filter
  //   // searchController.text = selectedDocumentType.value.name;
  //   // Show date pickers if specific document type is selected
  //   // showDatePickers.value = (item.expirable == true);
  // }
  RxBool isCustomersLoading = false.obs;
  RxList<CustomerListDataModel> customersList = <CustomerListDataModel>[].obs;
  Future initializeCustomersTypes() async {
    isCustomersLoading.value = true;

    var data = await $
        .get('customers/list?state=active&driver_id=${myInfoModel.value.id}');
    if (data != null) {
      customersList.value = (data['data'] as List)
          .map((e) => CustomerListDataModel.fromJson(e))
          .toList();
    }
    isCustomersLoading.value = false;
    // isDocumentsTypesInitialized.value = true;
  }

  // // Method to filter search results
  // void filterItems(String query) {
  //   if (query.isEmpty) {
  //     filteredCustomers.value = filteredCustomers;
  //   } else {
  //     filteredCustomers.value = filteredCustomers
  //         .where(
  //             (item) => item.name.toLowerCase().contains(query.toLowerCase()))
  //         .toList();
  //   }
  // }
}

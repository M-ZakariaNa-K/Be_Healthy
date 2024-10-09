
import 'package:get/get.dart';

class RadioController extends GetxController {
  var selectedValue = Rx<int?>(null); // Initially set to null

  void setSelectedValue(int value) {
    selectedValue.value = value;
  }
    int? getSelectedValue() {
    return selectedValue.value;
  }
}
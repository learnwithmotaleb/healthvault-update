import 'package:get/get.dart';

class ServiceSelectionController extends GetxController {
  RxString serviceId = "".obs;
  RxString serviceTitle = "".obs;
  RxString servicePrice = "".obs;

  void setService(String id, String title, String price) {
    serviceId.value = id;
    serviceTitle.value = title;
    servicePrice.value = price;
  }
}

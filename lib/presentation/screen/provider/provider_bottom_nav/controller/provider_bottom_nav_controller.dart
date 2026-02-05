import 'package:get/get.dart';

class ProviderBottomNavController extends GetxController{

  var currentIndex = 0.obs; // observable

  void changeIndex(int index) {
    currentIndex.value = index;
  }
}
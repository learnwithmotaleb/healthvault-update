import 'package:get/get.dart';
import '../exception_handler.dart';

class ExceptionController extends GetxController {
  RxString errorMessage = "".obs;

  void catchError(dynamic error) {
    ExceptionHandler.handle(error);
    errorMessage.value = error.toString();
  }

  void clearError() {
    errorMessage.value = "";
  }
}

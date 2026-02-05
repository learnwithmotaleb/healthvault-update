import 'app_exceptions.dart';
import 'package:get/get.dart';

class ExceptionHandler {
  static void handle(dynamic error) {
    if (error is AppException) {
      _showMessage(error.message);
    }
    else if (error.toString().contains("SocketException")) {
      _showMessage("No Internet Connection");
    }
    else if (error.toString().contains("TimeoutException")) {
      _showMessage("Request Timeout");
    }
    else if (error.toString().contains("500") ||
        error.toString().contains("502") ||
        error.toString().contains("503")) {
      _showMessage("Server Error");
    }
    else {
      _showMessage("Unknown Error");
    }
  }

  static void _showMessage(String message) {
    Get.snackbar(
      "Error",
      message,
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/exception_controller.dart';

class ExceptionScreen extends StatelessWidget {
  const ExceptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ExceptionController>();

    return Scaffold(
      body: Center(
        child: Obx(() {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error_outline, size: 60, color: Colors.red),
              SizedBox(height: 20),
              Text(
                controller.errorMessage.value,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  controller.clearError();
                  Get.back();
                },
                child: Text("Retry"),
              )
            ],
          );
        }),
      ),
    );
  }
}

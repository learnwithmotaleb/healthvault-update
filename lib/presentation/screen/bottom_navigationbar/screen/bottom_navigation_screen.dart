import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:healthvault/presentation/screen/reminder/select_reminder/screen/select_reminder_screen.dart';
import 'package:healthvault/utils/static_strings/static_strings.dart';

import '../../../../utils/app_colors/app_colors.dart';
import '../../appointment/screen/appointment_screen.dart';
import '../../home/screen/home_screen.dart';
import '../../profile/profile/screen/profile_screen.dart';
import '../controller/bottom_navigation_controller.dart';

class BottomNavigationScreen extends StatefulWidget {
  const BottomNavigationScreen({super.key});

  @override
  State<BottomNavigationScreen> createState() => _BottomNavigationScreenState();
}

class _BottomNavigationScreenState extends State<BottomNavigationScreen> {
  final BottomNavController controller = Get.put(BottomNavController());

  final List<Widget> screens = const [
    HomeScreen(),
    AppointmentScreen(),
    SelectReminderScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
      body: screens[controller.currentIndex.value],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: controller.currentIndex.value,
        onTap: controller.changeIndex,
        selectedItemColor: AppColors.primaryColor,
        unselectedItemColor: AppColors.greyColor,
        showUnselectedLabels: true,
        items:  [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: AppStrings.home.tr,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: AppStrings.appointments.tr,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.alarm),
            label: AppStrings.reminder.tr,

          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: AppStrings.profile.tr,
          ),
        ],
      ),
    ));
  }
}


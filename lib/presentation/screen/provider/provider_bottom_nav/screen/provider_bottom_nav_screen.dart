import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:healthvault/presentation/screen/provider/provider_home/screen/provider_home_screen.dart';

import '../../../../../utils/app_colors/app_colors.dart';
import '../../../../../utils/static_strings/static_strings.dart';
import '../../../profile/profile/screen/profile_screen.dart';
import '../../provider_profile/screen/provider_profile_screen.dart';
import '../../provider_task/screen/provider_task_screen.dart';
import '../controller/provider_bottom_nav_controller.dart';

class ProviderBottomNavScreen extends StatefulWidget {
  const ProviderBottomNavScreen({super.key});

  @override
  State<ProviderBottomNavScreen> createState() => _ProviderBottomNavScreenState();
}

class _ProviderBottomNavScreenState extends State<ProviderBottomNavScreen> {
  final ProviderBottomNavController controller = Get.put(ProviderBottomNavController());

  final List<Widget> screens = const [
    ProviderHomeScreen(),
    ProviderTaskScreen(),
    ProviderProfileScreen(),
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
            label: AppStrings.task.tr,
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

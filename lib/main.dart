import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:healthvault/presentation/screen/emergency_screen/widget/map_request.dart';
import 'package:healthvault/presentation/screen/provider/doctor_identification/controller/service_selection_controller.dart';

import 'app.dart';
import 'global/language/controller/language_controller.dart';
import 'helper/device_utils/device_utils.dart';
import 'helper/local_db/local_db.dart';
import 'helper/role_controller/role_controller.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();


  final LanguageController languageController = Get.put(LanguageController());
  await languageController.loadLanguage();
  MapRequest.requestLocationPermission();
  DeviceUtils.lockDevicePortrait();
  Get.put(ServiceSelectionController());
  await SharePrefsHelper.init();






  runApp( MyApp());
}



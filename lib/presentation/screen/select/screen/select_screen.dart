import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:healthvault/core/routes/route_path.dart';

import '../../../../core/responsive_layout/dimensions/dimensions.dart';
import '../../../../helper/role_controller/role_controller.dart';
import '../../../../utils/app_colors/app_colors.dart';
import '../../../../utils/assets_image/app_images.dart';
import '../../../../utils/static_strings/static_strings.dart';
import '../../../widget/hv_button.dart';

class SelectScreen extends StatefulWidget {
  const SelectScreen({super.key});

  @override
  State<SelectScreen> createState() => _SelectScreenState();
}


final _role = RoleController();

class _SelectScreenState extends State<SelectScreen> {




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,


      body: SingleChildScrollView(
        padding: EdgeInsets.all(0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [


            /// ------------------ TOP IMAGE ------------------
            Image.asset(
              AppImages.selectScreen,
              fit: BoxFit.contain,
              width: double.infinity,
            ),

            /// ------------------ LANGUAGE TOGGLE ------------------
            SizedBox(height: Dimensions.h(50)),

            HVButton(
              leadingIcon: Icon(Icons.person,size: 20, fontWeight: FontWeight.bold,),

              width:Dimensions.h(350) ,
              height: Dimensions.h(55),
              label: AppStrings.user.tr, onPressed: () async{
              await _role.setUser().then((value){
                print("Role User Set successfully");
              });
                Get.toNamed(RoutePath.login);

            },
            ),
            SizedBox(height: Dimensions.h(20)),
            HVButton(
              leadingIcon: Icon(Icons.person,size: 20, fontWeight: FontWeight.bold, color: AppColors.primaryColor),

              trailingIcon: Icon(Icons.arrow_forward,size: 25, fontWeight: FontWeight.bold,color: AppColors.primaryColor,),
              backgroundColor: AppColors.whiteColor,
              textColor: AppColors.primaryColor,
              width:Dimensions.h(350) ,
              height: Dimensions.h(55),
              label: AppStrings.provider.tr, onPressed: () async{

              await _role.setProvider().then((value){
                print("Role Provider Set successfully");
              });
                Get.toNamed(RoutePath.providerSelection);
            },
              borderSideColor: AppColors.primaryColor,
            ),

          ],
        ),
      ),
    );
  }
}
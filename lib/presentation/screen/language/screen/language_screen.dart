import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthvault/presentation/widget/hv_button.dart';
import '../../../../core/responsive_layout/dimensions/dimensions.dart';
import '../../../../core/routes/route_path.dart';
import '../../../../core/theme/theme_controller.dart';
import '../../../../global/language/controller/language_controller.dart';
import '../../../../utils/assets_image/app_images.dart';
import '../../../../utils/app_colors/app_colors.dart';
import '../../../../utils/static_strings/static_strings.dart';

class LanguageScreen extends StatelessWidget {
   LanguageScreen({super.key});



  @override
  Widget build(BuildContext context) {
    final lc = LanguageController.to;







    return Scaffold(
      backgroundColor: AppColors.whiteColor,


    body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Dimensions.w(24),
          vertical: 0),
          child: SingleChildScrollView(
            padding: EdgeInsets.all(0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                /// ------------------ HEADER ------------------
                Row(
                  children: [
                    InkWell(
                      onTap: () => Get.back(),
                      child: Icon(
                        Icons.arrow_back_ios_outlined,
                        color: AppColors.blackColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Expanded(
                      child: Text(
                      AppStrings.language.tr,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                        ),


                      ),
                    ),

                  ],
                ),
                SizedBox(height: Dimensions.h(50),),









                /// ------------------ TOP IMAGE ------------------
                Image.asset(
                  AppImages.selectLanguage,
                  fit: BoxFit.contain,
                  height: 300,
                ),

                SizedBox(height: Dimensions.h(200)),

                /// ------------------ LANGUAGE TOGGLE ------------------
                Obx(
                      () => Container(
                    height: Dimensions.h(45),
                    width: Dimensions.w(250),
                    decoration: BoxDecoration(
                      color: AppColors.whiteColor,
                      borderRadius: BorderRadius.circular(Dimensions.r(16)),
                      border: Border.all(color: AppColors.primaryColor, width: 1),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: Dimensions.r(15),
                          offset: Offset(0, Dimensions.h(4)),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [

                        /// ENGLISH
                        languageButton(
                          title: "English",
                          isActive: lc.isEnglish.value,
                          onTap: () => lc.switchLanguage(true),
                          left: true,
                        ),

                        /// ARABIC
                        languageButton(
                          title:"Greek",
                          isActive: !lc.isEnglish.value,
                          onTap: () => lc.switchLanguage(false),
                          right: true,
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: Dimensions.h(50)),

                HVButton(

                  width: 350,
                  height: 55,
                  label: AppStrings.continueButton.tr, onPressed: () {

                    Get.toNamed(RoutePath.select);
                },
                )

              ],
            ),
          ),
        ),
      ),
    );
  }

  /// ------------------ LANGUAGE BUTTON WIDGET ------------------

   Widget languageButton({
     required String title,
     required bool isActive,
     required VoidCallback onTap,
     bool left = false,
     bool right = false,
   }) {
     // Compute a stable border radius once (does not depend on isActive)
     final BorderRadius radius = BorderRadius.only(
       topLeft: left ? Radius.circular(Dimensions.r(16)) : Radius.zero,
       bottomLeft: left ? Radius.circular(Dimensions.r(16)) : Radius.zero,
       topRight: right ? Radius.circular(Dimensions.r(16)) : Radius.zero,
       bottomRight: right ? Radius.circular(Dimensions.r(16)) : Radius.zero,
     );

     // Colors (only these should animate/change)
     final Color bg = isActive ? AppColors.primaryColor : Colors.transparent;
     final Color fg = isActive ? AppColors.whiteColor : AppColors.blackColor;

     return Expanded(
       child: Material(
         color: Colors.transparent,
         child: InkWell(
           onTap: onTap,
           borderRadius: radius,
           child: AnimatedContainer(
             duration: const Duration(milliseconds: 200),
             curve: Curves.easeOut,
             alignment: Alignment.center,
             padding: EdgeInsets.symmetric(
               vertical: Dimensions.h(2),
               horizontal: Dimensions.w(2),
             ),
             decoration: BoxDecoration(
               color: bg,          // only color changes on tap
               borderRadius: radius, // shape stays fixed per side
               border: Border.all(
                 color: AppColors.primaryColor,
                 width: 1,
               ),
             ),
             child: Text(
               title,
               maxLines: 1,
               overflow: TextOverflow.ellipsis,
               style: TextStyle(
                 fontSize: Dimensions.f(16),
                 fontWeight: FontWeight.w600,
                 color: fg,
               ),
             ),
           ),
         ),
       ),
     );
   }

}
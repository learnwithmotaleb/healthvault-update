import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:healthvault/presentation/widget/custom_appbar.dart';
import 'package:healthvault/utils/app_text_style/app_text_style.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../core/responsive_layout/dimensions/dimensions.dart';
import '../../../../../utils/app_colors/app_colors.dart';
import '../../../../../utils/assets_image/app_images.dart';
import '../../../../../utils/static_strings/static_strings.dart';
import '../controller/faqs_controller.dart';

class FaqsScreen extends StatelessWidget {
  FaqsScreen({super.key});

  final FaqsController controller = Get.put(FaqsController());


  Future<void> openDialPad(String phoneNumber) async {
    final Uri uri = Uri(scheme: 'tel', path: phoneNumber);

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch dial pad';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CommonAppBar(title: AppStrings.faq.tr),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: Dimensions.w(10)),
        child: Obx(() {
          /// 🔄 Loading State
          if (controller.isLoading.value) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          /// 📭 Empty State
          if (controller.faqs.isEmpty) {
            return Center(
              child: Text(
                "No FAQs available",
                style: AppTextStyles.body,
              ),
            );
          }

          /// ✅ Data Loaded
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppStrings.faqs,
                  style: AppTextStyles.title.copyWith(
                    fontWeight: FontWeight.normal,
                  ),
                ),
                SizedBox(height: Dimensions.h(12)),

                /// 🔽 FAQ List
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.faqs.length,
                  separatorBuilder: (_, __) =>
                      SizedBox(height: Dimensions.h(6)),
                  itemBuilder: (context, index) {
                    final faq = controller.faqs[index];

                    return _faqExpansionTile(
                      title: faq.question ?? "",
                      content: faq.answer ?? "",
                    );
                  },
                ),

                SizedBox(height: Dimensions.h(24)),

                /// ☎ Need More Help
                Padding(
                  padding: EdgeInsets.all(Dimensions.w(10)),
                  child: Text(
                    AppStrings.needMoreHelp.tr,
                    style: AppTextStyles.body.copyWith(
                      fontSize: Dimensions.w(18),
                    ),
                  ),
                ),

                GestureDetector(
                  onTap: () {
                    // TODO: Call action
                  },
                  child: Card(
                    elevation: 1,
                    color: AppColors.whiteColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(Dimensions.r(12)),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(Dimensions.w(16)),
                      child: Row(
                        children: [
                          Image.asset(
                            AppImages.emergencyCall,
                            width: Dimensions.w(40),
                            height: Dimensions.h(40),
                            color: AppColors.primaryColor,
                          ),
                          SizedBox(width: Dimensions.w(20)),
                          Expanded(
                            child: GestureDetector(
                              onTap: (){
                                openDialPad("01701577479");
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    AppStrings.callUs.tr,
                                    style: AppTextStyles.body,
                                  ),
                                  SizedBox(height: Dimensions.h(4)),
                                  Text(
                                    AppStrings.ourHelpLineServiceIsActive.tr,
                                    style: AppTextStyles.body,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                SizedBox(height: Dimensions.h(20)),
              ],
            ),
          );
        }),
      ),
    );
  }

  /// 🔹 Expansion Tile
  Widget _faqExpansionTile({
    required String title,
    required String content,
  }) {
    return Card(
      color: AppColors.whiteColor,
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Dimensions.r(5)),
      ),
      child: ExpansionTile(
        iconColor: AppColors.primaryColor,
        collapsedIconColor: AppColors.primaryColor,
        title: Text(
          title,
          style: AppTextStyles.body,
        ),
        children: [
          Padding(
            padding: EdgeInsets.all(Dimensions.w(16)),
            child: Text(
              content,
              style: AppTextStyles.body,
            ),
          ),
        ],
      ),
    );
  }
}

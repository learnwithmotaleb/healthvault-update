import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthvault/presentation/widget/custom_appbar.dart';
import 'package:healthvault/utils/app_colors/app_colors.dart';

import '../../../../../core/responsive_layout/dimensions/dimensions.dart';
import '../../../../../utils/app_text_style/app_text_style.dart';
import '../../../../../utils/static_strings/static_strings.dart';
import '../../../category_screen/details/widget/add_document_widget.dart';
import '../controller/family_member_document_controller.dart';

class FamilyMemberDocumentScreen extends StatefulWidget {
  const FamilyMemberDocumentScreen({super.key});

  @override
  State<FamilyMemberDocumentScreen> createState() =>
      _FamilyMemberDocumentScreenState();
}

class _FamilyMemberDocumentScreenState extends State<FamilyMemberDocumentScreen> {
  final FamilyMemberDocumentController controller =
  Get.put(FamilyMemberDocumentController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CommonAppBar(title: AppStrings.document.tr),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: Dimensions.h(10)),
            Text(
              AppStrings.familyMembers.tr,
              style: AppTextStyles.body.copyWith(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: Dimensions.h(16)),

            /// IMAGE PICKER
            DocumentPickerField(
              boxSize: 90,
              onPickImage: controller.uploadMyFamilyImage,
            ),

            SizedBox(height: Dimensions.h(20)),

            /// IMAGES
            Expanded(
              child: SingleChildScrollView(
                child: Obx(() {
                  if (controller.myFamilyImages.isEmpty) {
                    return const SizedBox();
                  }

                  return Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: controller.myFamilyImages.map((url) {
                      return Stack(
                        children: [
                          Container(
                            width: 90,
                            height: 90,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              image: DecorationImage(
                                image: NetworkImage(url),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Positioned(
                            top: 0,
                            right: 0,
                            child: GestureDetector(
                              onTap: () => controller.removeMyFamilyImage(url),
                              child: Container(
                                decoration: const BoxDecoration(
                                  color: Colors.red,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.close,
                                  size: 20,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'dart:io';

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

class _FamilyMemberDocumentScreenState
    extends State<FamilyMemberDocumentScreen> {
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

            /// PICK IMAGE BOX
            Obx(() => GestureDetector(
              onTap: () => controller.pickImage(),
              child: Container(
                width: Dimensions.w(90),
                height: Dimensions.h(90),
                decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppColors.primaryColor),
                  boxShadow: const [
                    BoxShadow(
                      color: AppColors.greyColor,
                      blurRadius: 2,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: controller.pickedImage.value == null
                    ? const Center(
                  child: Icon(
                    Icons.add_a_photo_outlined,
                    color: Colors.black54,
                    size: 28,
                  ),
                )
                    : ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.file(
                    File(controller.pickedImage.value!.path),
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            )),

            SizedBox(height: Dimensions.h(20)),


            /// IMAGES LIST
            Expanded(
              child: Obx(() {
                if (controller.myFamilyImages.isEmpty) {
                  return const Center(
                    child: Text(
                      "No family images uploaded",
                      style: TextStyle(color: Colors.grey),
                    ),
                  );
                }

                return SingleChildScrollView(
                  child: Wrap(
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
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}

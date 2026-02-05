import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../core/responsive_layout/dimensions/dimensions.dart';
import '../../../../../utils/app_colors/app_colors.dart';
import '../../../../../utils/app_text_style/app_text_style.dart';
import '../../../../../utils/static_strings/static_strings.dart';
import '../../../../widget/custom_appbar.dart';
import '../../../category_screen/details/widget/add_document_widget.dart';
import '../controller/add_document_controller.dart';

class AddDocumentScreen extends StatefulWidget {
  const AddDocumentScreen({super.key});

  @override
  State<AddDocumentScreen> createState() => _AddDocumentScreenState();
}

class _AddDocumentScreenState extends State<AddDocumentScreen> {
  final AddDocumentController controller = Get.put(AddDocumentController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CommonAppBar(title: AppStrings.addDocument.tr),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: Dimensions.h(10)),
            Text(
              AppStrings.mySelf.tr,
              style: AppTextStyles.body.copyWith(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: Dimensions.h(16)),

            /// IMAGE PICKER
            DocumentPickerField(
              boxSize: 90,
              onPickImage: controller.uploadMySelfImage,
            ),

            SizedBox(height: Dimensions.h(20)),

            /// IMAGES LIST
            Expanded(
              child: SingleChildScrollView(
                child: Obx(() {
                  if (controller.mySelfImages.isEmpty) {
                    return const SizedBox();
                  }

                  return Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: controller.mySelfImages.map((url) {
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
                              onTap: () => controller.removeMySelfImage(url),
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

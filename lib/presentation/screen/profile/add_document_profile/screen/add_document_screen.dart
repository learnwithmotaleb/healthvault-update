import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../core/responsive_layout/dimensions/dimensions.dart';
import '../../../../../utils/app_colors/app_colors.dart';
import '../../../../../utils/app_text_style/app_text_style.dart';
import '../../../../../utils/static_strings/static_strings.dart';
import '../../../../widget/custom_appbar.dart';
import '../controller/add_document_controller.dart';

class AddDocumentScreen extends StatelessWidget {
  AddDocumentScreen({super.key});

  final AddDocumentController controller = Get.put(AddDocumentController());

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppColors.whiteColor,
        appBar: const _DocumentAppBar(),

        body: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }
          return TabBarView(
            children: [
              _ImageSection(
                images: controller.mySelfImages,
                isUploading: controller.isMySelfUploading,
                onAdd: controller.pickAndUploadMySelf,
                onRemove: controller.removeMySelf,
              ),
              _ImageSection(
                images: controller.familyImages,
                isUploading: controller.isFamilyUploading,
                onAdd: controller.pickAndUploadFamily,
                onRemove: controller.removeFamily,
              ),
            ],
          );
        }),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
//  Reusable image grid section
// ─────────────────────────────────────────────────────────────────────────────
class _ImageSection extends StatelessWidget {
  const _ImageSection({
    required this.images,
    required this.isUploading,
    required this.onAdd,
    required this.onRemove,
  });

  final RxList<String> images;
  final RxBool isUploading;
  final VoidCallback onAdd;
  final void Function(String) onRemove;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Obx(() {
        return GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          // +1 for the "add" tile
          itemCount: images.length + 1,
          itemBuilder: (_, index) {
            // ── Add tile (always first) ──────────────────────────────
            if (index == 0) {
              return GestureDetector(
                onTap: isUploading.value ? null : onAdd,
                child: Container(
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
                  child: isUploading.value
                      ? const Center(
                    child: SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  )
                      : const Center(
                    child: Icon(
                      Icons.add_a_photo_outlined,
                      color: Colors.black54,
                      size: 28,
                    ),
                  ),
                ),
              );
            }

            // ── Image tile ──────────────────────────────────────────
            final url = images[index - 1];
            return Stack(
              fit: StackFit.expand,
              children: [
                // Image
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    url,
                    fit: BoxFit.cover,
                    loadingBuilder: (_, child, progress) => progress == null
                        ? child
                        : const Center(child: CircularProgressIndicator()),
                    errorBuilder: (_, __, ___) => Container(
                      color: Colors.grey.shade200,
                      child: const Icon(Icons.broken_image, color: Colors.grey),
                    ),
                  ),
                ),

                // Delete button
                Positioned(
                  top: 4,
                  right: 4,
                  child: GestureDetector(
                    onTap: () => _confirmDelete(context, url),
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.close,
                        size: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        );
      }),
    );
  }

  void _confirmDelete(BuildContext context, String url) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Remove Image"),
        content: const Text("Are you sure you want to remove this image?"),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              Get.back();
              onRemove(url);
            },
            child: const Text("Remove", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}

class _DocumentAppBar extends StatelessWidget implements PreferredSizeWidget {
  const _DocumentAppBar();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 40); // toolbar + tabbar height

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // ── Back Button Row ──────────────────────────────────────
        Padding(
          padding: const EdgeInsets.only(top: 30.0,left: 10),
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back_ios,size: 20,fontWeight: FontWeight.bold,),
                onPressed: () => Get.back(),
              ),
              SizedBox(width: 10,),
              Center(
                child: const Text(
                  "Document",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),

        // ── TabBar ───────────────────────────────────────────────
        TabBar(
          labelColor: AppColors.primaryColor,
          unselectedLabelColor: Colors.grey,
          indicatorColor: AppColors.primaryColor,
          tabs: [
            Tab(text: AppStrings.mySelf.tr),
            Tab(text: "Family"),
          ],
        ),
      ],
    );
  }
}
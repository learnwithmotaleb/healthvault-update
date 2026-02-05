import 'package:flutter/material.dart' hide SearchController;
import 'package:get/get.dart';
import 'package:healthvault/core/responsive_layout/dimensions/dimensions.dart';
import 'package:healthvault/service/api_url.dart';
import 'package:healthvault/utils/app_text_style/app_text_style.dart';
import 'package:healthvault/utils/static_strings/static_strings.dart';
import '../../../../../utils/app_colors/app_colors.dart';
import '../../../../widget/custom_appbar.dart';
import '../../../../widget/hv_text_field.dart';
import '../controller/search_controller.dart';
import '../widget/search_list_card.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});

  final SearchController controller = Get.put(SearchController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CommonAppBar(title: AppStrings.whatAreYouLookingFor.tr),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          children: [
            SizedBox(height: Dimensions.h(10)),

            /// SEARCH FIELD
            HVTextField(
              controller: controller.searchTextController,
              hint: AppStrings.provider.tr,
              prefixIcon: const Icon(
                Icons.search,
                color: AppColors.primaryColor,
              ),
            ),

            SizedBox(height: Dimensions.h(20)),

            /// HEADER
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppStrings.searchHistory.tr,
                  style: AppTextStyles.title.copyWith(fontWeight: FontWeight.normal),
                ),
                GestureDetector(
                  onTap: controller.clearSearch,
                  child: Text(
                    AppStrings.clearAll.tr,
                    style: AppTextStyles.body.copyWith(color: AppColors.primaryColor),
                  ),
                ),
              ],
            ),

            SizedBox(height: Dimensions.h(20)),

            /// SEARCH RESULT
            Expanded(
              child: Obx(() {
                if (controller.filteredList.isEmpty) {
                  return Center(
                    child: Text(
                      AppStrings.noResultFound.tr,
                      style: AppTextStyles.hint,
                    ),
                  );
                }

                return ListView.separated(
                  itemCount: controller.filteredList.length,
                  separatorBuilder: (_, __) => SizedBox(height: Dimensions.h(12)),
                  itemBuilder: (context, index) {
                    final item = controller.filteredList[index];

                    return SearchListCard(
                      name: item.fullName ?? "",
                      type: item.providerType?.label ?? "",
                      address: item.address ?? "",
                      imagePath: item.profileImage != null && item.profileImage!.isNotEmpty
                          ? "${ApiUrl.mainDomain}/${item.profileImage!.replaceAll(r'\', '/')}"
                          : "",

                      services: item.services?.map((s) => s.title ?? "").toList() ?? [],
                      onFavoriteTap: () async {
                        // Call controller method
                        final success = await controller.addFavorite(item.sId!);
                        if (success) {
                          // Optionally: update local favorite state in UI
                          debugPrint("Favorite added: ${item.fullName}");
                        }
                      },

                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart' hide SearchController;
import 'package:get/get.dart';
import 'package:healthvault/core/responsive_layout/dimensions/dimensions.dart';
import 'package:healthvault/service/api_url.dart';
import 'package:healthvault/utils/app_text_style/app_text_style.dart';
import 'package:healthvault/utils/static_strings/static_strings.dart';
import '../../../../../utils/app_colors/app_colors.dart';
import '../../../../widget/custom_appbar.dart';
import '../../../../widget/hv_text_field.dart';
import '../../../profile/favourite_profile/controller/favourite_controller.dart';
import '../controller/search_controller.dart';
import '../simmer_effect/simmer_effect.dart';
import '../widget/search_list_card.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final SearchController controller = Get.put(SearchController());
  final controllerFavorite = Get.find<FavouriteController>();

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

            // ── Search field ──
            HVTextField(
              controller: controller.searchTextController,
              hint: AppStrings.provider.tr,
              prefixIcon: const Icon(
                Icons.search,
                color: AppColors.primaryColor,
              ),
            ),

            SizedBox(height: Dimensions.h(20)),

            // ── Header: Search History + Clear All ──
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppStrings.searchHistory.tr,
                  style: AppTextStyles.title
                      .copyWith(fontWeight: FontWeight.normal),
                ),
                GestureDetector(
                  onTap: controller.clearSearch,
                  child: Text(
                    AppStrings.clearAll.tr,
                    style: AppTextStyles.body
                        .copyWith(color: AppColors.primaryColor),
                  ),
                ),
              ],
            ),

            SizedBox(height: Dimensions.h(20)),

            // ── Search results ──
            Expanded(
              child: Obx(() {
                // ── Loading state → shimmer ──
                if (controller.isLoading.value) {
                  return const SearchListShimmer(itemCount: 6);
                }

                // ── Empty state ──
                if (controller.filteredList.isEmpty) {
                  return Center(
                    child: Text(
                      AppStrings.noResultFound.tr,
                      style: AppTextStyles.hint,
                    ),
                  );
                }

                // ── Loaded state ──
                return ListView.separated(
                  itemCount: controller.filteredList.length,
                  separatorBuilder: (_, __) =>
                      SizedBox(height: Dimensions.h(12)),
                  itemBuilder: (context, index) {
                    final item = controller.filteredList[index];
                    final providerId =
                        item.sId ?? item.providerTypeId?.toString() ?? '';

                    return SearchListCard(
                      name: item.fullName ?? "",
                      type: item.providerType?.label ?? "",
                      address: item.address ?? "",
                      imagePath: item.profileImage != null &&
                          item.profileImage!.isNotEmpty
                          ? "${ApiUrl.mainDomain}/${item.profileImage!.replaceAll(r'\', '/')}"
                          : "",
                      services: item.services
                          ?.map((s) => s.title ?? "")
                          .toList() ??
                          [],
                      isFavorite: controllerFavorite.isFavorite(providerId),
                      onFavoriteTap: () {
                        controllerFavorite.toggleFavorite(
                          providerId,
                          providerName: item.fullName,
                        );
                        setState(() {});
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
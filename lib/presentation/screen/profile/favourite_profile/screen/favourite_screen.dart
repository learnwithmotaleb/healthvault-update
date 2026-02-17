import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthvault/presentation/widget/custom_appbar.dart';
import '../controller/favourite_controller.dart';
import '../widget/favourite_card_widget.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // ✅ Find existing instance — don't create a new one
    final controller = Get.find<FavouriteController>();

    return Scaffold(
      appBar: CommonAppBar(title: "Favorites"),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.favoriteList.isEmpty) {
          return const Center(child: Text("No favorites found."));
        }

        return ListView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: controller.favoriteList.length,
          itemBuilder: (context, index) {
            final data = controller.favoriteList[index];
            final item = data.providerId;
            if (item == null) return const SizedBox();

            final providerId = item.sId ?? '';

            return CustomInfoCard(
              image: item.profileImage ?? '',
              title: item.fullName ?? 'No Name',
              subtitle: item.specialization ?? 'No Subtitle',
              address: item.address ?? 'No Address',

              // ✅ Read from controller — not hardcoded true
              isFavorite: controller.isFavorite(providerId),

              onTap: () {
                print("Clicked → ${item.fullName}");
              },

              // ✅ Pass provider ID string — matches new toggleFavorite signature
              onFavoriteTap: () {
                controller.toggleFavorite(
                  providerId,
                  providerName: item.fullName,
                );
              },
            );
          },
        );
      }),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthvault/presentation/widget/custom_appbar.dart';
import '../controller/favourite_controller.dart';
import '../simmer/simmer_effect.dart';
import '../widget/favourite_card_widget.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<FavouriteController>();

    return Scaffold(
      appBar: CommonAppBar(title: "Favorites"),
      body: Obx(() {
        // ── Loading state → shimmer ──
        if (controller.isLoading.value) {
          return const FavouriteListShimmer(itemCount: 6);
        }

        // ── Empty state ──
        if (controller.favoriteList.isEmpty) {
          return const Center(child: Text("No favorites found."));
        }

        // ── Loaded state ──
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
              isFavorite: controller.isFavorite(providerId),
              onTap: () {
                print("Clicked → ${item.fullName}");
              },
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
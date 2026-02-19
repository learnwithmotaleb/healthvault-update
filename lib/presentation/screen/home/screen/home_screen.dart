import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:healthvault/core/responsive_layout/dimensions/dimensions.dart';
import 'package:healthvault/presentation/screen/home/controller/home_controller.dart';
import 'package:healthvault/presentation/widget/hv_button.dart';
import 'package:healthvault/presentation/widget/hv_text_field.dart';
import 'package:healthvault/utils/app_colors/app_colors.dart';
import 'package:healthvault/utils/app_text_style/app_text_style.dart';
import 'package:healthvault/utils/assets_image/app_images.dart';
import 'package:healthvault/utils/static_strings/static_strings.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/routes/route_path.dart';
import '../../../../helper/local_db/local_db.dart';
import '../../../../service/api_url.dart';
import '../../profile/favourite_profile/controller/favourite_controller.dart';
import '../Simmer_Effect/simmer_effect_screen.dart';
import '../widgets/category_card.dart';
import '../widgets/emergency_card.dart';
import '../widgets/pharmacy_card_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController searchController = TextEditingController();

  final controller = Get.put(HomeController());
  final controllerFavorite = Get.put(FavouriteController());



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Obx(() {
        if (controller.isLoading.value) {
          return const HomeScreenShimmer(); // ← shimmer
        }
        return SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 223,
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(16),
                    bottomLeft: Radius.circular(16),
                  ),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Obx(() {
                        if (controller.isLoading.value) {
                          return Center(child: CupertinoActivityIndicator(color: Colors.white));
                        }

                        final user = controller.userData.value;
                        final baseUrl = "${ApiUrl.mainDomain}/";

                        // Get profile image from normalUserDetails
                        final profileImage = (user?.normalUserDetails?.isNotEmpty ?? false)
                            ? user!.normalUserDetails![0].profileImage
                            : null;

                        final fullImageUrl = (profileImage != null && profileImage.isNotEmpty)
                            ? "$baseUrl${profileImage.replaceAll("\\", "/")}" // replace backslashes
                            : null;

                        // First letter fallback
                        final firstLetter = (user?.fullName != null && user!.fullName!.isNotEmpty)
                            ? user.fullName![0].toUpperCase()
                            : "?";

                        return ListTile(
                          leading: CircleAvatar(
                            radius: 30,
                            backgroundColor: AppColors.primaryColor,
                            backgroundImage: fullImageUrl != null ? NetworkImage(fullImageUrl) : null,
                            child: fullImageUrl == null
                                ? Text(
                              firstLetter,
                              style: AppTextStyles.title.copyWith(
                                color: AppColors.whiteColor,
                                fontSize: 24,
                              ),
                            )
                                : null,
                          ),
                          title: Text(
                            user?.fullName ?? "Loading...",
                            style: AppTextStyles.title.copyWith(
                              color: AppColors.whiteColor,
                              fontSize: 20,
                            ),
                          ),
                          subtitle: Text(
                            AppStrings.welcomeBack.tr,
                            style: AppTextStyles.body.copyWith(
                              color: AppColors.whiteColor.withOpacity(0.8),
                            ),
                          ),
                          trailing: GestureDetector(
                            onTap: () {
                              Get.toNamed(RoutePath.notification);
                            },
                            child: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                border: Border.all(
                                  width: 1,
                                  color: AppColors.whiteColor.withOpacity(0.5),
                                ),
                              ),
                              child: Icon(
                                Icons.notifications,
                                color: AppColors.whiteColor,
                              ),
                            ),
                          ),
                        );
                      }),

                      SizedBox(height: Dimensions.h(5)),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        child: HVTextField(
                          readOnly: true,
                          controller: searchController,
                          onTap: (){
                            Get.toNamed(RoutePath.search);
                          },
                          hint: AppStrings.searchByProvider.tr,
                          prefixIcon: Icon(
                            Icons.search,
                            color: AppColors.hintColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    double totalWidth = constraints.maxWidth;
                    double spacing = 10;
                    double itemWidth = (totalWidth - (spacing * 2)) / 3;

                    return Obx(() {
                      if (controller.isLoading.value) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      return Wrap(
                        spacing: spacing,
                        runSpacing: spacing,
                        children: controller.providerTypes.map((item) {
                          return CategoryCard(
                            width: itemWidth,
                            title: item.label ?? '', // 👈 API label
                            icon: Icons.medical_services, // চাইলে mapping করা যাবে
                            onTap: () {
                              Get.toNamed(
                                RoutePath.doctor,
                                arguments: {
                                  "providerTypeId": item.id,   // 👈 ID pass
                                  "providerTypeKey": item.key,  // optional
                                  "providerTypeLabel": item.label,
                                },
                              );
                              print("Id ${item.id}");
                              print("Key ${item.key}");
                              print("Label ${item.label}");
                            },
                          );
                        }).toList(),
                      );
                    });
                  },
                ),
              ),



              EmergencyCard(
                title: AppStrings.emergencyNeed.tr,
                subtitle: AppStrings.immediateConnectionWithEmergencyServices.tr,
                buttonLabel: AppStrings.emergency.tr,
                leadingIcon: Icons.add_alert,
                backgroundColor: AppColors.emergencyColor,
                buttonColor: AppColors.emergencyBlackColor,
                onPressed: () {
                  Get.toNamed(RoutePath.emergency);
                },
              ),

              SizedBox(height: Dimensions.h(5)),
              Obx(() {
                if (controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (controller.allProviders.isEmpty) {
                  return const Center(child: Text("No providers available"));
                }

                // Limit to 3 items
                final displayProviders = controller.allProviders.length > 3
                    ? controller.allProviders.sublist(0, 3)
                    : controller.allProviders;

                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: displayProviders.length,
                  itemBuilder: (context, index) {
                    final provider = displayProviders[index];
                    // Build provider image URL
                    final providerImage = provider.profileImage != null
                        ? ApiUrl.buildImageUrl(provider.profileImage!)
                        : AppImages.onboard3;

                    // Prepare availability map
                    final availability = <String, String>{};
                    for (var day in provider.availabilityDays ?? []) {
                      final slots = day.availabilitySlots
                          ?.map((s) => "From: ${s.startTime} - To: ${s.endTime}")
                          .join("\n") ??
                          "";
                      availability[day.dayOfWeek ?? ""] = slots;
                    }

                    return PharmacyCard(
                      name: provider.fullName ?? "No Name",
                      type: provider.providerType?.label ?? "Unknown",
                      address: provider.address ?? "No address",
                      imagePath: providerImage,
                      services: provider.services?.map((s) => s.title ?? "").toList() ?? [],
                      availability: availability,
                      // ✅ Read from controller using provider ID
                      isFavorite: controllerFavorite.isFavorite(provider.id.toString()),

                      // ✅ Toggle using provider ID
                      onFavoriteTap: () {
                        setState(() {

                        });
                        controllerFavorite.toggleFavorite(
                          provider.id.toString(),
                          providerName: provider.fullName,
                        );

                      },
                      onViewDetails: () {

                        final String profileId = provider.user!.first.profileId!;
                        print("Provider Profile Id: $profileId");


                        Get.toNamed(
                          RoutePath.infoProviderDetails,
                          arguments: {
                            "profileId": profileId.trim()
                          },
                        );



                      },

                    );
                  },
                );
              }),


              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          AppStrings.healthANDWellnessArticles.tr,
                          style: AppTextStyles.body,
                        ),
                        Spacer(),
                        TextButton(
                          onPressed: () {
                            Get.toNamed(RoutePath.healthArticle);
                          },
                          child: Text(
                            AppStrings.viewAll.tr,
                            style: AppTextStyles.body.copyWith(
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: Dimensions.h(5)),
                    Obx(() {
                      if (controller.isLoading.value) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      if (controller.articles.isEmpty) {
                        return const Center(child: Text("No articles found"));
                      }

                      return SizedBox(
                        height: 200,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: controller.articles.length,
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          separatorBuilder: (context, index) => SizedBox(width: Dimensions.w(5)),
                          itemBuilder: (context, index) {
                            final item = controller.articles[index];
                            final imageUrl = item.articleImage != null
                                ? ApiUrl.buildImageUrl(item.articleImage!)
                                : AppImages.health1; // fallback placeholder

                            return GestureDetector(
                              onTap: () {
                                // Navigate and pass articleId as Map
                                Get.toNamed(RoutePath.healthDetail, arguments: {'articleId': item.id.toString()});
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: Image.network(
                                  imageUrl,
                                  width: Dimensions.w(320),
                                  height: 200,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    }),
                  ],
                ),
              ),

              SizedBox(height: Dimensions.h(20)),
            ],
          ),
        );  // ← your real content
      }),
    );
  }
}

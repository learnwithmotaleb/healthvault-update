import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import '../../../../core/responsive_layout/dimensions/dimensions.dart';
import '../../../../utils/app_colors/app_colors.dart';
import '../../../../utils/app_text_style/app_text_style.dart';
import '../../../../utils/assets_image/app_images.dart';
import '../../../../utils/static_strings/static_strings.dart';


class PharmacyCard extends StatefulWidget {
  final String name;
  final String type;
  final String address;
  final String imagePath;
  final List<String> services;
  final Map<String, String> availability; // e.g., {"Saturday": "6:30 PM - 10:30 PM"}

  final VoidCallback? onFavoriteTap;

  final VoidCallback? onViewDetails;

  const PharmacyCard({
    super.key,
    required this.name,
    required this.type,
    required this.address,
    required this.imagePath,
    required this.services,
    required this.availability,
    this.onFavoriteTap,
    this.onViewDetails,
  });

  @override
  State<PharmacyCard> createState() => _PharmacyCardState();
}
class _PharmacyCardState extends State<PharmacyCard> {
  bool isFavorite = false; // <-- move here, as a member of the state

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: AppColors.whiteColor,
          border: Border.all(color: AppColors.primaryColor),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// ---------- TOP INFO ----------
            Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// IMAGE
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      widget.imagePath,
                      width: 100, // slightly smaller
                      height: 100,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                          AppImages.appLogo,
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        );
                      },
                    ),
                  ),

                  const SizedBox(width: 10),

                  /// TEXT COLUMN + ICON
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.name.tr,
                                  style: AppTextStyles.body.copyWith(
                                    color: AppColors.primaryColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  widget.type.tr,
                                  style: AppTextStyles.body,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  widget.address.tr,
                                  style: AppTextStyles.hint,
                                ),
                              ],
                            ),
                          ),
                        ),
                        /// FAVORITE ICON
                        IconButton(
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                          onPressed: () {
                            setState(() {
                              isFavorite = !isFavorite; // toggle favorite
                            });
                            if (widget.onFavoriteTap != null) {
                              widget.onFavoriteTap!();
                            }
                          },
                          icon: Icon(
                            isFavorite
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color:AppColors.primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                AppStrings.service.tr,
                style: AppTextStyles.title.copyWith(
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            const SizedBox(height: 6),
            SizedBox(
              height: 30,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                itemCount: widget.services.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.only(right: 5),
                    width: 100,
                    padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    decoration: BoxDecoration(
                      color: AppColors.greyColor.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Center(child: Text(widget.services[index])),
                  );
                },
              ),
            ),
            const SizedBox(height: 12),

            /// ---------- AVAILABILITY ----------
            Container(
              color: AppColors.primaryColor.withOpacity(0.1),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Row(
                      children:  [
                        Icon(
                          Icons.calendar_month,
                          size: 18,
                          color: AppColors.primaryColor,
                        ),
                        SizedBox(width: 6),
                        Text(
                          AppStrings.availability.tr,

                          style: AppTextStyles.body,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: Dimensions.h(10)),
                  SizedBox(
                    height: 80,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      itemCount: widget.availability.length,
                      itemBuilder: (context, index) {
                        String day = widget.availability.keys.elementAt(index);
                        String time = widget.availability[day]!;
                        return Container(
                          width: 220,
                          margin: const EdgeInsets.only(right: 5),
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: AppColors.primaryColor.withOpacity(0.9),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                day,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                time,
                                style: AppTextStyles.body.copyWith(
                                  fontSize: 12,
                                  color: AppColors.whiteColor,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 5),
                  SizedBox(
                    width: double.infinity,
                    child: TextButton(
                      onPressed: widget.onViewDetails ?? () {},
                      child: Text(
                        AppStrings.viewDetails.tr,

                        style: AppTextStyles.hint.copyWith(
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // ... rest of your code unchanged
          ],
        ),
      ),
    );
  }
}


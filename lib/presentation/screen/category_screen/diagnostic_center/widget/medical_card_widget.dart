import 'package:flutter/material.dart';
import '../../../../../core/responsive_layout/dimensions/dimensions.dart';
import '../../../../../utils/app_colors/app_colors.dart';
import '../../../../../utils/app_text_style/app_text_style.dart';

class MedicalServiceCard extends StatefulWidget {
  final String name;
  final String type;
  final String address;
  final String imagePath;
  final List<String> services;

  final VoidCallback? onFavoriteTap;
  final VoidCallback? onViewDetails;

  const MedicalServiceCard({
    super.key,
    required this.name,
    required this.type,
    required this.address,
    required this.imagePath,
    required this.services,
    this.onFavoriteTap,
    this.onViewDetails,
  });

  @override
  State<MedicalServiceCard> createState() => _MedicalServiceCardState();
}

class _MedicalServiceCardState extends State<MedicalServiceCard> {
  bool isFavorite = false;

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
                    borderRadius: BorderRadius.circular(5),
                    child: Image.asset(
                      widget.imagePath,
                      width: 116,
                      height: 98,
                      fit: BoxFit.cover,
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
                                  widget.name,
                                  style: AppTextStyles.body.copyWith(
                                    color: AppColors.primaryColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  widget.type,
                                  style: AppTextStyles.body,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  widget.address,
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
                              isFavorite = !isFavorite;
                            });
                            if (widget.onFavoriteTap != null) {
                              widget.onFavoriteTap!();
                            }
                          },
                          icon: Icon(
                            isFavorite
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: isFavorite
                                ? Colors.red
                                : AppColors.primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            /// ---------- SERVICES ----------
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                "Service",
                style: AppTextStyles.title.copyWith(
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            const SizedBox(height: 2),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3),
              child: Wrap(
                spacing: 3,
                children: widget.services
                    .map((s) => Chip(label: Text(s,style: AppTextStyles.body.copyWith(
                  fontSize: 12,
                ),),
                  padding: EdgeInsets.all(0),
                  backgroundColor: AppColors.greyColor.withOpacity(0.3),

                ))

                    .toList(),
              ),
            ),
            const SizedBox(height: 2),

            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: widget.onViewDetails ?? () {},
                child: Text(
                  "View Details",
                  style: AppTextStyles.hint.copyWith(
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
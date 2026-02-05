import 'package:flutter/material.dart';
import '../../../../../core/responsive_layout/dimensions/dimensions.dart';
import '../../../../../utils/app_colors/app_colors.dart';
import '../../../../../utils/app_text_style/app_text_style.dart';

class DoctorsCard extends StatefulWidget {
  final String name;
  final String type;
  final String address;
  final String imagePath;
  final List<String> services;
  final Map<String, String> availability; // e.g., {"Saturday": "6:30 PM - 10:30 PM"}
  final VoidCallback? onFavoriteTap;
  final VoidCallback? onViewDetails;

  const DoctorsCard({
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
  State<DoctorsCard> createState() => _DoctorsCardState();
}

class _DoctorsCardState extends State<DoctorsCard> {
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
                    child: widget.imagePath.startsWith('http')
                        ? Image.network(
                      widget.imagePath,
                      width: 116,
                      height: 98,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          width: 116,
                          height: 98,
                          color: AppColors.greyColor,
                          child: const Icon(
                            Icons.person,
                            color: Colors.white,
                            size: 40,
                          ),
                        );
                      },
                    )
                        : Image.asset(
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
                            widget.onFavoriteTap?.call();
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

            /// ---------- SERVICES ----------
            if (widget.services.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  "Services",
                  style: AppTextStyles.title.copyWith(
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            const SizedBox(height: 6),
            if (widget.services.isNotEmpty)
              SizedBox(
                height: 30,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  itemCount: widget.services.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.only(right: 5),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 5),
                      decoration: BoxDecoration(
                        color: AppColors.greyColor.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Center(
                        child: Text(
                          widget.services[index],
                          style: AppTextStyles.body.copyWith(fontSize: 12),
                        ),
                      ),
                    );
                  },
                ),
              ),
            const SizedBox(height: 12),

            /// ---------- AVAILABILITY ----------
            if (widget.availability.isNotEmpty)
              Container(
                color: AppColors.primaryColor.withOpacity(0.1),
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Row(
                        children: const [
                          Icon(
                            Icons.calendar_month,
                            size: 18,
                            color: AppColors.primaryColor,
                          ),
                          SizedBox(width: 6),
                          Text(
                            "Availability",
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
          ],
        ),
      ),
    );
  }
}

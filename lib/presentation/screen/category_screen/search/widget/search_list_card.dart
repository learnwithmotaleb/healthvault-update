import 'package:flutter/material.dart';
import '../../../../../core/responsive_layout/dimensions/dimensions.dart';
import '../../../../../utils/app_colors/app_colors.dart';
import '../../../../../utils/app_text_style/app_text_style.dart';


class SearchListCard extends StatelessWidget {
  final String name;
  final String type;
  final String address;
  final String imagePath;
  final List<String> services;
  final bool isFavorite;
  final VoidCallback? onFavoriteTap;
  final VoidCallback? onViewDetails;


  const SearchListCard({
    super.key,
    required this.name,
    required this.type,
    required this.address,
    required this.imagePath,
    required this.services,
    this.onFavoriteTap,
    required this.isFavorite,
    this.onViewDetails,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.whiteColor,
          border: Border.all(color: AppColors.primaryColor),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(5),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// IMAGE
                  Expanded(
                    flex: 2,
                    child: Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8), // smoother edges
                        child: AspectRatio(
                          aspectRatio: 1, // keep it square
                          child: imagePath.isNotEmpty
                              ? Image.network(
                            imagePath,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) => Container(
                              color: AppColors.greyColor.withOpacity(0.3),
                              child: Icon(Icons.person, size: 50, color: AppColors.primaryColor),
                            ),
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Center(
                                child: CircularProgressIndicator(
                                  value: loadingProgress.expectedTotalBytes != null
                                      ? loadingProgress.cumulativeBytesLoaded / (loadingProgress.expectedTotalBytes ?? 1)
                                      : null,
                                  color: AppColors.primaryColor,
                                ),
                              );
                            },
                          )
                              : Container(
                            color: AppColors.greyColor.withOpacity(0.3),
                            child: Icon(Icons.person, size: 50, color: AppColors.primaryColor),
                          ),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(width: Dimensions.w(8)),

                  /// TEXT + FAVORITE
                  Expanded(
                    flex: 4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    name,
                                    style: AppTextStyles.body.copyWith(
                                      color: AppColors.primaryColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(type,
                                      style: AppTextStyles.body),
                                  const SizedBox(height: 4),
                                  Text(address,
                                      style: AppTextStyles.hint),
                                ],
                              ),
                            ),
                            /// ✅ FAVORITE ICON — driven purely by controller
                            IconButton(
                              padding: EdgeInsets.zero,
                              constraints: BoxConstraints(),
                              onPressed: onFavoriteTap != null
                                  ? () => onFavoriteTap!()
                                  : null,
                              icon: Icon(
                                isFavorite
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: AppColors.primaryColor,
                              ),
                            ),


                          ],
                        ),
                        Text(
                          "Service",
                          style: AppTextStyles.body.copyWith(
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        SizedBox(
                          height:  Dimensions.w(25),
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: services.length,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: const EdgeInsets.only(right: 5),
                                decoration: BoxDecoration(
                                  color: AppColors.greyColor.withOpacity(0.4),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 2.0,vertical: 2.0),
                                    child: Text(
                                      services[index],
                                      style: AppTextStyles.hint.copyWith(
                                        fontSize: 12
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),


                      ],
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



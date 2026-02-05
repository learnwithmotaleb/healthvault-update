import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:healthvault/presentation/widget/custom_appbar.dart';
import 'package:healthvault/utils/app_text_style/app_text_style.dart';

import '../../../../../core/responsive_layout/dimensions/dimensions.dart';
import '../../../../../utils/app_colors/app_colors.dart';
import '../../../../../utils/assets_image/app_images.dart';
import '../../../../../utils/static_strings/static_strings.dart';
import '../controller/notification_controller.dart';
import '../widget/notification_item_widget.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final NotificationController controller =
  Get.put(NotificationController());

  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        controller.loadMoreNotifications();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CommonAppBar(title: AppStrings.notification.tr),

      body: Obx(() {
        return ListView(
          controller: scrollController,
          padding: EdgeInsets.all(10),
          children: [

            ...[
              /// ================= Header Card =================
              Container(
                height: Dimensions.h(72),
                padding: EdgeInsets.symmetric(horizontal: Dimensions.w(12)),
                decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  borderRadius: BorderRadius.circular(Dimensions.r(10)),
                  border: Border.all(
                    color: AppColors.primaryColor,
                    width: Dimensions.w(1),
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(Dimensions.r(6)),
                      child: Image.asset(
                        AppImages.appLogo,
                        width: Dimensions.w(100),
                        height: Dimensions.w(30),
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(width: Dimensions.w(10)),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: TextSpan(
                            style: AppTextStyles.body.copyWith(
                              fontSize: Dimensions.f(12),
                            ),
                            children: [
                              TextSpan(text: AppStrings.welcomeBack.tr),
                              TextSpan(
                                text: AppStrings.appName,
                                style: AppTextStyles.body.copyWith(
                                  fontSize: Dimensions.f(12),
                                  color: AppColors.primaryColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: Dimensions.h(4)),
                        Text(
                          'Fri, 12 AM',
                          style: AppTextStyles.body.copyWith(
                            fontSize: Dimensions.f(11),
                            color: AppColors.greyColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              SizedBox(height: Dimensions.h(16)),

              /// ================= Notifications or Empty =================
              if (controller.notificationList.isEmpty)
                if (controller.isLoading.value)
                  const Center(
                    child: CircularProgressIndicator(color: AppColors.primaryColor),
                  )
                else
                  Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: Dimensions.h(50)),
                      child: Text(
                        "No notification found",
                        style: AppTextStyles.body.copyWith(
                          fontSize: Dimensions.f(14),
                          color: AppColors.greyColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  )
              else
                ...List.generate(
                  controller.notificationList.length,
                      (index) {
                    final item = controller.notificationList[index];
                    return notificationItem(
                      id: item.sId ?? "",
                      title: item.title ?? "",
                      message: item.message ?? "",
                      onDelete: () {
                        controller.deleteNotification(item.sId ?? "");
                      },
                    );
                  },
                ),

              /// ================= Bottom Loader =================
              if (controller.hasMore.value)
                Padding(
                  padding: EdgeInsets.all(Dimensions.h(16)),
                  child: const Center(
                    child: CircularProgressIndicator(color: AppColors.primaryColor),
                  ),
                ),
            ],

          ],
        );
      }),
    );
  }
}


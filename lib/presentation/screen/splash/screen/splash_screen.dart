import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthvault/core/routes/route_path.dart';
import 'package:healthvault/utils/assets_image/app_images.dart';
import '../../../../helper/local_db/local_db.dart';
import '../../../../utils/app_colors/app_colors.dart';
import '../controller/splash_controller.dart';
import '../../../../helper/local_db/shareprefs_helper.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final SplashController _controller = Get.put(SplashController());

  @override
  void initState() {
    super.initState();
    _navigateBasedOnRole();
  }

  void _navigateBasedOnRole() {
    // Read token & role from shared preferences
    final token = SharePrefsHelper.getToken();
    final role = SharePrefsHelper.getRole()?.toUpperCase(); // USER / PROVIDER

    String nextRoute;

    if (token == null || token.isEmpty) {
      nextRoute = RoutePath.onboard; // no token → go to login
    } else {
      if (role == 'NORMALUSER') {
        nextRoute = RoutePath.bottomNav;
      } else if (role == 'PROVIDER') {
        nextRoute = RoutePath.providerNav;
      } else {
        nextRoute = RoutePath.login; // fallback
      }
    }

    // Start splash timer with the calculated next route
    _controller.start(nextRoute: nextRoute);
  }

  @override
  void dispose() {
    _controller.cancel(); // safety: cancel timer if leaving early
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF31CAF5).withOpacity(0.5),
              Color(0xFFED11F4).withOpacity(0.3),
            ],
          ),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Center(child: Image.asset(AppImages.appLogo)),
            Positioned(
              top: 10,
              right: 0,
              child: Image.asset(AppImages.splashOverLay2),
            ),
            Positioned(
              left: 0,
              bottom: 0,
              child: Opacity(
                opacity: 0.2,
                child: Image.asset(AppImages.splashOverLay1),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

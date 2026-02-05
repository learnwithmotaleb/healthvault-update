
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Responsive scaling helpers based on a base design size.
/// Base Figma: 390 x 844 (iPhone 12).
class Dimensions {
  // Base design (Figma reference)
  static const double baseWidth = 390.0;
  static const double baseHeight = 844.0;

  // Live screen size
  static double get screenWidth => Get.width;
  static double get screenHeight => Get.height;

  // Orientation-aware sides
  static double get shortestSide => screenWidth < screenHeight ? screenWidth : screenHeight;
  static double get longestSide => screenWidth > screenHeight ? screenWidth : screenHeight;

  // Safely read context-bound metrics (may be null early in app lifecycle)
  static MediaQueryData? get _mq => Get.context != null ? MediaQuery.of(Get.context!) : null;
  static double get pixelRatio => _mq?.devicePixelRatio ?? 2.0;
  static double get textScale => _mq?.textScaleFactor ?? 1.0;

  /// Scale width from base width
  static double w(double value) => value * (screenWidth / baseWidth);

  /// Scale height from base height
  static double h(double value) => value * (screenHeight / baseHeight);

  /// Responsive font size based on shortest side (more stable on rotation).
  /// Respects user's system textScaleFactor by default.
  static double f(double size, {bool respectTextScale = true}) {
    final scaled = size * (shortestSide / baseWidth);
    return respectTextScale ? scaled * textScale : scaled;
  }

  /// Radius proportional to width
  static double r(double radius) => radius * (screenWidth / baseWidth);

  /// Insets helpers
  static EdgeInsets pAll(double v) => EdgeInsets.all(w(v));

  /// NOTE: fixed bug: vertical now uses h(v)
  static EdgeInsets pSym({double h = 16, double v = 16}) =>
      EdgeInsets.symmetric(horizontal: w(h), vertical: Dimensions.h(v));

  static EdgeInsets pOnly({double l = 0, double t = 0, double rgt = 0, double b = 0}) =>
      EdgeInsets.only(left: w(l), top: Dimensions.h(t), right: w(rgt), bottom: Dimensions.h(b));

  // Common paddings
  static EdgeInsets get pSmall => pAll(8);
  static EdgeInsets get pMedium => pAll(16);
  static EdgeInsets get pLarge => pAll(24);

  // Common gaps
  static SizedBox gapW(double v) => SizedBox(width: w(v));
  static SizedBox gapH(double v) => SizedBox(height: h(v));

  /// Safe areas (fallback to zero if context null)
  static EdgeInsets get safePadding => _mq?.padding ?? EdgeInsets.zero;

  /// Breakpoints
  static bool get isMobile => screenWidth < 600;
  static bool get isTablet => screenWidth >= 600 && screenWidth < 1024;
  static bool get isDesktop => screenWidth >= 1024;

  /// Optional clamps to avoid extreme scaling on tiny/huge screens.
  static double clampFont(double value, {double min = 10, double max = 24}) =>
      value.clamp(min, max);
  static double clampSpace(double value, {double min = 4, double max = 32}) =>
      value.clamp(min, max);
}

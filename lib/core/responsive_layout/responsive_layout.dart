
import 'package:flutter/material.dart';

import 'dimensions/dimensions.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget? desktop;

  const ResponsiveLayout({
    super.key,
    required this.mobile,
    this.tablet,
    this.desktop,
  });

  @override
  Widget build(BuildContext context) {
    if (Dimensions.isDesktop && desktop != null) return desktop!;
    if (Dimensions.isTablet && tablet != null) return tablet!;
    return mobile;
  }
}

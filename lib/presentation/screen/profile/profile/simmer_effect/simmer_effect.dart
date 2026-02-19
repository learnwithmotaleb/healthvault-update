import 'package:flutter/material.dart';
import '../../../../../core/responsive_layout/dimensions/dimensions.dart';
import '../../../../../utils/app_colors/app_colors.dart';

// ─────────────────────────────────────────────
//  Core shimmer animator
// ─────────────────────────────────────────────
class ShimmerBox extends StatefulWidget {
  final double width;
  final double height;
  final double borderRadius;
  final bool isCircle;

  const ShimmerBox({
    super.key,
    required this.width,
    required this.height,
    this.borderRadius = 8,
    this.isCircle = false,
  });

  @override
  State<ShimmerBox> createState() => _ShimmerBoxState();
}

class _ShimmerBoxState extends State<ShimmerBox>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..repeat();
    _animation = Tween<double>(begin: -1.5, end: 1.5).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, _) {
        return Container(
          width: widget.isCircle ? widget.height : widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            borderRadius: widget.isCircle
                ? BorderRadius.circular(widget.height / 2)
                : BorderRadius.circular(widget.borderRadius),
            gradient: LinearGradient(
              begin: Alignment(_animation.value - 1, 0),
              end: Alignment(_animation.value + 1, 0),
              colors: const [
                Color(0xFFE8E8E8),
                Color(0xFFF5F5F5),
                Color(0xFFEEEEEE),
              ],
              stops: const [0.0, 0.5, 1.0],
            ),
          ),
        );
      },
    );
  }
}

// ─────────────────────────────────────────────
//  Profile header card shimmer
//  Mirrors: Avatar + Name + Phone + Email + Edit button
// ─────────────────────────────────────────────
class ProfileHeaderShimmer extends StatelessWidget {
  const ProfileHeaderShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: Dimensions.h(180),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: AppColors.whiteColor,
        boxShadow: [
          BoxShadow(
            color: AppColors.greyColor.withOpacity(0.2),
            blurRadius: 1,
            offset: const Offset(0, 1),
            spreadRadius: 0.5,
          ),
        ],
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Avatar
              ShimmerBox(width: 80, height: 80, isCircle: true),
              SizedBox(width: Dimensions.w(30)),
              // Name + phone + email
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ShimmerBox(width: 150, height: 16),
                    SizedBox(height: Dimensions.h(8)),
                    // Phone row
                    Row(
                      children: [
                        ShimmerBox(width: 18, height: 18, isCircle: true),
                        const SizedBox(width: 8),
                        ShimmerBox(width: 120, height: 12),
                      ],
                    ),
                    SizedBox(height: Dimensions.h(6)),
                    // Email row
                    Row(
                      children: [
                        ShimmerBox(width: 18, height: 18, isCircle: true),
                        const SizedBox(width: 8),
                        ShimmerBox(width: 140, height: 12),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: Dimensions.h(12)),
          // Edit profile button (aligned right)
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: ShimmerBox(
                width: Dimensions.w(100),
                height: Dimensions.w(40),
                borderRadius: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  Single menu item shimmer
//  Mirrors: Leading icon + title + trailing arrow
// ─────────────────────────────────────────────
class ProfileMenuItemShimmer extends StatelessWidget {
  const ProfileMenuItemShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          ShimmerBox(width: 22, height: 22, isCircle: true),
          const SizedBox(width: 16),
          Expanded(child: ShimmerBox(width: double.infinity, height: 13)),
          const SizedBox(width: 16),
          ShimmerBox(width: 18, height: 18, isCircle: true),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  Section title shimmer  (e.g. "More")
// ─────────────────────────────────────────────
class ProfileSectionTitleShimmer extends StatelessWidget {
  const ProfileSectionTitleShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: ShimmerBox(width: 60, height: 13),
    );
  }
}

// ─────────────────────────────────────────────
//  Full profile page shimmer
//  Mirrors exact structure of ProfileScreen
// ─────────────────────────────────────────────
class ProfileScreenShimmer extends StatelessWidget {
  const ProfileScreenShimmer({super.key});

  // How many menu items appear before the "More" section
  static const int _topMenuCount = 9;
  // How many menu items appear in the "More" section
  static const int _moreMenuCount = 4;

  Widget _gap(double h) => SizedBox(height: Dimensions.h(h));
  Widget _menuItem() => const ProfileMenuItemShimmer();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Header card ──
          const ProfileHeaderShimmer(),
          _gap(30),

          // ── Top menu items ──
          ...List.generate(
            _topMenuCount,
                (_) => Column(
              children: [
                _menuItem(),
                _gap(10),
              ],
            ),
          ),

          // ── Section title: "More" ──
          const ProfileSectionTitleShimmer(),
          _gap(20),

          // ── More menu items ──
          ...List.generate(
            _moreMenuCount,
                (_) => Column(
              children: [
                _menuItem(),
                _gap(10),
              ],
            ),
          ),

          _gap(20),
        ],
      ),
    );
  }
}
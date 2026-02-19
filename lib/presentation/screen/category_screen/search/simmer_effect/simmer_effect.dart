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
//  Single SearchListCard shimmer
//  Mirrors layout:
//    • Provider image + name + type badge
//    • Address row
//    • Service chips row
//    • Favourite icon (trailing)
// ─────────────────────────────────────────────
class SearchListCardShimmer extends StatelessWidget {
  const SearchListCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Provider image ──
          ShimmerBox(width: 70, height: 70, borderRadius: 10),
          const SizedBox(width: 12),

          // ── Right content ──
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Name + favourite icon
                Row(
                  children: [
                    Expanded(child: ShimmerBox(width: double.infinity, height: 14)),
                    const SizedBox(width: 12),
                    ShimmerBox(width: 24, height: 24, isCircle: true),
                  ],
                ),
                const SizedBox(height: 6),

                // Provider type badge
                ShimmerBox(width: 90, height: 22, borderRadius: 20),
                const SizedBox(height: 8),

                // Address row
                Row(
                  children: [
                    ShimmerBox(width: 14, height: 14, isCircle: true),
                    const SizedBox(width: 6),
                    Expanded(child: ShimmerBox(width: double.infinity, height: 12)),
                  ],
                ),
                const SizedBox(height: 10),

                // Service chips
                Row(
                  children: [
                    ShimmerBox(width: 64, height: 24, borderRadius: 20),
                    const SizedBox(width: 8),
                    ShimmerBox(width: 64, height: 24, borderRadius: 20),
                    const SizedBox(width: 8),
                    ShimmerBox(width: 48, height: 24, borderRadius: 20),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  Full search list shimmer
// ─────────────────────────────────────────────
class SearchListShimmer extends StatelessWidget {
  final int itemCount;

  const SearchListShimmer({super.key, this.itemCount = 6});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      itemCount: itemCount,
      separatorBuilder: (_, __) => SizedBox(height: Dimensions.h(12)),
      itemBuilder: (_, __) => const SearchListCardShimmer(),
    );
  }
}
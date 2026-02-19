import 'package:flutter/material.dart';

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
//  Single CustomInfoCard shimmer
//  Mirrors layout:
//    • Provider image + name + favourite icon
//    • Specialization subtitle
//    • Address row
// ─────────────────────────────────────────────
class FavouriteCardShimmer extends StatelessWidget {
  const FavouriteCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Provider image ──
          ShimmerBox(width: 75, height: 75, borderRadius: 10),
          const SizedBox(width: 12),

          // ── Right content ──
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Name + favourite icon
                Row(
                  children: [
                    Expanded(
                      child: ShimmerBox(width: double.infinity, height: 15),
                    ),
                    const SizedBox(width: 10),
                    ShimmerBox(width: 26, height: 26, isCircle: true),
                  ],
                ),
                const SizedBox(height: 8),

                // Specialization
                ShimmerBox(width: 130, height: 12),
                const SizedBox(height: 10),

                // Address row
                Row(
                  children: [
                    ShimmerBox(width: 14, height: 14, isCircle: true),
                    const SizedBox(width: 6),
                    Expanded(
                      child: ShimmerBox(width: double.infinity, height: 12),
                    ),
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
//  Full favourites list shimmer
// ─────────────────────────────────────────────
class FavouriteListShimmer extends StatelessWidget {
  final int itemCount;

  const FavouriteListShimmer({super.key, this.itemCount = 6});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(12),
      physics: const NeverScrollableScrollPhysics(),
      itemCount: itemCount,
      itemBuilder: (_, __) => const FavouriteCardShimmer(),
    );
  }
}
import 'package:flutter/material.dart';
import '../../../../../core/responsive_layout/dimensions/dimensions.dart';

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
//  Single DoctorsCard shimmer
//  Mirrors layout:
//    • Doctor image + name + favourite icon
//    • Email / type label
//    • Address row
//    • Service chips row
//    • Availability row
//    • View Details button
// ─────────────────────────────────────────────
class DoctorCardShimmer extends StatelessWidget {
  const DoctorCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Row 1: Image + Info + Favourite ──
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Doctor image
              ShimmerBox(width: 80, height: 80, borderRadius: 10),
              const SizedBox(width: 12),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Name + favourite icon
                    Row(
                      children: [
                        Expanded(
                          child: ShimmerBox(
                              width: double.infinity, height: 15),
                        ),
                        const SizedBox(width: 10),
                        ShimmerBox(width: 26, height: 26, isCircle: true),
                      ],
                    ),
                    const SizedBox(height: 7),

                    // Email / type
                    ShimmerBox(width: 130, height: 12),
                    const SizedBox(height: 7),

                    // Address row
                    Row(
                      children: [
                        ShimmerBox(width: 14, height: 14, isCircle: true),
                        const SizedBox(width: 6),
                        Expanded(
                          child: ShimmerBox(
                              width: double.infinity, height: 12),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // ── Service chips ──
          Row(
            children: [
              ShimmerBox(width: 70, height: 26, borderRadius: 20),
              const SizedBox(width: 8),
              ShimmerBox(width: 70, height: 26, borderRadius: 20),
              const SizedBox(width: 8),
              ShimmerBox(width: 50, height: 26, borderRadius: 20),
            ],
          ),

          const SizedBox(height: 12),

          // ── Divider ──
          ShimmerBox(width: double.infinity, height: 1, borderRadius: 0),

          const SizedBox(height: 12),

          // ── Availability row ──
          Row(
            children: [
              ShimmerBox(width: 14, height: 14, isCircle: true),
              const SizedBox(width: 6),
              ShimmerBox(width: 180, height: 12),
            ],
          ),

          const SizedBox(height: 14),

          // ── View Details button ──
          ShimmerBox(
            width: double.infinity,
            height: 42,
            borderRadius: 10,
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  Full doctor list shimmer
// ─────────────────────────────────────────────
class DoctorListShimmer extends StatelessWidget {
  final int itemCount;

  const DoctorListShimmer({super.key, this.itemCount = 5});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      physics: const NeverScrollableScrollPhysics(),
      itemCount: itemCount,
      itemBuilder: (_, __) => const DoctorCardShimmer(),
    );
  }
}
import 'package:flutter/material.dart';

// ─────────────────────────────────────────────
//  Core shimmer animator (reuse from home_shimmer.dart
//  or keep this standalone copy)
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
//  Single appointment card shimmer
//  Mirrors your AppointmentCard layout:
//    • Doctor name + service title
//    • Price chip + date-time
//    • Status badge
// ─────────────────────────────────────────────
class AppointmentCardShimmer extends StatelessWidget {
  const AppointmentCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
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
          // ── Row 1: Avatar + Name + Status badge ──
          Row(
            children: [
              ShimmerBox(width: 48, height: 48, isCircle: true),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ShimmerBox(width: 160, height: 14),
                    const SizedBox(height: 6),
                    ShimmerBox(width: 110, height: 12),
                  ],
                ),
              ),
              // Status badge placeholder
              ShimmerBox(width: 72, height: 26, borderRadius: 20),
            ],
          ),

          const SizedBox(height: 14),

          // ── Divider ──
          ShimmerBox(width: double.infinity, height: 1, borderRadius: 0),

          const SizedBox(height: 14),

          // ── Row 2: Date-time + Price ──
          Row(
            children: [
              ShimmerBox(width: 20, height: 20, isCircle: true),
              const SizedBox(width: 8),
              ShimmerBox(width: 140, height: 12),
              const Spacer(),
              ShimmerBox(width: 70, height: 28, borderRadius: 8),
            ],
          ),

          const SizedBox(height: 10),

          // ── Row 3: Service label ──
          Row(
            children: [
              ShimmerBox(width: 20, height: 20, isCircle: true),
              const SizedBox(width: 8),
              ShimmerBox(width: 120, height: 12),
            ],
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  Full appointment list shimmer
//  Drop this in wherever isLoading == true
// ─────────────────────────────────────────────
class AppointmentListShimmer extends StatelessWidget {
  /// Number of skeleton cards to show while loading
  final int itemCount;

  const AppointmentListShimmer({super.key, this.itemCount = 6});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Column(
        children: List.generate(
          itemCount,
              (_) => const AppointmentCardShimmer(),
        ),
      ),
    );
  }
}
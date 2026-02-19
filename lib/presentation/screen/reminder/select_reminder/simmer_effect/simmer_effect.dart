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
//  Single ReminderCard shimmer
//  Mirrors layout:
//    • Pill icon + name + dosage badge
//    • Progress bar
//    • Times per day chips row
//    • Start / End date row
//    • Instructions + Assigned to row
//    • Edit / Delete action buttons
// ─────────────────────────────────────────────
class ReminderCardShimmer extends StatelessWidget {
  const ReminderCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
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
          // ── Row 1: Pill icon + name + dosage badge ──
          Row(
            children: [
              ShimmerBox(width: 44, height: 44, isCircle: true),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ShimmerBox(width: 140, height: 14),
                    const SizedBox(height: 6),
                    ShimmerBox(width: 90, height: 12),
                  ],
                ),
              ),
              // Dosage badge
              ShimmerBox(width: 64, height: 28, borderRadius: 20),
            ],
          ),

          const SizedBox(height: 14),

          // ── Progress bar ──
          ShimmerBox(width: double.infinity, height: 8, borderRadius: 4),
          const SizedBox(height: 6),
          // Progress label (e.g. "Day 3 of 10")
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ShimmerBox(width: 80, height: 10),
              ShimmerBox(width: 50, height: 10),
            ],
          ),

          const SizedBox(height: 14),

          // ── Time chips row ──
          Row(
            children: [
              ShimmerBox(width: 56, height: 28, borderRadius: 20),
              const SizedBox(width: 8),
              ShimmerBox(width: 56, height: 28, borderRadius: 20),
              const SizedBox(width: 8),
              ShimmerBox(width: 56, height: 28, borderRadius: 20),
            ],
          ),

          const SizedBox(height: 14),

          // ── Divider ──
          ShimmerBox(width: double.infinity, height: 1, borderRadius: 0),

          const SizedBox(height: 14),

          // ── Start / End date row ──
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ShimmerBox(width: 60, height: 10),
                    const SizedBox(height: 6),
                    ShimmerBox(width: 90, height: 13),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ShimmerBox(width: 60, height: 10),
                    const SizedBox(height: 6),
                    ShimmerBox(width: 90, height: 13),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),

          // ── Instructions row ──
          Row(
            children: [
              ShimmerBox(width: 18, height: 18, isCircle: true),
              const SizedBox(width: 8),
              ShimmerBox(width: 200, height: 12),
            ],
          ),

          const SizedBox(height: 8),

          // ── Assigned to row ──
          Row(
            children: [
              ShimmerBox(width: 18, height: 18, isCircle: true),
              const SizedBox(width: 8),
              ShimmerBox(width: 130, height: 12),
            ],
          ),

          const SizedBox(height: 16),

          // ── Edit / Delete action buttons ──
          Row(
            children: [
              Expanded(
                child: ShimmerBox(
                  width: double.infinity,
                  height: 40,
                  borderRadius: 10,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ShimmerBox(
                  width: double.infinity,
                  height: 40,
                  borderRadius: 10,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  Full reminder list shimmer
// ─────────────────────────────────────────────
class ReminderListShimmer extends StatelessWidget {
  final int itemCount;

  const ReminderListShimmer({super.key, this.itemCount = 5});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(12),
      physics: const NeverScrollableScrollPhysics(),
      itemCount: itemCount,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (_, __) => const ReminderCardShimmer(),
    );
  }
}
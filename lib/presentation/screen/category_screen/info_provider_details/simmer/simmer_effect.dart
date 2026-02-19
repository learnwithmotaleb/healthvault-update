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
//  InfoProviderDetails full page shimmer
//  Mirrors layout:
//    • Profile avatar (center)
//    • Specialization row
//    • Address block
//    • Services list (3 items)
//    • Appointment form fields:
//        - Reason text field
//        - Date picker field
//        - Time picker field
//        - Document upload box
//    • Book Appointment button
// ─────────────────────────────────────────────
class InfoProviderDetailsShimmer extends StatelessWidget {
  const InfoProviderDetailsShimmer({super.key});

  Widget _label(double width) => ShimmerBox(width: width, height: 13);
  Widget _field() =>
      ShimmerBox(width: double.infinity, height: 52, borderRadius: 10);
  Widget _gap(double h) => SizedBox(height: Dimensions.h(h));

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Profile avatar ──
          Center(
            child: ShimmerBox(width: 100, height: 100, isCircle: true),
          ),
          _gap(10),

          // ── Specialization row ──
          Row(
            children: [
              ShimmerBox(width: 110, height: 13),
              const Spacer(),
              ShimmerBox(width: 90, height: 13),
            ],
          ),
          _gap(10),

          // ── Address label + value ──
          _label(60),
          const SizedBox(height: 4),
          ShimmerBox(width: double.infinity, height: 13),
          _gap(4),
          ShimmerBox(width: 220, height: 13),
          _gap(10),

          // ── Services heading ──
          ShimmerBox(width: 80, height: 16),
          const SizedBox(height: 8),

          // ── 3 service items ──
          ...List.generate(
            3,
                (_) => Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: ShimmerBox(width: 200, height: 13),
            ),
          ),

          _gap(20),

          // ── Reason for visit ──
          _label(120),
          _gap(10),
          _field(),
          _gap(10),

          // ── Select date ──
          _label(100),
          _gap(10),
          _field(),
          _gap(10),

          // ── Select time ──
          _label(100),
          _gap(10),
          _field(),
          _gap(12),

          // ── Add document label ──
          _label(100),
          _gap(12),

          // ── Upload box (90 × 90) ──
          ShimmerBox(
            width: Dimensions.w(90),
            height: Dimensions.h(90),
            borderRadius: 10,
          ),
          _gap(30),

          // ── Book Appointment button ──
          ShimmerBox(
            width: double.infinity,
            height: 50,
            borderRadius: 12,
          ),
          _gap(100),
        ],
      ),
    );
  }
}
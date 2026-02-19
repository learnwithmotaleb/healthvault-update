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
      builder: (context, child) {
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
//  Header shimmer (avatar + title + search bar)
// ─────────────────────────────────────────────
class HomeHeaderShimmer extends StatelessWidget {
  const HomeHeaderShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 223,
      decoration: const BoxDecoration(
        color: Color(0xFF1565C0), // match your primaryColor
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(16),
          bottomLeft: Radius.circular(16),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              // Avatar
              _WhiteShimmerBox(width: 60, height: 60, isCircle: true),
              const SizedBox(width: 12),
              // Name + subtitle
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _WhiteShimmerBox(width: 140, height: 16),
                  const SizedBox(height: 8),
                  _WhiteShimmerBox(width: 90, height: 12),
                ],
              ),
              const Spacer(),
              // Notification button
              _WhiteShimmerBox(width: 40, height: 40, isCircle: true),
            ],
          ),
          const SizedBox(height: 16),
          // Search bar
          _WhiteShimmerBox(
            width: double.infinity,
            height: 48,
            borderRadius: 12,
          ),
        ],
      ),
    );
  }
}

// White-tinted shimmer for use on colored backgrounds
class _WhiteShimmerBox extends StatefulWidget {
  final double width;
  final double height;
  final double borderRadius;
  final bool isCircle;

  const _WhiteShimmerBox({
    required this.width,
    required this.height,
    this.borderRadius = 8,
    this.isCircle = false,
  });

  @override
  State<_WhiteShimmerBox> createState() => __WhiteShimmerBoxState();
}

class __WhiteShimmerBoxState extends State<_WhiteShimmerBox>
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
              begin: Alignment(widget.isCircle
                  ? _animation.value - 1
                  : _animation.value - 1, 0),
              end: Alignment(_animation.value + 1, 0),
              colors: const [
                Color(0x33FFFFFF),
                Color(0x66FFFFFF),
                Color(0x33FFFFFF),
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
//  Category grid shimmer (3 columns of cards)
// ─────────────────────────────────────────────
class HomeCategoryShimmer extends StatelessWidget {
  const HomeCategoryShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: LayoutBuilder(
        builder: (context, constraints) {
          const spacing = 10.0;
          final itemWidth = (constraints.maxWidth - spacing * 2) / 3;

          return Wrap(
            spacing: spacing,
            runSpacing: spacing,
            children: List.generate(
              6,
                  (_) => _CategoryCardShimmer(width: itemWidth),
            ),
          );
        },
      ),
    );
  }
}

class _CategoryCardShimmer extends StatelessWidget {
  final double width;
  const _CategoryCardShimmer({required this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          ShimmerBox(width: 40, height: 40, isCircle: true),
          const SizedBox(height: 8),
          ShimmerBox(width: width - 24, height: 12),
          const SizedBox(height: 4),
          ShimmerBox(width: (width - 24) * 0.6, height: 12),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  Provider card shimmer (pharmacy card style)
// ─────────────────────────────────────────────
class HomeProviderCardShimmer extends StatelessWidget {
  const HomeProviderCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      child: Container(
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
            // Image placeholder
            ShimmerBox(width: 80, height: 80, borderRadius: 10),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ShimmerBox(width: 150, height: 14),
                  const SizedBox(height: 8),
                  ShimmerBox(width: 100, height: 12),
                  const SizedBox(height: 8),
                  ShimmerBox(width: double.infinity, height: 12),
                  const SizedBox(height: 6),
                  ShimmerBox(width: double.infinity, height: 12),
                  const SizedBox(height: 12),
                  // Tag chips
                  Row(
                    children: [
                      ShimmerBox(width: 60, height: 24, borderRadius: 20),
                      const SizedBox(width: 8),
                      ShimmerBox(width: 60, height: 24, borderRadius: 20),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  Article shimmer (horizontal scroll cards)
// ─────────────────────────────────────────────
class HomeArticleShimmer extends StatelessWidget {
  const HomeArticleShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section header
          Row(
            children: [
              ShimmerBox(width: 180, height: 14),
              const Spacer(),
              ShimmerBox(width: 60, height: 14),
            ],
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 200,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: 3,
              padding: const EdgeInsets.symmetric(horizontal: 5),
              separatorBuilder: (_, __) => const SizedBox(width: 10),
              itemBuilder: (_, __) => ShimmerBox(
                width: 280,
                height: 200,
                borderRadius: 5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  Full home shimmer — combine all sections
// ─────────────────────────────────────────────
class HomeScreenShimmer extends StatelessWidget {
  const HomeScreenShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Column(
        children: [
          // Header
          const HomeHeaderShimmer(),

          // Category grid
          const HomeCategoryShimmer(),

          // Emergency card placeholder
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            child: ShimmerBox(
              width: double.infinity,
              height: 90,
              borderRadius: 14,
            ),
          ),

          const SizedBox(height: 6),

          // Provider cards
          ...List.generate(3, (_) => const HomeProviderCardShimmer()),

          const SizedBox(height: 10),

          // Articles
          const HomeArticleShimmer(),

          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
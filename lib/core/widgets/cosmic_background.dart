import 'dart:math';
import 'package:flutter/material.dart';
import '../theme/cosmic_theme.dart';

class CosmicBackground extends StatefulWidget {
  final Widget child;
  final bool showStars;
  final bool animated;

  const CosmicBackground({
    super.key,
    required this.child,
    this.showStars = true,
    this.animated = true,
  });

  @override
  State<CosmicBackground> createState() => _CosmicBackgroundState();
}

class _CosmicBackgroundState extends State<CosmicBackground>
    with TickerProviderStateMixin {
  late AnimationController _starController;
  late List<Star> _stars;

  @override
  void initState() {
    super.initState();
    _starController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);

    _stars = List.generate(80, (_) => Star.random());
  }

  @override
  void dispose() {
    _starController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: CosmicTheme.cosmicGradient,
      ),
      child: Stack(
        children: [
          if (widget.showStars)
            AnimatedBuilder(
              animation: _starController,
              builder: (context, _) => CustomPaint(
                painter: StarPainter(
                  stars: _stars,
                  animationValue: _starController.value,
                ),
                size: Size.infinite,
              ),
            ),
          // Nebula glow effect
          Positioned(
            top: -100,
            right: -100,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    CosmicTheme.nebulaPurple.withOpacity(0.15),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: -50,
            left: -50,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    CosmicTheme.celestialTeal.withOpacity(0.1),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          widget.child,
        ],
      ),
    );
  }
}

class Star {
  final double x;
  final double y;
  final double size;
  final double opacity;
  final double twinkleSpeed;

  Star({
    required this.x,
    required this.y,
    required this.size,
    required this.opacity,
    required this.twinkleSpeed,
  });

  factory Star.random() {
    final random = Random();
    return Star(
      x: random.nextDouble(),
      y: random.nextDouble(),
      size: random.nextDouble() * 2 + 0.5,
      opacity: random.nextDouble() * 0.7 + 0.3,
      twinkleSpeed: random.nextDouble() * 2 + 1,
    );
  }
}

class StarPainter extends CustomPainter {
  final List<Star> stars;
  final double animationValue;

  StarPainter({required this.stars, required this.animationValue});

  @override
  void paint(Canvas canvas, Size size) {
    for (final star in stars) {
      final opacity =
          (star.opacity * (0.5 + 0.5 * sin(animationValue * star.twinkleSpeed * pi)))
              .clamp(0.0, 1.0);

      final paint = Paint()
        ..color = Colors.white.withOpacity(opacity)
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, star.size * 0.5);

      canvas.drawCircle(
        Offset(star.x * size.width, star.y * size.height),
        star.size,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant StarPainter oldDelegate) => true;
}

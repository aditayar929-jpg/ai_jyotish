import 'dart:math';
import 'package:flutter/material.dart';
import '../theme/cosmic_theme.dart';
import '../constants/app_strings.dart';

class AnimatedZodiacIcon extends StatefulWidget {
  final String zodiacSign;
  final double size;
  final bool isSelected;

  const AnimatedZodiacIcon({
    super.key,
    required this.zodiacSign,
    this.size = 40,
    this.isSelected = false,
  });

  @override
  State<AnimatedZodiacIcon> createState() => _AnimatedZodiacIconState();
}

class _AnimatedZodiacIconState extends State<AnimatedZodiacIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _glowAnimation;
  late Animation<double> _rotateAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);

    _glowAnimation = Tween<double>(begin: 0.3, end: 0.8).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _rotateAnimation = Tween<double>(begin: -0.05, end: 0.05).animate(
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
    final symbol = AppStrings.zodiacSymbols[widget.zodiacSign] ?? '⭐';

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.rotate(
          angle: _rotateAnimation.value,
          child: Container(
            width: widget.size,
            height: widget.size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  CosmicTheme.stardustGold
                      .withOpacity(widget.isSelected ? 0.4 : 0.15),
                  CosmicTheme.nebulaPurple
                      .withOpacity(widget.isSelected ? 0.3 : 0.1),
                  Colors.transparent,
                ],
              ),
              boxShadow: widget.isSelected
                  ? [
                      BoxShadow(
                        color: CosmicTheme.stardustGold
                            .withOpacity(_glowAnimation.value * 0.5),
                        blurRadius: 20,
                        spreadRadius: 2,
                      ),
                    ]
                  : null,
            ),
            child: Center(
              child: Text(
                symbol,
                style: TextStyle(
                  fontSize: widget.size * 0.5,
                  color: widget.isSelected
                      ? CosmicTheme.stardustGold
                      : CosmicTheme.textSecondary,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class PlanetOrbitWidget extends StatefulWidget {
  final double size;

  const PlanetOrbitWidget({super.key, this.size = 200});

  @override
  State<PlanetOrbitWidget> createState() => _PlanetOrbitWidgetState();
}

class _PlanetOrbitWidgetState extends State<PlanetOrbitWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  final List<_Planet> planets = [
    _Planet('Sun', '☀️', 0.3, 1.0, Colors.amber),
    _Planet('Moon', '🌙', 0.45, 0.8, Colors.grey),
    _Planet('Mars', '🔴', 0.6, 1.2, Colors.red),
    _Planet('Mercury', '☿', 0.75, 0.9, Colors.orange),
    _Planet('Jupiter', '♃', 0.85, 0.6, Colors.brown),
    _Planet('Venus', '♀', 0.55, 1.1, Colors.pink),
    _Planet('Saturn', '♄', 0.95, 0.5, Colors.amber),
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        return CustomPaint(
          size: Size(widget.size, widget.size),
          painter: PlanetOrbitPainter(
            planets: planets,
            animationValue: _controller.value,
          ),
        );
      },
    );
  }
}

class _Planet {
  final String name;
  final String symbol;
  final double orbitRadius;
  final double speed;
  final Color color;

  _Planet(this.name, this.symbol, this.orbitRadius, this.speed, this.color);
}

class PlanetOrbitPainter extends CustomPainter {
  final List<_Planet> planets;
  final double animationValue;

  PlanetOrbitPainter({required this.planets, required this.animationValue});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final maxRadius = size.width / 2;

    // Draw orbit rings
    for (final planet in planets) {
      final orbitPaint = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 0.5
        ..color = CosmicTheme.nebulaPurple.withOpacity(0.2);
      canvas.drawCircle(center, maxRadius * planet.orbitRadius, orbitPaint);
    }

    // Draw planets
    for (final planet in planets) {
      final angle = animationValue * 2 * pi * planet.speed;
      final radius = maxRadius * planet.orbitRadius;
      final planetCenter = Offset(
        center.dx + radius * cos(angle),
        center.dy + radius * sin(angle),
      );

      // Planet glow
      final glowPaint = Paint()
        ..shader = RadialGradient(
          colors: [
            planet.color.withOpacity(0.4),
            planet.color.withOpacity(0.1),
            Colors.transparent,
          ],
        ).createShader(Rect.fromCircle(center: planetCenter, radius: 8));
      canvas.drawCircle(planetCenter, 8, glowPaint);

      // Planet
      final planetPaint = Paint()
        ..color = planet.color
        ..style = PaintingStyle.fill;
      canvas.drawCircle(planetCenter, 4, planetPaint);
    }

    // Center sun glow
    final sunGlow = Paint()
      ..shader = RadialGradient(
        colors: [
          CosmicTheme.stardustGold.withOpacity(0.4),
          CosmicTheme.stardustGold.withOpacity(0.1),
          Colors.transparent,
        ],
      ).createShader(Rect.fromCircle(center: center, radius: 15));
    canvas.drawCircle(center, 15, sunGlow);

    final sunPaint = Paint()
      ..color = CosmicTheme.stardustGold
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, 6, sunPaint);
  }

  @override
  bool shouldRepaint(covariant PlanetOrbitPainter oldDelegate) => true;
}

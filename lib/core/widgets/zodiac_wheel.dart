import 'dart:math';
import 'package:flutter/material.dart';
import '../theme/cosmic_theme.dart';
import '../constants/app_strings.dart';

class ZodiacWheel extends StatefulWidget {
  final String? selectedSign;
  final Function(String)? onSignSelected;
  final double size;

  const ZodiacWheel({
    super.key,
    this.selectedSign,
    this.onSignSelected,
    this.size = 280,
  });

  @override
  State<ZodiacWheel> createState() => _ZodiacWheelState();
}

class _ZodiacWheelState extends State<ZodiacWheel>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 60),
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
      builder: (context, child) {
        return CustomPaint(
          size: Size(widget.size, widget.size),
          painter: ZodiacWheelPainter(
            selectedSign: widget.selectedSign,
            rotationAngle: _controller.value * 2 * pi,
          ),
        );
      },
    );
  }
}

class ZodiacWheelPainter extends CustomPainter {
  final String? selectedSign;
  final double rotationAngle;

  ZodiacWheelPainter({
    this.selectedSign,
    required this.rotationAngle,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    final signs = AppStrings.zodiacSigns;
    final symbols = AppStrings.zodiacSymbols;

    // Outer ring glow
    final glowPaint = Paint()
      ..shader = RadialGradient(
        colors: [
          CosmicTheme.nebulaPurple.withOpacity(0.3),
          CosmicTheme.celestialTeal.withOpacity(0.1),
          Colors.transparent,
        ],
      ).createShader(Rect.fromCircle(center: center, radius: radius));
    canvas.drawCircle(center, radius, glowPaint);

    // Outer ring
    final ringPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..shader = SweepGradient(
        colors: [
          CosmicTheme.stardustGold.withOpacity(0.8),
          CosmicTheme.nebulaPurple.withOpacity(0.8),
          CosmicTheme.celestialTeal.withOpacity(0.8),
          CosmicTheme.stardustGold.withOpacity(0.8),
        ],
      ).createShader(Rect.fromCircle(center: center, radius: radius));
    canvas.drawCircle(center, radius - 5, ringPaint);

    // Draw zodiac segments
    for (int i = 0; i < 12; i++) {
      final startAngle = (i * 30 - 90 + rotationAngle * 180 / pi) * pi / 180;
      final sweepAngle = 30 * pi / 180;
      final midAngle = startAngle + sweepAngle / 2;
      final isSelected = signs[i] == selectedSign;

      // Segment arc
      final segmentPaint = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = isSelected ? 4 : 1.5
        ..color = isSelected
            ? CosmicTheme.stardustGold
            : CosmicTheme.nebulaPurple.withOpacity(0.4);

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius * 0.75),
        startAngle,
        sweepAngle,
        false,
        segmentPaint,
      );

      // Selected glow
      if (isSelected) {
        final glowSegmentPaint = Paint()
          ..style = PaintingStyle.fill
          ..shader = SweepGradient(
            colors: [
              CosmicTheme.stardustGold.withOpacity(0.2),
              CosmicTheme.stardustGold.withOpacity(0.05),
            ],
          ).createShader(Rect.fromCircle(center: center, radius: radius * 0.75));
        canvas.drawArc(
          Rect.fromCircle(center: center, radius: radius * 0.75),
          startAngle,
          sweepAngle,
          true,
          glowSegmentPaint,
        );
      }

      // Zodiac symbol
      final symbolRadius = radius * 0.6;
      final symbolCenter = Offset(
        center.dx + symbolRadius * cos(midAngle),
        center.dy + symbolRadius * sin(midAngle),
      );

      final textPainter = TextPainter(
        text: TextSpan(
          text: symbols[signs[i]],
          style: TextStyle(
            fontSize: isSelected ? 22 : 16,
            color: isSelected
                ? CosmicTheme.stardustGold
                : CosmicTheme.textSecondary,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();
      textPainter.paint(
        canvas,
        Offset(
          symbolCenter.dx - textPainter.width / 2,
          symbolCenter.dy - textPainter.height / 2,
        ),
      );
    }

    // Inner circle
    final innerPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1
      ..color = CosmicTheme.nebulaPurple.withOpacity(0.3);
    canvas.drawCircle(center, radius * 0.4, innerPaint);

    // Center glow
    final centerGlow = Paint()
      ..shader = RadialGradient(
        colors: [
          CosmicTheme.stardustGold.withOpacity(0.3),
          CosmicTheme.nebulaPurple.withOpacity(0.1),
          Colors.transparent,
        ],
      ).createShader(Rect.fromCircle(center: center, radius: radius * 0.35));
    canvas.drawCircle(center, radius * 0.35, centerGlow);
  }

  @override
  bool shouldRepaint(covariant ZodiacWheelPainter oldDelegate) => true;
}

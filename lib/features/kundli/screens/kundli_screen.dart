import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/theme/cosmic_theme.dart';
import '../../../core/widgets/cosmic_background.dart';
import '../../../core/widgets/glass_card.dart';
import '../../../core/widgets/cosmic_button.dart';

class KundliScreen extends ConsumerStatefulWidget {
  const KundliScreen({super.key});

  @override
  ConsumerState<KundliScreen> createState() => _KundliScreenState();
}

class _KundliScreenState extends ConsumerState<KundliScreen> {
  String _kundliType = 'north_indian';

  @override
  Widget build(BuildContext context) {
    return CosmicBackground(
      child: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Kundli',
                      style: GoogleFonts.orbitron(
                        fontSize: 22,
                        color: CosmicTheme.stardustGold,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: [
                        _TypeToggle(
                          label: 'North',
                          isSelected: _kundliType == 'north_indian',
                          onTap: () =>
                              setState(() => _kundliType = 'north_indian'),
                        ),
                        const SizedBox(width: 8),
                        _TypeToggle(
                          label: 'South',
                          isSelected: _kundliType == 'south_indian',
                          onTap: () =>
                              setState(() => _kundliType = 'south_indian'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 20)),

            // Kundli Chart
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: GlassCard(
                  child: Column(
                    children: [
                      Text(
                        'Birth Chart',
                        style: GoogleFonts.orbitron(
                          fontSize: 14,
                          color: CosmicTheme.stardustGold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      _kundliType == 'north_indian'
                          ? _NorthIndianKundli()
                          : _SouthIndianKundli(),
                    ],
                  ),
                ),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 20)),

            // Basic Info
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: _BasicInfo(),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 20)),

            // Planet Positions
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: _PlanetPositionsTable(),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 20)),

            // Doshas
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: _DoshaSection(),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 20)),

            // Actions
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: CosmicButton(
                        text: 'Download PDF',
                        icon: Icons.download,
                        color: CosmicTheme.celestialTeal,
                        onPressed: () {},
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: CosmicButton(
                        text: 'Share',
                        icon: Icons.share,
                        color: CosmicTheme.nebulaPurple,
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 100)),
          ],
        ),
      ),
    );
  }
}

class _TypeToggle extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _TypeToggle({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: isSelected ? CosmicTheme.purpleGradient : null,
          color: isSelected ? null : CosmicTheme.cardDark,
          border: Border.all(
            color: isSelected
                ? CosmicTheme.nebulaPurple
                : CosmicTheme.nebulaPurple.withOpacity(0.3),
          ),
        ),
        child: Text(
          label,
          style: GoogleFonts.poppins(
            color: isSelected ? Colors.white : CosmicTheme.textMuted,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

class _NorthIndianKundli extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(280, 280),
      painter: _NorthIndianChartPainter(),
    );
  }
}

class _NorthIndianChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5
      ..color = CosmicTheme.stardustGold.withOpacity(0.6);

    // Outer square
    canvas.drawRect(
      Rect.fromCenter(center: center, width: size.width, height: size.height),
      paint,
    );

    // Diamond
    final path = Path()
      ..moveTo(center.dx, 0)
      ..lineTo(size.width, center.dy)
      ..lineTo(center.dx, size.height)
      ..lineTo(0, center.dy)
      ..close();
    canvas.drawPath(path, paint);

    // Cross lines
    canvas.drawLine(Offset(0, 0), Offset(size.width, size.height), paint);
    canvas.drawLine(Offset(size.width, 0), Offset(0, size.height), paint);

    // Horizontal and vertical center
    canvas.drawLine(
        Offset(0, center.dy), Offset(size.width, center.dy), paint);
    canvas.drawLine(
        Offset(center.dx, 0), Offset(center.dx, size.height), paint);

    // House numbers
    final houses = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12'];
    final positions = [
      Offset(center.dx - 20, 20),
      Offset(30, 30),
      Offset(20, center.dy - 15),
      Offset(30, size.height - 40),
      Offset(center.dx - 20, size.height - 25),
      Offset(size.width - 50, size.height - 40),
      Offset(size.width - 30, center.dy - 15),
      Offset(size.width - 50, 30),
      Offset(center.dx + 10, 20),
      Offset(center.dx + 10, center.dy - 60),
      Offset(center.dx - 20, center.dy + 10),
      Offset(center.dx + 10, center.dy + 10),
    ];

    for (int i = 0; i < 12; i++) {
      final textPainter = TextPainter(
        text: TextSpan(
          text: houses[i],
          style: TextStyle(
            color: CosmicTheme.stardustGold.withOpacity(0.7),
            fontSize: 11,
            fontWeight: FontWeight.w600,
          ),
        ),
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();
      textPainter.paint(canvas, positions[i]);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _SouthIndianKundli extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(280, 280),
      painter: _SouthIndianChartPainter(),
    );
  }
}

class _SouthIndianChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5
      ..color = CosmicTheme.stardustGold.withOpacity(0.6);

    // 4x4 grid
    final cellW = size.width / 4;
    final cellH = size.height / 4;

    // Outer rectangle
    canvas.drawRect(
        Rect.fromLTWH(0, 0, size.width, size.height), paint);

    // Grid lines
    for (int i = 1; i < 4; i++) {
      canvas.drawLine(
          Offset(cellW * i, 0), Offset(cellW * i, size.height), paint);
      canvas.drawLine(
          Offset(0, cellH * i), Offset(size.width, cellH * i), paint);
    }

    // House labels
    final signs = [
      'Ari', 'Tau', 'Gem', 'Can',
      'Leo', 'Vir', 'Lib', 'Sco',
      'Sag', 'Cap', 'Aqu', 'Pis',
    ];
    final positions = [
      Offset(1 * cellW + 10, 1 * cellH + 10),
      Offset(2 * cellW + 10, 0 * cellH + 10),
      Offset(2 * cellW + 10, 1 * cellH + 10),
      Offset(1 * cellW + 10, 2 * cellH + 10),
      Offset(0 * cellW + 10, 2 * cellH + 10),
      Offset(0 * cellW + 10, 1 * cellH + 10),
      Offset(0 * cellW + 10, 0 * cellH + 10),
      Offset(3 * cellW + 10, 3 * cellH + 10),
      Offset(2 * cellW + 10, 3 * cellH + 10),
      Offset(2 * cellW + 10, 2 * cellH + 10),
      Offset(3 * cellW + 10, 2 * cellH + 10),
      Offset(3 * cellW + 10, 1 * cellH + 10),
    ];

    for (int i = 0; i < 12; i++) {
      final textPainter = TextPainter(
        text: TextSpan(
          text: signs[i],
          style: TextStyle(
            color: CosmicTheme.stardustGold.withOpacity(0.7),
            fontSize: 11,
            fontWeight: FontWeight.w600,
          ),
        ),
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();
      textPainter.paint(canvas, positions[i]);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _BasicInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Basic Details',
            style: GoogleFonts.orbitron(
              fontSize: 14,
              color: CosmicTheme.stardustGold,
            ),
          ),
          const SizedBox(height: 12),
          _InfoRow(label: 'Name', value: 'User'),
          _InfoRow(label: 'Date of Birth', value: '15 Mar 1995'),
          _InfoRow(label: 'Time of Birth', value: '10:30 AM'),
          _InfoRow(label: 'Place of Birth', value: 'Mumbai, India'),
          _InfoRow(label: 'Rashi', value: 'Mesha (Aries)'),
          _InfoRow(label: 'Nakshatra', value: 'Ashwini'),
          _InfoRow(label: 'Lagna', value: 'Cancer'),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _InfoRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.poppins(
              color: CosmicTheme.textMuted,
              fontSize: 13,
            ),
          ),
          Text(
            value,
            style: GoogleFonts.poppins(
              color: CosmicTheme.textPrimary,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _PlanetPositionsTable extends StatelessWidget {
  final List<_PlanetData> planets = [
    _PlanetData('Sun ☀️', 'Aries', '12°', 'Ashwini', '1st', false),
    _PlanetData('Moon 🌙', 'Cancer', '24°', 'Punarvasu', '4th', false),
    _PlanetData('Mars 🔴', 'Capricorn', '8°', 'Uttara Ashadha', '10th', false),
    _PlanetData('Mercury ☿', 'Pisces', '15°', 'Revati', '12th', true),
    _PlanetData('Jupiter ♃', 'Taurus', '5°', 'Krittika', '2nd', false),
    _PlanetData('Venus ♀', 'Aquarius', '20°', 'Shatabhisha', '11th', false),
    _PlanetData('Saturn ♄', 'Aquarius', '18°', 'Shatabhisha', '11th', true),
    _PlanetData('Rahu 🐍', 'Virgo', '10°', 'Hasta', '6th', false),
    _PlanetData('Ketu 🐉', 'Pisces', '10°', 'Uttara Bhadra', '12th', false),
  ];

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Planet Positions',
            style: GoogleFonts.orbitron(
              fontSize: 14,
              color: CosmicTheme.stardustGold,
            ),
          ),
          const SizedBox(height: 12),
          // Header
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: CosmicTheme.nebulaPurple.withOpacity(0.2),
                ),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Text('Planet',
                      style: GoogleFonts.poppins(
                          color: CosmicTheme.textMuted, fontSize: 11)),
                ),
                Expanded(
                  child: Text('Sign',
                      style: GoogleFonts.poppins(
                          color: CosmicTheme.textMuted, fontSize: 11)),
                ),
                Expanded(
                  child: Text('House',
                      style: GoogleFonts.poppins(
                          color: CosmicTheme.textMuted, fontSize: 11)),
                ),
              ],
            ),
          ),
          ...planets.map((p) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Text(
                        p.name,
                        style: GoogleFonts.poppins(
                          color: CosmicTheme.textPrimary,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        '${p.sign} ${p.degree}',
                        style: GoogleFonts.poppins(
                          color: CosmicTheme.textSecondary,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          Text(
                            p.house,
                            style: GoogleFonts.poppins(
                              color: CosmicTheme.textSecondary,
                              fontSize: 12,
                            ),
                          ),
                          if (p.isRetrograde)
                            Text(
                              ' R',
                              style: GoogleFonts.poppins(
                                color: CosmicTheme.errorRed,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}

class _PlanetData {
  final String name;
  final String sign;
  final String degree;
  final String nakshatra;
  final String house;
  final bool isRetrograde;

  const _PlanetData(this.name, this.sign, this.degree, this.nakshatra,
      this.house, this.isRetrograde);
}

class _DoshaSection extends StatelessWidget {
  final List<_DoshaData> doshas = [
    _DoshaData(
      'Mangal Dosh',
      'Mars in 1st, 4th, 7th, 8th or 12th house',
      'Moderate',
      ['Chant Hanuman Chalisa', 'Wear Red Coral', 'Tuesday fasting'],
      true,
    ),
    _DoshaData(
      'Kaal Sarp Dosh',
      'All planets between Rahu and Ketu',
      'Mild',
      ['Worship Lord Shiva', 'Chant Maha Mrityunjaya Mantra'],
      false,
    ),
    _DoshaData(
      'Shani Dosh',
      'Saturn affliction in birth chart',
      'Mild',
      ['Light mustard oil lamp on Saturday', 'Chant Shani Mantra'],
      false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Dosha Analysis',
          style: GoogleFonts.orbitron(
            fontSize: 14,
            color: CosmicTheme.stardustGold,
          ),
        ),
        const SizedBox(height: 12),
        ...doshas.map((d) => GlassCard(
              margin: const EdgeInsets.only(bottom: 12),
              border: Border.all(
                color: d.isPresent
                    ? CosmicTheme.solarOrange.withOpacity(0.4)
                    : CosmicTheme.auroraGreen.withOpacity(0.4),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        d.name,
                        style: GoogleFonts.poppins(
                          color: CosmicTheme.textPrimary,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: d.isPresent
                              ? CosmicTheme.solarOrange.withOpacity(0.2)
                              : CosmicTheme.auroraGreen.withOpacity(0.2),
                        ),
                        child: Text(
                          d.isPresent ? 'Present' : 'Not Present',
                          style: GoogleFonts.poppins(
                            color: d.isPresent
                                ? CosmicTheme.solarOrange
                                : CosmicTheme.auroraGreen,
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    d.description,
                    style: GoogleFonts.poppins(
                      color: CosmicTheme.textSecondary,
                      fontSize: 12,
                    ),
                  ),
                  if (d.isPresent) ...[
                    const SizedBox(height: 8),
                    Text(
                      'Severity: ${d.severity}',
                      style: GoogleFonts.poppins(
                        color: CosmicTheme.solarOrange,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Remedies:',
                      style: GoogleFonts.poppins(
                        color: CosmicTheme.textPrimary,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    ...d.remedies.map((r) => Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('• ',
                                  style: TextStyle(
                                      color: CosmicTheme.stardustGold)),
                              Expanded(
                                child: Text(
                                  r,
                                  style: GoogleFonts.poppins(
                                    color: CosmicTheme.textSecondary,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )),
                  ],
                ],
              ),
            )),
      ],
    );
  }
}

class _DoshaData {
  final String name;
  final String description;
  final String severity;
  final List<String> remedies;
  final bool isPresent;

  const _DoshaData(this.name, this.description, this.severity, this.remedies,
      this.isPresent);
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/theme/cosmic_theme.dart';
import '../../../core/widgets/cosmic_background.dart';
import '../../../core/widgets/glass_card.dart';
import '../../../core/widgets/cosmic_button.dart';

class PalmReadingScreen extends ConsumerStatefulWidget {
  const PalmReadingScreen({super.key});

  @override
  ConsumerState<PalmReadingScreen> createState() => _PalmReadingScreenState();
}

class _PalmReadingScreenState extends ConsumerState<PalmReadingScreen> {
  bool _isAnalyzing = false;
  bool _hasResult = false;

  void _analyze() async {
    setState(() => _isAnalyzing = true);
    await Future.delayed(const Duration(seconds: 3));
    setState(() {
      _isAnalyzing = false;
      _hasResult = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CosmicBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(Icons.arrow_back_ios,
                          color: CosmicTheme.textPrimary),
                    ),
                    Text(
                      'Palm Reading',
                      style: GoogleFonts.orbitron(
                        fontSize: 20,
                        color: CosmicTheme.stardustGold,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                if (!_hasResult) ...[
                  // Upload Section
                  Center(
                    child: Text(
                      '🖐️',
                      style: TextStyle(fontSize: 80),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: Text(
                      'AI Palm Analysis',
                      style: GoogleFonts.orbitron(
                        fontSize: 20,
                        color: CosmicTheme.textPrimary,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Center(
                    child: Text(
                      'Upload a clear photo of your palm for AI analysis',
                      style: GoogleFonts.poppins(
                        color: CosmicTheme.textSecondary,
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Upload Area
                  GlassCard(
                    padding: const EdgeInsets.all(30),
                    child: Column(
                      children: [
                        Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: CosmicTheme.nebulaPurple.withOpacity(0.4),
                              width: 2,
                              style: BorderStyle.solid,
                            ),
                          ),
                          child: Icon(
                            Icons.camera_alt_outlined,
                            color: CosmicTheme.nebulaPurple,
                            size: 40,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Tap to upload palm image',
                          style: GoogleFonts.poppins(
                            color: CosmicTheme.textSecondary,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Supports JPG, PNG • Max 10MB',
                          style: GoogleFonts.poppins(
                            color: CosmicTheme.textMuted,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Tips
                  GlassCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '📸 Photo Tips',
                          style: GoogleFonts.poppins(
                            color: CosmicTheme.stardustGold,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 8),
                        _TipItem(text: 'Use natural lighting'),
                        _TipItem(text: 'Keep palm flat and open'),
                        _TipItem(text: 'Focus on palm lines clearly'),
                        _TipItem(text: 'Avoid shadows on palm'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),

                  CosmicButton(
                    text: _isAnalyzing ? 'Analyzing...' : 'Analyze Palm',
                    icon: Icons.auto_awesome,
                    isLoading: _isAnalyzing,
                    onPressed: _analyze,
                  ),
                ] else ...[
                  // Results
                  _buildResults(),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildResults() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Text(
            'Palm Analysis Results',
            style: GoogleFonts.orbitron(
              fontSize: 18,
              color: CosmicTheme.stardustGold,
            ),
          ),
        ),
        const SizedBox(height: 20),

        // Life Line
        _PalmLineCard(
          icon: '❤️',
          title: 'Life Line',
          description:
              'Your life line is long and well-curved, indicating strong vitality and good health throughout life. You have a zest for life and natural resilience.',
          prediction: 'Long life with good health. Energy peaks in mid-30s.',
          color: CosmicTheme.errorRed,
        ),

        // Heart Line
        _PalmLineCard(
          icon: '💕',
          title: 'Heart Line',
          description:
              'Your heart line runs straight across the palm, suggesting you are rational in love matters. You value loyalty and seek deep emotional connections.',
          prediction:
              'Meaningful relationship likely between ages 28-32. Marriage indicated.',
          color: CosmicTheme.mysticPink,
        ),

        // Head Line
        _PalmLineCard(
          icon: '🧠',
          title: 'Head Line',
          description:
              'Your head line is long and slightly curved, showing creativity combined with analytical thinking. You have excellent problem-solving abilities.',
          prediction:
              'Career in creative or analytical fields will be most fulfilling.',
          color: CosmicTheme.celestialTeal,
        ),

        // Career Line
        _PalmLineCard(
          icon: '💼',
          title: 'Fate Line',
          description:
              'Your fate line starts from the base of the palm and rises strongly, indicating a clear career path. Success comes through persistence.',
          prediction:
              'Major career breakthrough expected around age 35. Financial stability improves continuously.',
          color: CosmicTheme.stardustGold,
        ),

        // Marriage Line
        _PalmLineCard(
          icon: '💍',
          title: 'Marriage Line',
          description:
              'You have one clear marriage line, indicating one significant long-term relationship. The line is deep and well-defined.',
          prediction:
              'Marriage likely between ages 27-33. Happy and stable relationship indicated.',
          color: CosmicTheme.nebulaPurple,
        ),

        const SizedBox(height: 20),

        // Overall Summary
        GlassCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '🔮 Overall Summary',
                style: GoogleFonts.poppins(
                  color: CosmicTheme.stardustGold,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Your palm reveals a life of purpose and fulfillment. Strong leadership qualities combined with emotional depth make you a natural guide for others. The cosmic energies favor your endeavors, and your palm lines confirm success in both personal and professional spheres.',
                style: GoogleFonts.poppins(
                  color: CosmicTheme.textSecondary,
                  fontSize: 13,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),

        CosmicButton(
          text: 'Share Results',
          icon: Icons.share,
          onPressed: () {},
        ),
        const SizedBox(height: 100),
      ],
    );
  }
}

class _TipItem extends StatelessWidget {
  final String text;

  const _TipItem({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(Icons.check_circle, color: CosmicTheme.auroraGreen, size: 16),
          const SizedBox(width: 8),
          Text(
            text,
            style: GoogleFonts.poppins(
              color: CosmicTheme.textSecondary,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}

class _PalmLineCard extends StatelessWidget {
  final String icon;
  final String title;
  final String description;
  final String prediction;
  final Color color;

  const _PalmLineCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.prediction,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      margin: const EdgeInsets.only(bottom: 12),
      border: Border.all(color: color.withOpacity(0.2)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(icon, style: TextStyle(fontSize: 24)),
              const SizedBox(width: 8),
              Text(
                title,
                style: GoogleFonts.poppins(
                  color: color,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: GoogleFonts.poppins(
              color: CosmicTheme.textSecondary,
              fontSize: 13,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: color.withOpacity(0.1),
            ),
            child: Row(
              children: [
                Icon(Icons.auto_awesome, color: color, size: 16),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    prediction,
                    style: GoogleFonts.poppins(
                      color: color,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

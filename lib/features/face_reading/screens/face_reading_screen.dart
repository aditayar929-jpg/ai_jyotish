import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/theme/cosmic_theme.dart';
import '../../../core/widgets/cosmic_background.dart';
import '../../../core/widgets/glass_card.dart';
import '../../../core/widgets/cosmic_button.dart';

class FaceReadingScreen extends ConsumerStatefulWidget {
  const FaceReadingScreen({super.key});

  @override
  ConsumerState<FaceReadingScreen> createState() => _FaceReadingScreenState();
}

class _FaceReadingScreenState extends ConsumerState<FaceReadingScreen> {
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
                Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(Icons.arrow_back_ios,
                          color: CosmicTheme.textPrimary),
                    ),
                    Text(
                      'Face Reading',
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
                  Center(child: Text('👤', style: TextStyle(fontSize: 80))),
                  const SizedBox(height: 20),
                  Center(
                    child: Text(
                      'AI Face Analysis',
                      style: GoogleFonts.orbitron(
                        fontSize: 20,
                        color: CosmicTheme.textPrimary,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Center(
                    child: Text(
                      'Upload a selfie for AI face astrology analysis',
                      style: GoogleFonts.poppins(
                        color: CosmicTheme.textSecondary,
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 30),
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
                            ),
                          ),
                          child: Icon(
                            Icons.face_outlined,
                            color: CosmicTheme.nebulaPurple,
                            size: 50,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Tap to upload selfie',
                          style: GoogleFonts.poppins(
                            color: CosmicTheme.textSecondary,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  CosmicButton(
                    text: _isAnalyzing ? 'Analyzing...' : 'Analyze Face',
                    icon: Icons.auto_awesome,
                    isLoading: _isAnalyzing,
                    onPressed: _analyze,
                  ),
                ] else ...[
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
            'Face Analysis Results',
            style: GoogleFonts.orbitron(
              fontSize: 18,
              color: CosmicTheme.stardustGold,
            ),
          ),
        ),
        const SizedBox(height: 20),

        // Personality
        GlowCard(
          glowColor: CosmicTheme.nebulaPurple,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '🧠 Personality',
                style: GoogleFonts.poppins(
                  color: CosmicTheme.stardustGold,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Your face reveals a strong, determined personality with natural leadership qualities. Your eyes show deep intelligence and intuition. You are compassionate yet firm in your decisions.',
                style: GoogleFonts.poppins(
                  color: CosmicTheme.textSecondary,
                  fontSize: 13,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),

        // Emotion Analysis
        GlassCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '😊 Emotion Analysis',
                style: GoogleFonts.poppins(
                  color: CosmicTheme.stardustGold,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 12),
              _EmotionBar(label: 'Happiness', percent: 85, color: CosmicTheme.stardustGold),
              _EmotionBar(label: 'Confidence', percent: 78, color: CosmicTheme.auroraGreen),
              _EmotionBar(label: 'Calmness', percent: 70, color: CosmicTheme.celestialTeal),
              _EmotionBar(label: 'Energy', percent: 82, color: CosmicTheme.solarOrange),
            ],
          ),
        ),
        const SizedBox(height: 12),

        // Aura
        GlassCard(
          border: Border.all(color: CosmicTheme.mysticPink.withOpacity(0.3)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '✨ Aura Detection',
                style: GoogleFonts.poppins(
                  color: CosmicTheme.mysticPink,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Your aura is predominantly violet-blue, indicating spiritual awareness and creative energy. You have a healing presence that draws people to you.',
                style: GoogleFonts.poppins(
                  color: CosmicTheme.textSecondary,
                  fontSize: 13,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),

        // Energy Reading
        GlassCard(
          border: Border.all(color: CosmicTheme.celestialTeal.withOpacity(0.3)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '⚡ Energy Reading',
                style: GoogleFonts.poppins(
                  color: CosmicTheme.celestialTeal,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'High vibrational energy detected. Your third eye chakra is active, enhancing your intuitive abilities. The cosmic energies are aligned with your purpose.',
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

class _EmotionBar extends StatelessWidget {
  final String label;
  final int percent;
  final Color color;

  const _EmotionBar({
    required this.label,
    required this.percent,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: GoogleFonts.poppins(
                  color: CosmicTheme.textSecondary,
                  fontSize: 12,
                ),
              ),
              Text(
                '$percent%',
                style: GoogleFonts.poppins(
                  color: color,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: percent / 100,
              backgroundColor: CosmicTheme.cardDark,
              valueColor: AlwaysStoppedAnimation(color),
              minHeight: 6,
            ),
          ),
        ],
      ),
    );
  }
}

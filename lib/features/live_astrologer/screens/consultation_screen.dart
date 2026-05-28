import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/theme/cosmic_theme.dart';
import '../../../core/widgets/cosmic_background.dart';
import '../../../core/widgets/glass_card.dart';
import '../../../core/widgets/cosmic_button.dart';

class ConsultationScreen extends ConsumerWidget {
  const ConsultationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: CosmicBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(Icons.arrow_back_ios,
                          color: CosmicTheme.textPrimary),
                    ),
                    Text(
                      'Consultation',
                      style: GoogleFonts.orbitron(
                        fontSize: 20,
                        color: CosmicTheme.stardustGold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Astrologer Profile
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: CosmicTheme.purpleGradient,
                    boxShadow: [
                      BoxShadow(
                        color: CosmicTheme.nebulaPurple.withOpacity(0.4),
                        blurRadius: 20,
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text('🔮', style: TextStyle(fontSize: 50)),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Dr. Sharma',
                  style: GoogleFonts.orbitron(
                    fontSize: 22,
                    color: CosmicTheme.textPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Vedic Astrology Expert',
                  style: GoogleFonts.poppins(
                    color: CosmicTheme.textSecondary,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.star, color: CosmicTheme.stardustGold, size: 18),
                    const SizedBox(width: 4),
                    Text(
                      '4.9 (500+ consultations)',
                      style: GoogleFonts.poppins(
                        color: CosmicTheme.stardustGold,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),

                // Consultation Options
                Text(
                  'Choose Consultation Type',
                  style: GoogleFonts.orbitron(
                    fontSize: 14,
                    color: CosmicTheme.stardustGold,
                  ),
                ),
                const SizedBox(height: 16),

                _ConsultOption(
                  icon: Icons.chat_bubble_outline,
                  title: 'Chat',
                  subtitle: 'Text-based consultation',
                  price: '₹5/min',
                  color: CosmicTheme.celestialTeal,
                  onTap: () {},
                ),
                _ConsultOption(
                  icon: Icons.call,
                  title: 'Voice Call',
                  subtitle: 'Talk to astrologer',
                  price: '₹8/min',
                  color: CosmicTheme.auroraGreen,
                  onTap: () {},
                ),
                _ConsultOption(
                  icon: Icons.videocam,
                  title: 'Video Call',
                  subtitle: 'Face-to-face consultation',
                  price: '₹12/min',
                  color: CosmicTheme.mysticPink,
                  onTap: () {},
                ),
                const SizedBox(height: 20),

                // About
                GlassCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'About',
                        style: GoogleFonts.poppins(
                          color: CosmicTheme.stardustGold,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Dr. Sharma is a renowned Vedic Astrologer with 15+ years of experience. Specializing in career guidance, marriage compatibility, and spiritual growth. He has helped thousands of people find clarity and direction.',
                        style: GoogleFonts.poppins(
                          color: CosmicTheme.textSecondary,
                          fontSize: 13,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // Specializations
                GlassCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Specializations',
                        style: GoogleFonts.poppins(
                          color: CosmicTheme.stardustGold,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          _SpecTag('Vedic Astrology'),
                          _SpecTag('Kundli Analysis'),
                          _SpecTag('Marriage'),
                          _SpecTag('Career'),
                          _SpecTag('Health'),
                          _SpecTag('Muhurta'),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),

                CosmicButton(
                  text: 'Start Consultation',
                  icon: Icons.chat,
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ConsultOption extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final String price;
  final Color color;
  final VoidCallback onTap;

  const _ConsultOption({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.price,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      margin: const EdgeInsets.only(bottom: 12),
      onTap: onTap,
      border: Border.all(color: color.withOpacity(0.3)),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: color.withOpacity(0.15),
            ),
            child: Icon(icon, color: color),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    color: CosmicTheme.textPrimary,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  subtitle,
                  style: GoogleFonts.poppins(
                    color: CosmicTheme.textMuted,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: color.withOpacity(0.15),
            ),
            child: Text(
              price,
              style: GoogleFonts.poppins(
                color: color,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SpecTag extends StatelessWidget {
  final String label;

  const _SpecTag(this.label);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: CosmicTheme.nebulaPurple.withOpacity(0.15),
        border: Border.all(
          color: CosmicTheme.nebulaPurple.withOpacity(0.3),
        ),
      ),
      child: Text(
        label,
        style: GoogleFonts.poppins(
          color: CosmicTheme.textSecondary,
          fontSize: 11,
        ),
      ),
    );
  }
}

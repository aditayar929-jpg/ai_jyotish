import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/theme/cosmic_theme.dart';
import '../../../core/widgets/cosmic_background.dart';
import '../../../core/widgets/glass_card.dart';

class AstrologerListScreen extends ConsumerWidget {
  const AstrologerListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final astrologers = [
      _Astrologer('Dr. Sharma', 'Vedic Astrology', '15 yrs', 4.9, 500, true, '🔮'),
      _Astrologer('Priya Ji', 'Numerology & Tarot', '10 yrs', 4.8, 350, true, '✨'),
      _Astrologer('Acharya Verma', 'Jyotish Shastra', '20 yrs', 4.9, 800, false, '📿'),
      _Astrologer('Guru Dev', 'KP Astrology', '12 yrs', 4.7, 280, true, '🌟'),
      _Astrologer('Dr. Patel', 'Western Astrology', '8 yrs', 4.6, 200, false, '⭐'),
      _Astrologer('Swami Ji', 'Spiritual Guide', '25 yrs', 5.0, 1200, true, '🧘'),
    ];

    return Scaffold(
      body: CosmicBackground(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(Icons.arrow_back_ios,
                          color: CosmicTheme.textPrimary),
                    ),
                    Text(
                      'Live Astrologers',
                      style: GoogleFonts.orbitron(
                        fontSize: 20,
                        color: CosmicTheme.stardustGold,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              // Filter chips
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _FilterChip(label: 'All', isSelected: true),
                      _FilterChip(label: 'Online'),
                      _FilterChip(label: 'Vedic'),
                      _FilterChip(label: 'Tarot'),
                      _FilterChip(label: 'Numerology'),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: astrologers.length,
                  itemBuilder: (context, index) {
                    return _AstrologerCard(astrologer: astrologers[index]);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool isSelected;

  const _FilterChip({required this.label, this.isSelected = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
        ),
      ),
    );
  }
}

class _Astrologer {
  final String name;
  final String specialty;
  final String experience;
  final double rating;
  final int consultations;
  final bool isOnline;
  final String icon;

  const _Astrologer(this.name, this.specialty, this.experience, this.rating,
      this.consultations, this.isOnline, this.icon);
}

class _AstrologerCard extends StatelessWidget {
  final _Astrologer astrologer;

  const _AstrologerCard({required this.astrologer});

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      margin: const EdgeInsets.only(bottom: 12),
      onTap: () => context.push('/consultation'),
      child: Row(
        children: [
          Stack(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: CosmicTheme.purpleGradient,
                ),
                child: Center(
                  child: Text(astrologer.icon, style: TextStyle(fontSize: 28)),
                ),
              ),
              if (astrologer.isOnline)
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    width: 16,
                    height: 16,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: CosmicTheme.auroraGreen,
                      border: Border.all(color: CosmicTheme.cardDark, width: 2),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  astrologer.name,
                  style: GoogleFonts.poppins(
                    color: CosmicTheme.textPrimary,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  astrologer.specialty,
                  style: GoogleFonts.poppins(
                    color: CosmicTheme.textMuted,
                    fontSize: 12,
                  ),
                ),
                Row(
                  children: [
                    Icon(Icons.star, color: CosmicTheme.stardustGold, size: 14),
                    const SizedBox(width: 4),
                    Text(
                      '${astrologer.rating}',
                      style: GoogleFonts.poppins(
                        color: CosmicTheme.stardustGold,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '${astrologer.consultations} consultations',
                      style: GoogleFonts.poppins(
                        color: CosmicTheme.textMuted,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Column(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: CosmicTheme.purpleGradient,
                ),
                child: Text(
                  '₹5/min',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                astrologer.isOnline ? 'Online' : 'Offline',
                style: GoogleFonts.poppins(
                  color: astrologer.isOnline
                      ? CosmicTheme.auroraGreen
                      : CosmicTheme.textMuted,
                  fontSize: 10,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

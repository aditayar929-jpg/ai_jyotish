import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/theme/cosmic_theme.dart';
import '../../../core/widgets/cosmic_background.dart';
import '../../../core/widgets/glass_card.dart';
import '../../../core/widgets/animated_zodiac.dart';
import '../../../core/constants/app_strings.dart';

class HoroscopeScreen extends ConsumerStatefulWidget {
  const HoroscopeScreen({super.key});

  @override
  ConsumerState<HoroscopeScreen> createState() => _HoroscopeScreenState();
}

class _HoroscopeScreenState extends ConsumerState<HoroscopeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String _selectedZodiac = 'Aries';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CosmicBackground(
      child: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
              child: Text(
                'Horoscope',
                style: GoogleFonts.orbitron(
                  fontSize: 22,
                  color: CosmicTheme.stardustGold,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Zodiac Selector
            SizedBox(
              height: 80,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: AppStrings.zodiacSigns.length,
                itemBuilder: (context, index) {
                  final sign = AppStrings.zodiacSigns[index];
                  return GestureDetector(
                    onTap: () => setState(() => _selectedZodiac = sign),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: AnimatedZodiacIcon(
                        zodiacSign: sign,
                        size: 50,
                        isSelected: sign == _selectedZodiac,
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 12),

            // Tabs
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: CosmicTheme.cardDark.withOpacity(0.5),
              ),
              child: TabBar(
                controller: _tabController,
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  gradient: CosmicTheme.purpleGradient,
                ),
                labelColor: Colors.white,
                unselectedLabelColor: CosmicTheme.textMuted,
                labelStyle: GoogleFonts.poppins(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
                tabs: const [
                  Tab(text: 'Daily'),
                  Tab(text: 'Weekly'),
                  Tab(text: 'Monthly'),
                  Tab(text: 'Yearly'),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Content
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildHoroscopeContent('daily'),
                  _buildHoroscopeContent('weekly'),
                  _buildHoroscopeContent('monthly'),
                  _buildHoroscopeContent('yearly'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHoroscopeContent(String period) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Summary Card
          GlowCard(
            glowColor: CosmicTheme.nebulaPurple,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      AppStrings.zodiacSymbols[_selectedZodiac] ?? '',
                      style: TextStyle(fontSize: 36),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _selectedZodiac,
                            style: GoogleFonts.orbitron(
                              fontSize: 18,
                              color: CosmicTheme.textPrimary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            AppStrings.zodiacDateRanges[_selectedZodiac] ?? '',
                            style: GoogleFonts.poppins(
                              color: CosmicTheme.textMuted,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: List.generate(5, (i) {
                        return Icon(
                          i < 4 ? Icons.star_rounded : Icons.star_border_rounded,
                          color: CosmicTheme.stardustGold,
                          size: 18,
                        );
                      }),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  'The cosmic energies are aligning in your favor. This $period period brings opportunities for growth and transformation. Trust your instincts and embrace the changes coming your way.',
                  style: GoogleFonts.poppins(
                    color: CosmicTheme.textSecondary,
                    fontSize: 14,
                    height: 1.6,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Category Cards
          _CategoryCard(
            icon: '💼',
            title: 'Career',
            description: 'New opportunities are on the horizon. Stay focused on your goals and don\'t hesitate to take calculated risks.',
            color: CosmicTheme.auroraGreen,
          ),
          _CategoryCard(
            icon: '❤️',
            title: 'Love & Relationships',
            description: 'Romance is in the air. Existing relationships will deepen, and singles may find meaningful connections.',
            color: CosmicTheme.mysticPink,
          ),
          _CategoryCard(
            icon: '💰',
            title: 'Finance',
            description: 'Financial stability improves. Good time for investments and long-term planning.',
            color: CosmicTheme.stardustGold,
          ),
          _CategoryCard(
            icon: '🏥',
            title: 'Health',
            description: 'Focus on mental well-being. Regular exercise and meditation will bring balance to your life.',
            color: CosmicTheme.celestialTeal,
          ),
          _CategoryCard(
            icon: '🧘',
            title: 'Spiritual',
            description: 'Your spiritual energy is high. Practice mindfulness and connect with your inner self.',
            color: CosmicTheme.nebulaPurple,
          ),
          const SizedBox(height: 20),

          // Lucky Elements
          GlassCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Lucky Elements',
                  style: GoogleFonts.orbitron(
                    fontSize: 14,
                    color: CosmicTheme.stardustGold,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _LuckyItem(icon: '🔢', label: 'Number', value: '7'),
                    _LuckyItem(icon: '🎨', label: 'Color', value: 'Gold'),
                    _LuckyItem(icon: '⏰', label: 'Time', value: '10 AM'),
                    _LuckyItem(icon: '📅', label: 'Day', value: 'Thursday'),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Compatibility
          GlassCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Best Compatibility',
                  style: GoogleFonts.orbitron(
                    fontSize: 14,
                    color: CosmicTheme.stardustGold,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _CompatItem(sign: 'Leo', percent: 95),
                    _CompatItem(sign: 'Sagittarius', percent: 90),
                    _CompatItem(sign: 'Gemini', percent: 85),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 100),
        ],
      ),
    );
  }
}

class _CategoryCard extends StatelessWidget {
  final String icon;
  final String title;
  final String description;
  final Color color;

  const _CategoryCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      border: Border.all(color: color.withOpacity(0.2)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: color.withOpacity(0.15),
            ),
            child: Center(child: Text(icon, style: TextStyle(fontSize: 20))),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    color: color,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: GoogleFonts.poppins(
                    color: CosmicTheme.textSecondary,
                    fontSize: 12,
                    height: 1.4,
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

class _LuckyItem extends StatelessWidget {
  final String icon;
  final String label;
  final String value;

  const _LuckyItem({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(icon, style: TextStyle(fontSize: 20)),
        const SizedBox(height: 4),
        Text(
          value,
          style: GoogleFonts.poppins(
            color: CosmicTheme.stardustGold,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          label,
          style: GoogleFonts.poppins(
            color: CosmicTheme.textMuted,
            fontSize: 10,
          ),
        ),
      ],
    );
  }
}

class _CompatItem extends StatelessWidget {
  final String sign;
  final int percent;

  const _CompatItem({required this.sign, required this.percent});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: 50,
              height: 50,
              child: CircularProgressIndicator(
                value: percent / 100,
                backgroundColor: CosmicTheme.cardDark,
                valueColor:
                    AlwaysStoppedAnimation(CosmicTheme.stardustGold),
                strokeWidth: 4,
              ),
            ),
            Text(
              '$percent%',
              style: GoogleFonts.poppins(
                color: CosmicTheme.stardustGold,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Text(
          sign,
          style: GoogleFonts.poppins(
            color: CosmicTheme.textSecondary,
            fontSize: 11,
          ),
        ),
      ],
    );
  }
}

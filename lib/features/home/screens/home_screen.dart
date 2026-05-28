import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/theme/cosmic_theme.dart';
import '../../../core/widgets/cosmic_background.dart';
import '../../../core/widgets/glass_card.dart';
import '../../../core/widgets/zodiac_wheel.dart';
import '../../../core/widgets/animated_zodiac.dart';
import '../../../core/constants/app_strings.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  String _selectedZodiac = 'Aries';

  @override
  Widget build(BuildContext context) {
    return CosmicBackground(
      child: SafeArea(
        child: CustomScrollView(
          slivers: [
            // App Bar
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Good Morning',
                          style: GoogleFonts.poppins(
                            color: CosmicTheme.textSecondary,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          'Seeker ✨',
                          style: GoogleFonts.orbitron(
                            color: CosmicTheme.stardustGold,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        _IconButton(
                          icon: Icons.notifications_outlined,
                          onTap: () {},
                        ),
                        const SizedBox(width: 8),
                        _IconButton(
                          icon: Icons.account_balance_wallet_outlined,
                          badge: '150',
                          onTap: () => context.push('/wallet'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 20)),

            // Daily Horoscope Card
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: _DailyHoroscopeCard(zodiac: _selectedZodiac),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 20)),

            // Zodiac Selector
            SliverToBoxAdapter(
              child: SizedBox(
                height: 90,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: AppStrings.zodiacSigns.length,
                  itemBuilder: (context, index) {
                    final sign = AppStrings.zodiacSigns[index];
                    final isSelected = sign == _selectedZodiac;
                    return GestureDetector(
                      onTap: () => setState(() => _selectedZodiac = sign),
                      child: AnimatedZodiacIcon(
                        zodiacSign: sign,
                        size: 60,
                        isSelected: isSelected,
                      ),
                    );
                  },
                ),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 20)),

            // Quick Actions
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: _QuickActionsGrid(),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 20)),

            // Zodiac Wheel
            SliverToBoxAdapter(
              child: Center(
                child: ZodiacWheel(
                  selectedSign: _selectedZodiac,
                  size: 240,
                ),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 20)),

            // Today's Insights
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: _TodaysInsights(),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 20)),

            // Planetary Status
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: _PlanetaryStatus(),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 20)),

            // Spiritual Quote
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: _SpiritualQuote(),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 20)),

            // Premium Banner
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: _PremiumBanner(),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 100)),
          ],
        ),
      ),
    );
  }
}

class _IconButton extends StatelessWidget {
  final IconData icon;
  final String? badge;
  final VoidCallback onTap;

  const _IconButton({
    required this.icon,
    this.badge,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: CosmicTheme.cardDark.withOpacity(0.5),
          border: Border.all(
            color: CosmicTheme.nebulaPurple.withOpacity(0.3),
          ),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Icon(icon, color: CosmicTheme.textPrimary, size: 22),
            if (badge != null)
              Positioned(
                top: 4,
                right: 4,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: CosmicTheme.goldGradient,
                  ),
                  child: Text(
                    badge!,
                    style: GoogleFonts.poppins(
                      fontSize: 8,
                      fontWeight: FontWeight.bold,
                      color: CosmicTheme.deepSpace,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _DailyHoroscopeCard extends StatelessWidget {
  final String zodiac;

  const _DailyHoroscopeCard({required this.zodiac});

  @override
  Widget build(BuildContext context) {
    return GlowCard(
      glowColor: CosmicTheme.nebulaPurple,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Daily Horoscope',
                    style: GoogleFonts.orbitron(
                      fontSize: 16,
                      color: CosmicTheme.stardustGold,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${AppStrings.zodiacSymbols[zodiac]} $zodiac',
                    style: GoogleFonts.poppins(
                      fontSize: 22,
                      color: CosmicTheme.textPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      CosmicTheme.stardustGold.withOpacity(0.3),
                      Colors.transparent,
                    ],
                  ),
                ),
                child: Text(
                  AppStrings.zodiacSymbols[zodiac] ?? '',
                  style: TextStyle(fontSize: 36),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            'The stars are aligning in your favor today. A great opportunity awaits in your career. Stay focused and trust your intuition.',
            style: GoogleFonts.poppins(
              color: CosmicTheme.textSecondary,
              fontSize: 14,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _InsightChip(icon: '🔢', label: 'Lucky: 7'),
              _InsightChip(icon: '🎨', label: 'Gold'),
              _InsightChip(icon: '⏰', label: '10:30 AM'),
              _InsightChip(icon: '💕', label: 'Leo ♌'),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Text(
                'Rating: ',
                style: GoogleFonts.poppins(
                  color: CosmicTheme.textSecondary,
                  fontSize: 13,
                ),
              ),
              ...List.generate(5, (i) {
                return Icon(
                  i < 4 ? Icons.star_rounded : Icons.star_border_rounded,
                  color: CosmicTheme.stardustGold,
                  size: 18,
                );
              }),
            ],
          ),
        ],
      ),
    );
  }
}

class _InsightChip extends StatelessWidget {
  final String icon;
  final String label;

  const _InsightChip({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: CosmicTheme.cardDark.withOpacity(0.5),
        border: Border.all(
          color: CosmicTheme.nebulaPurple.withOpacity(0.2),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(icon, style: TextStyle(fontSize: 12)),
          const SizedBox(width: 4),
          Text(
            label,
            style: GoogleFonts.poppins(
              color: CosmicTheme.textSecondary,
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }
}

class _QuickActionsGrid extends StatelessWidget {
  final List<_QuickAction> actions = [
    _QuickAction('🔮', 'AI Chat', '/ai-chat', CosmicTheme.nebulaPurple),
    _QuickAction('📊', 'Kundli', '/kundli', CosmicTheme.cosmicBlue),
    _QuickAction('🎯', 'Predictions', '/predictions', CosmicTheme.celestialTeal),
    _QuickAction('🔢', 'Numerology', '/numerology', CosmicTheme.solarOrange),
    _QuickAction('🖐️', 'Palm Reading', '/palm-reading', CosmicTheme.mysticPink),
    _QuickAction('👤', 'Face Read', '/face-reading', CosmicTheme.auroraGreen),
    _QuickAction('📞', 'Astrologer', '/astrologers', CosmicTheme.stardustGold),
    _QuickAction('⭐', 'Premium', '/premium', CosmicTheme.nebulaPurple),
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 0.85,
      ),
      itemCount: actions.length,
      itemBuilder: (context, index) {
        final action = actions[index];
        return GestureDetector(
          onTap: () => context.push(action.route),
          child: Column(
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      action.color.withOpacity(0.3),
                      action.color.withOpacity(0.1),
                    ],
                  ),
                  border: Border.all(
                    color: action.color.withOpacity(0.3),
                  ),
                ),
                child: Center(
                  child: Text(action.icon, style: TextStyle(fontSize: 24)),
                ),
              ),
              const SizedBox(height: 6),
              Text(
                action.label,
                style: GoogleFonts.poppins(
                  color: CosmicTheme.textSecondary,
                  fontSize: 10,
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        );
      },
    );
  }
}

class _QuickAction {
  final String icon;
  final String label;
  final String route;
  final Color color;

  const _QuickAction(this.icon, this.label, this.route, this.color);
}

class _TodaysInsights extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Today's Insights",
          style: GoogleFonts.orbitron(
            fontSize: 16,
            color: CosmicTheme.stardustGold,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _InsightCard(
                icon: '💼',
                title: 'Career',
                value: 'Excellent',
                color: CosmicTheme.auroraGreen,
                progress: 0.85,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _InsightCard(
                icon: '❤️',
                title: 'Love',
                value: 'Good',
                color: CosmicTheme.mysticPink,
                progress: 0.70,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _InsightCard(
                icon: '💰',
                title: 'Finance',
                value: 'Great',
                color: CosmicTheme.stardustGold,
                progress: 0.78,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _InsightCard(
                icon: '🏥',
                title: 'Health',
                value: 'Moderate',
                color: CosmicTheme.celestialTeal,
                progress: 0.55,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _InsightCard extends StatelessWidget {
  final String icon;
  final String title;
  final String value;
  final Color color;
  final double progress;

  const _InsightCard({
    required this.icon,
    required this.title,
    required this.value,
    required this.color,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(icon, style: TextStyle(fontSize: 18)),
              const SizedBox(width: 8),
              Text(
                title,
                style: GoogleFonts.poppins(
                  color: CosmicTheme.textSecondary,
                  fontSize: 13,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: GoogleFonts.poppins(
              color: color,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: CosmicTheme.cardDark,
              valueColor: AlwaysStoppedAnimation(color),
              minHeight: 4,
            ),
          ),
        ],
      ),
    );
  }
}

class _PlanetaryStatus extends StatelessWidget {
  final List<_PlanetInfo> planets = [
    _PlanetInfo('Sun', '☀️', 'Aries', '12°', true),
    _PlanetInfo('Moon', '🌙', 'Cancer', '24°', true),
    _PlanetInfo('Mars', '🔴', 'Capricorn', '8°', false),
    _PlanetInfo('Mercury', '☿', 'Pisces', '15°', true),
    _PlanetInfo('Jupiter', '♃', 'Taurus', '5°', false),
    _PlanetInfo('Venus', '♀', 'Aquarius', '20°', true),
    _PlanetInfo('Saturn', '♄', 'Aquarius', '18°', false),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Planetary Positions',
          style: GoogleFonts.orbitron(
            fontSize: 16,
            color: CosmicTheme.stardustGold,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 100,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: planets.length,
            itemBuilder: (context, index) {
              final planet = planets[index];
              return Container(
                width: 90,
                margin: const EdgeInsets.only(right: 10),
                child: GlassCard(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(planet.icon, style: TextStyle(fontSize: 22)),
                      const SizedBox(height: 4),
                      Text(
                        planet.name,
                        style: GoogleFonts.poppins(
                          color: CosmicTheme.textPrimary,
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        '${planet.sign} ${planet.degree}',
                        style: GoogleFonts.poppins(
                          color: CosmicTheme.textMuted,
                          fontSize: 9,
                        ),
                      ),
                      if (planet.isRetrograde)
                        Text(
                          'R',
                          style: GoogleFonts.poppins(
                            color: CosmicTheme.errorRed,
                            fontSize: 9,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _PlanetInfo {
  final String name;
  final String icon;
  final String sign;
  final String degree;
  final bool isRetrograde;

  const _PlanetInfo(this.name, this.icon, this.sign, this.degree,
      this.isRetrograde);
}

class _SpiritualQuote extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GlassCard(
      child: Column(
        children: [
          Text(
            '✨',
            style: TextStyle(fontSize: 30),
          ),
          const SizedBox(height: 12),
          Text(
            '"The cosmos is within us. We are made of star-stuff. We are a way for the universe to know itself."',
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              color: CosmicTheme.textSecondary,
              fontSize: 14,
              fontStyle: FontStyle.italic,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '— Carl Sagan',
            style: GoogleFonts.poppins(
              color: CosmicTheme.stardustGold,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _PremiumBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push('/premium'),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              CosmicTheme.stardustGold.withOpacity(0.2),
              CosmicTheme.nebulaPurple.withOpacity(0.3),
              CosmicTheme.cosmicBlue.withOpacity(0.2),
            ],
          ),
          border: Border.all(
            color: CosmicTheme.stardustGold.withOpacity(0.4),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: CosmicTheme.stardustGold.withOpacity(0.1),
              blurRadius: 20,
              spreadRadius: -5,
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '👑 Go Premium',
                    style: GoogleFonts.orbitron(
                      fontSize: 16,
                      color: CosmicTheme.stardustGold,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Unlimited AI chat, detailed kundli, premium predictions & ad-free experience',
                    style: GoogleFonts.poppins(
                      color: CosmicTheme.textSecondary,
                      fontSize: 12,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                gradient: CosmicTheme.goldGradient,
              ),
              child: Text(
                'Upgrade',
                style: GoogleFonts.poppins(
                  color: CosmicTheme.deepSpace,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

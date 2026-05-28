import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/theme/cosmic_theme.dart';
import '../../../core/widgets/cosmic_background.dart';
import '../../../core/widgets/glass_card.dart';
import '../../../core/widgets/cosmic_button.dart';

class PremiumScreen extends ConsumerStatefulWidget {
  const PremiumScreen({super.key});

  @override
  ConsumerState<PremiumScreen> createState() => _PremiumScreenState();
}

class _PremiumScreenState extends ConsumerState<PremiumScreen> {
  int _selectedPlan = 1;

  final List<_PremiumPlan> _plans = [
    _PremiumPlan('Monthly', 299, '/mo', ['Unlimited AI Chat', 'Detailed Kundli', 'Premium Predictions', 'Ad-free Experience']),
    _PremiumPlan('Quarterly', 699, '/3 mo', ['Everything in Monthly', 'Priority Support', 'Exclusive Reports', 'Save 22%']),
    _PremiumPlan('Yearly', 1999, '/yr', ['Everything in Quarterly', 'Personal Astrologer', 'Live Sessions', 'Save 44%']),
  ];

  @override
  Widget build(BuildContext context) {
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
                      'Premium',
                      style: GoogleFonts.orbitron(
                        fontSize: 20,
                        color: CosmicTheme.stardustGold,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Crown Icon
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        CosmicTheme.stardustGold.withOpacity(0.3),
                        CosmicTheme.nebulaPurple.withOpacity(0.2),
                        Colors.transparent,
                      ],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: CosmicTheme.stardustGold.withOpacity(0.3),
                        blurRadius: 30,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text('👑', style: TextStyle(fontSize: 60)),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Go Premium',
                  style: GoogleFonts.orbitron(
                    fontSize: 28,
                    color: CosmicTheme.stardustGold,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Unlock the full power of AI Jyotish',
                  style: GoogleFonts.poppins(
                    color: CosmicTheme.textSecondary,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 30),

                // Features
                _PremiumFeature(icon: '🔮', title: 'Unlimited AI Chat', subtitle: 'Ask unlimited questions to AI astrologer'),
                _PremiumFeature(icon: '📊', title: 'Detailed Kundli', subtitle: 'Complete kundli with all doshas & remedies'),
                _PremiumFeature(icon: '🎯', title: 'Premium Predictions', subtitle: 'Detailed life predictions with timeline'),
                _PremiumFeature(icon: '🚫', title: 'Ad-free Experience', subtitle: 'Enjoy astrology without interruptions'),
                _PremiumFeature(icon: '📞', title: 'Priority Support', subtitle: 'Get help when you need it most'),
                _PremiumFeature(icon: '✨', title: 'Exclusive Reports', subtitle: 'Monthly personalized cosmic reports'),
                const SizedBox(height: 30),

                // Plans
                ...List.generate(_plans.length, (index) {
                  final plan = _plans[index];
                  final isSelected = index == _selectedPlan;
                  return GestureDetector(
                    onTap: () => setState(() => _selectedPlan = index),
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: isSelected
                            ? LinearGradient(
                                colors: [
                                  CosmicTheme.stardustGold.withOpacity(0.2),
                                  CosmicTheme.nebulaPurple.withOpacity(0.2),
                                ],
                              )
                            : null,
                        color: isSelected ? null : CosmicTheme.cardDark,
                        border: Border.all(
                          color: isSelected
                              ? CosmicTheme.stardustGold
                              : CosmicTheme.nebulaPurple.withOpacity(0.2),
                          width: isSelected ? 2 : 1,
                        ),
                        boxShadow: isSelected
                            ? [
                                BoxShadow(
                                  color: CosmicTheme.stardustGold
                                      .withOpacity(0.2),
                                  blurRadius: 20,
                                ),
                              ]
                            : null,
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: isSelected
                                    ? CosmicTheme.stardustGold
                                    : CosmicTheme.textMuted,
                                width: 2,
                              ),
                              color: isSelected
                                  ? CosmicTheme.stardustGold
                                  : Colors.transparent,
                            ),
                            child: isSelected
                                ? Icon(Icons.check,
                                    color: CosmicTheme.deepSpace, size: 16)
                                : null,
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  plan.name,
                                  style: GoogleFonts.poppins(
                                    color: CosmicTheme.textPrimary,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Wrap(
                                  spacing: 6,
                                  children: plan.features
                                      .take(2)
                                      .map((f) => Text(
                                            '• $f',
                                            style: GoogleFonts.poppins(
                                              color: CosmicTheme.textMuted,
                                              fontSize: 11,
                                            ),
                                          ))
                                      .toList(),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                '₹${plan.price}',
                                style: GoogleFonts.orbitron(
                                  color: isSelected
                                      ? CosmicTheme.stardustGold
                                      : CosmicTheme.textPrimary,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                plan.period,
                                style: GoogleFonts.poppins(
                                  color: CosmicTheme.textMuted,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                }),
                const SizedBox(height: 20),

                CosmicButton(
                  text: 'Subscribe Now',
                  icon: Icons.workspace_premium,
                  onPressed: () {},
                ),
                const SizedBox(height: 12),
                Text(
                  'Cancel anytime. 7-day free trial included.',
                  style: GoogleFonts.poppins(
                    color: CosmicTheme.textMuted,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 100),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _PremiumFeature extends StatelessWidget {
  final String icon;
  final String title;
  final String subtitle;

  const _PremiumFeature({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: CosmicTheme.stardustGold.withOpacity(0.1),
            ),
            child: Center(child: Text(icon, style: TextStyle(fontSize: 20))),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    color: CosmicTheme.textPrimary,
                    fontSize: 14,
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
        ],
      ),
    );
  }
}

class _PremiumPlan {
  final String name;
  final int price;
  final String period;
  final List<String> features;

  const _PremiumPlan(this.name, this.price, this.period, this.features);
}

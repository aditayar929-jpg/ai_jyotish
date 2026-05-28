import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/theme/cosmic_theme.dart';
import '../../../core/widgets/cosmic_background.dart';
import '../../../core/widgets/glass_card.dart';
import '../../../core/widgets/cosmic_button.dart';

class PredictionsScreen extends ConsumerStatefulWidget {
  const PredictionsScreen({super.key});

  @override
  ConsumerState<PredictionsScreen> createState() => _PredictionsScreenState();
}

class _PredictionsScreenState extends ConsumerState<PredictionsScreen> {
  int _selectedCategory = 0;

  final List<_PredictionCategory> _categories = [
    _PredictionCategory('💼', 'Career', CosmicTheme.auroraGreen),
    _PredictionCategory('💍', 'Marriage', CosmicTheme.mysticPink),
    _PredictionCategory('💰', 'Finance', CosmicTheme.stardustGold),
    _PredictionCategory('🏥', 'Health', CosmicTheme.celestialTeal),
    _PredictionCategory('📚', 'Education', CosmicTheme.cosmicBlue),
    _PredictionCategory('🧘', 'Spiritual', CosmicTheme.nebulaPurple),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CosmicBackground(
        child: SafeArea(
          child: Column(
            children: [
              // Header
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
                      'AI Predictions',
                      style: GoogleFonts.orbitron(
                        fontSize: 20,
                        color: CosmicTheme.stardustGold,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              // Category Selector
              SizedBox(
                height: 90,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: _categories.length,
                  itemBuilder: (context, index) {
                    final cat = _categories[index];
                    final isSelected = index == _selectedCategory;
                    return GestureDetector(
                      onTap: () =>
                          setState(() => _selectedCategory = index),
                      child: Container(
                        width: 75,
                        margin: const EdgeInsets.only(right: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          gradient: isSelected
                              ? LinearGradient(
                                  colors: [
                                    cat.color.withOpacity(0.3),
                                    cat.color.withOpacity(0.1),
                                  ],
                                )
                              : null,
                          color: isSelected ? null : CosmicTheme.cardDark,
                          border: Border.all(
                            color: isSelected
                                ? cat.color.withOpacity(0.5)
                                : CosmicTheme.nebulaPurple.withOpacity(0.2),
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(cat.icon, style: TextStyle(fontSize: 24)),
                            const SizedBox(height: 6),
                            Text(
                              cat.label,
                              style: GoogleFonts.poppins(
                                color: isSelected
                                    ? cat.color
                                    : CosmicTheme.textMuted,
                                fontSize: 10,
                                fontWeight: isSelected
                                    ? FontWeight.w600
                                    : FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),

              // Prediction Content
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: _buildPredictionContent(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPredictionContent() {
    final cat = _categories[_selectedCategory];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Main Prediction Card
        GlowCard(
          glowColor: cat.color,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: cat.color.withOpacity(0.15),
                    ),
                    child: Text(cat.icon, style: TextStyle(fontSize: 28)),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${cat.label} Prediction',
                          style: GoogleFonts.orbitron(
                            fontSize: 16,
                            color: cat.color,
                          ),
                        ),
                        Text(
                          'Based on your birth chart',
                          style: GoogleFonts.poppins(
                            color: CosmicTheme.textMuted,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: CosmicTheme.auroraGreen.withOpacity(0.2),
                    ),
                    child: Text(
                      'Excellent',
                      style: GoogleFonts.poppins(
                        color: CosmicTheme.auroraGreen,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                _getCategoryPrediction(),
                style: GoogleFonts.poppins(
                  color: CosmicTheme.textSecondary,
                  fontSize: 14,
                  height: 1.6,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),

        // Timeline
        Text(
          'Timeline',
          style: GoogleFonts.orbitron(
            fontSize: 14,
            color: CosmicTheme.stardustGold,
          ),
        ),
        const SizedBox(height: 12),
        _TimelineCard(
          month: 'May 2026',
          prediction: 'New opportunities begin to emerge. Stay alert.',
          color: cat.color,
          isCurrentMonth: true,
        ),
        _TimelineCard(
          month: 'Jun 2026',
          prediction: 'Peak energy period. Take decisive action.',
          color: cat.color,
        ),
        _TimelineCard(
          month: 'Jul 2026',
          prediction: 'Jupiter transit brings expansion and growth.',
          color: cat.color,
        ),
        _TimelineCard(
          month: 'Aug 2026',
          prediction: 'Harvest the rewards of your efforts.',
          color: cat.color,
        ),
        const SizedBox(height: 20),

        // Advice
        GlassCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '🌟 AI Advice',
                style: GoogleFonts.poppins(
                  color: CosmicTheme.stardustGold,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                _getCategoryAdvice(),
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

        // Action Button
        CosmicButton(
          text: 'Get Detailed Report',
          icon: Icons.auto_awesome,
          onPressed: () {},
        ),
        const SizedBox(height: 100),
      ],
    );
  }

  String _getCategoryPrediction() {
    switch (_selectedCategory) {
      case 0:
        return 'Saturn\'s transit through your 10th house indicates a period of professional transformation. Your hard work will be recognized, and a promotion or new role is likely between June-August 2026. Jupiter\'s aspect brings expansion in business ventures. Network actively and trust your leadership abilities.';
      case 1:
        return 'Venus in your 7th house of partnerships creates a favorable period for romantic connections. If single, expect meaningful encounters through social events. Existing relationships will deepen. The period between April-September 2026 is particularly auspicious for commitment.';
      case 2:
        return 'Jupiter\'s favorable aspect on your wealth house brings financial abundance. Investment returns improve significantly after July. Avoid speculative trading during Mercury retrograde. Focus on long-term wealth building strategies.';
      case 3:
        return 'Mars energy supports physical vitality, but stress management is crucial. Regular exercise and meditation will maintain your well-being. Pay attention to heart health and maintain a balanced diet. Energy levels peak in summer months.';
      case 4:
        return 'Mercury\'s favorable position enhances learning abilities. This is an excellent time for academic pursuits, skill development, and intellectual growth. Exams and certifications are well-supported. Focus on consistent study habits.';
      case 5:
        return 'Your spiritual energy is at a peak. Deep meditation and mindfulness practices will yield profound insights. Connect with your inner self through yoga and prayer. The cosmic energies support spiritual awakening and self-discovery.';
      default:
        return '';
    }
  }

  String _getCategoryAdvice() {
    switch (_selectedCategory) {
      case 0:
        'Wear Emerald on Wednesday for Mercury\'s blessing. Chant "Om Budhaya Namaha" 108 times daily. Keep a green handkerchief in your pocket during important meetings.';
      case 1:
        'Wear Diamond or White Sapphire on Friday. Offer white flowers to Goddess Lakshmi. Recite Venus mantra "Om Shukraya Namaha" on Fridays.';
      case 2:
        'Wear Yellow Sapphire on Thursday. Donate yellow items on Thursdays. Chant "Om Brihaspataye Namaha" for Jupiter\'s financial blessings.';
      case 3:
        'Practice Surya Namaskar daily at sunrise. Wear Ruby for Sun\'s vitality. Drink water from a copper vessel in the morning.';
      case 4:
        'Wear Emerald for Mercury\'s intellectual boost. Study during Mercury hora for best results. Keep a green cloth on your study desk.';
      case 5:
        'Meditate during Brahma Muhurta (4-6 AM). Chant "Om Namah Shivaya" 108 times. Practice pranayama daily for spiritual energy.';
      default:
        '';
    }
    return 'Wear Emerald on Wednesday for Mercury\'s blessing. Chant "Om Budhaya Namaha" 108 times daily.';
  }
}

class _PredictionCategory {
  final String icon;
  final String label;
  final Color color;

  const _PredictionCategory(this.icon, this.label, this.color);
}

class _TimelineCard extends StatelessWidget {
  final String month;
  final String prediction;
  final Color color;
  final bool isCurrentMonth;

  const _TimelineCard({
    required this.month,
    required this.prediction,
    required this.color,
    this.isCurrentMonth = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isCurrentMonth ? color : CosmicTheme.cardDark,
                  border: Border.all(color: color, width: 2),
                ),
              ),
              Container(
                width: 2,
                height: 40,
                color: color.withOpacity(0.3),
              ),
            ],
          ),
          const SizedBox(width: 12),
          Expanded(
            child: GlassCard(
              padding: const EdgeInsets.all(12),
              border: isCurrentMonth
                  ? Border.all(color: color.withOpacity(0.4))
                  : null,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    month,
                    style: GoogleFonts.poppins(
                      color: color,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    prediction,
                    style: GoogleFonts.poppins(
                      color: CosmicTheme.textSecondary,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

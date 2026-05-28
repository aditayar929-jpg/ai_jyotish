import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/theme/cosmic_theme.dart';
import '../../../core/widgets/cosmic_background.dart';
import '../../../core/widgets/glass_card.dart';
import '../../../core/widgets/cosmic_button.dart';

class NumerologyScreen extends ConsumerStatefulWidget {
  const NumerologyScreen({super.key});

  @override
  ConsumerState<NumerologyScreen> createState() => _NumerologyScreenState();
}

class _NumerologyScreenState extends ConsumerState<NumerologyScreen> {
  final _nameController = TextEditingController();
  DateTime? _selectedDate;
  bool _calculated = false;

  void _calculate() {
    if (_nameController.text.isEmpty || _selectedDate == null) return;
    setState(() => _calculated = true);
  }

  int _calculateLifePath() {
    if (_selectedDate == null) return 0;
    final digits = _selectedDate.toString().split(' ')[0].replaceAll('-', '');
    int sum = digits.split('').map(int.parse).reduce((a, b) => a + b);
    while (sum > 9 && sum != 11 && sum != 22 && sum != 33) {
      sum = sum.toString().split('').map(int.parse).reduce((a, b) => a + b);
    }
    return sum;
  }

  int _calculateDestiny() {
    if (_nameController.text.isEmpty) return 0;
    final values = {
      'a': 1, 'b': 2, 'c': 3, 'd': 4, 'e': 5, 'f': 6, 'g': 7, 'h': 8,
      'i': 9, 'j': 1, 'k': 2, 'l': 3, 'm': 4, 'n': 5, 'o': 6, 'p': 7,
      'q': 8, 'r': 9, 's': 1, 't': 2, 'u': 3, 'v': 4, 'w': 5, 'x': 6,
      'y': 7, 'z': 8,
    };
    int sum = 0;
    for (final char in _nameController.text.toLowerCase().split('')) {
      sum += values[char] ?? 0;
    }
    while (sum > 9 && sum != 11 && sum != 22 && sum != 33) {
      sum = sum.toString().split('').map(int.parse).reduce((a, b) => a + b);
    }
    return sum;
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
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
                      'Numerology',
                      style: GoogleFonts.orbitron(
                        fontSize: 20,
                        color: CosmicTheme.stardustGold,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                if (!_calculated) ...[
                  // Input Form
                  Center(
                    child: Text(
                      '🔢',
                      style: TextStyle(fontSize: 60),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: Text(
                      'Discover Your Numbers',
                      style: GoogleFonts.orbitron(
                        fontSize: 18,
                        color: CosmicTheme.textPrimary,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Center(
                    child: Text(
                      'Enter your details to calculate your numerology chart',
                      style: GoogleFonts.poppins(
                        color: CosmicTheme.textSecondary,
                        fontSize: 13,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 30),
                  GlassCard(
                    child: TextField(
                      controller: _nameController,
                      style:
                          GoogleFonts.poppins(color: CosmicTheme.textPrimary),
                      decoration: InputDecoration(
                        hintText: 'Your Full Name',
                        prefixIcon: Icon(Icons.person_outline,
                            color: CosmicTheme.nebulaPurple),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  GlassCard(
                    onTap: () async {
                      final date = await showDatePicker(
                        context: context,
                        initialDate: DateTime(2000),
                        firstDate: DateTime(1940),
                        lastDate: DateTime.now(),
                        builder: (context, child) {
                          return Theme(
                            data: ThemeData.dark().copyWith(
                              colorScheme: ColorScheme.dark(
                                primary: CosmicTheme.nebulaPurple,
                                surface: CosmicTheme.cardDark,
                              ),
                            ),
                            child: child!,
                          );
                        },
                      );
                      if (date != null) {
                        setState(() => _selectedDate = date);
                      }
                    },
                    child: Row(
                      children: [
                        Icon(Icons.calendar_today,
                            color: CosmicTheme.nebulaPurple),
                        const SizedBox(width: 16),
                        Text(
                          _selectedDate != null
                              ? '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}'
                              : 'Date of Birth',
                          style: GoogleFonts.poppins(
                            color: _selectedDate != null
                                ? CosmicTheme.textPrimary
                                : CosmicTheme.textMuted,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  CosmicButton(
                    text: 'Calculate Numbers',
                    icon: Icons.calculate,
                    onPressed: _calculate,
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
    final lifePath = _calculateLifePath();
    final destiny = _calculateDestiny();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Text(
            'Your Numerology Chart',
            style: GoogleFonts.orbitron(
              fontSize: 18,
              color: CosmicTheme.stardustGold,
            ),
          ),
        ),
        const SizedBox(height: 20),

        // Core Numbers
        Row(
          children: [
            Expanded(
              child: _NumberCard(
                number: lifePath,
                label: 'Life Path',
                description: _getLifePathMeaning(lifePath),
                color: CosmicTheme.stardustGold,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _NumberCard(
                number: destiny,
                label: 'Destiny',
                description: _getDestinyMeaning(destiny),
                color: CosmicTheme.nebulaPurple,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _NumberCard(
                number: 7,
                label: 'Soul',
                description: 'Inner desires and motivations',
                color: CosmicTheme.celestialTeal,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _NumberCard(
                number: 3,
                label: 'Personality',
                description: 'How others perceive you',
                color: CosmicTheme.mysticPink,
              ),
            ),
          ],
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
                  _LuckyElement(icon: '🔢', label: 'Numbers', value: '3, 7, 9'),
                  _LuckyElement(icon: '🎨', label: 'Colors', value: 'Gold, Blue'),
                  _LuckyElement(icon: '💎', label: 'Gemstone', value: 'Topaz'),
                  _LuckyElement(icon: '📅', label: 'Day', value: 'Thursday'),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),

        // Personality Report
        GlassCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Personality Report',
                style: GoogleFonts.orbitron(
                  fontSize: 14,
                  color: CosmicTheme.stardustGold,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'As a Life Path $lifePath, you are a natural leader with strong intuitive abilities. Your analytical mind and creative spirit make you a problem solver. You have a deep desire for knowledge and wisdom, often seeking answers to life\'s deeper questions.',
                style: GoogleFonts.poppins(
                  color: CosmicTheme.textSecondary,
                  fontSize: 13,
                  height: 1.6,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),

        // Career Compatibility
        GlassCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Career Compatibility',
                style: GoogleFonts.orbitron(
                  fontSize: 14,
                  color: CosmicTheme.stardustGold,
                ),
              ),
              const SizedBox(height: 12),
              _CareerItem(career: 'Spiritual Teacher', match: 95),
              _CareerItem(career: 'Researcher', match: 90),
              _CareerItem(career: 'Counselor', match: 88),
              _CareerItem(career: 'Writer', match: 85),
              _CareerItem(career: 'Healer', match: 82),
            ],
          ),
        ),
        const SizedBox(height: 20),

        // Relationship Compatibility
        GlassCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Relationship Compatibility',
                style: GoogleFonts.orbitron(
                  fontSize: 14,
                  color: CosmicTheme.stardustGold,
                ),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _CompatNumber(number: 3, percent: 95),
                  _CompatNumber(number: 6, percent: 90),
                  _CompatNumber(number: 9, percent: 85),
                  _CompatNumber(number: 7, percent: 80),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),

        // Action Buttons
        Row(
          children: [
            Expanded(
              child: CosmicButton(
                text: 'Reset',
                icon: Icons.refresh,
                color: CosmicTheme.cardLight,
                onPressed: () => setState(() => _calculated = false),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: CosmicButton(
                text: 'Share',
                icon: Icons.share,
                onPressed: () {},
              ),
            ),
          ],
        ),
        const SizedBox(height: 100),
      ],
    );
  }

  String _getLifePathMeaning(int number) {
    switch (number) {
      case 1: return 'The Leader - Independent & ambitious';
      case 2: return 'The Peacemaker - Diplomatic & sensitive';
      case 3: return 'The Communicator - Creative & expressive';
      case 4: return 'The Builder - Practical & disciplined';
      case 5: return 'The Adventurer - Freedom-loving & versatile';
      case 6: return 'The Nurturer - Responsible & loving';
      case 7: return 'The Seeker - Analytical & spiritual';
      case 8: return 'The Achiever - Ambitious & powerful';
      case 9: return 'The Humanitarian - Compassionate & wise';
      case 11: return 'The Intuitive - Visionary & inspirational';
      case 22: return 'The Master Builder - Powerful & practical';
      case 33: return 'The Master Teacher - Compassionate & guiding';
      default: return '';
    }
  }

  String _getDestinyMeaning(int number) {
    switch (number) {
      case 1: return 'Born to lead and innovate';
      case 2: return 'Born to cooperate and bring harmony';
      case 3: return 'Born to inspire through creativity';
      case 4: return 'Born to build lasting foundations';
      case 5: return 'Born to bring change and freedom';
      case 6: return 'Born to nurture and heal';
      case 7: return 'Born to seek truth and wisdom';
      case 8: return 'Born to achieve material success';
      case 9: return 'Born to serve humanity';
      default: return '';
    }
  }
}

class _NumberCard extends StatelessWidget {
  final int number;
  final String label;
  final String description;
  final Color color;

  const _NumberCard({
    required this.number,
    required this.label,
    required this.description,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      border: Border.all(color: color.withOpacity(0.3)),
      child: Column(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  color.withOpacity(0.3),
                  color.withOpacity(0.1),
                  Colors.transparent,
                ],
              ),
              border: Border.all(color: color, width: 2),
            ),
            child: Center(
              child: Text(
                '$number',
                style: GoogleFonts.orbitron(
                  fontSize: 24,
                  color: color,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: GoogleFonts.poppins(
              color: color,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            description,
            style: GoogleFonts.poppins(
              color: CosmicTheme.textMuted,
              fontSize: 10,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _LuckyElement extends StatelessWidget {
  final String icon;
  final String label;
  final String value;

  const _LuckyElement({
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
            fontSize: 12,
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

class _CareerItem extends StatelessWidget {
  final String career;
  final int match;

  const _CareerItem({required this.career, required this.match});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Expanded(
            child: Text(
              career,
              style: GoogleFonts.poppins(
                color: CosmicTheme.textPrimary,
                fontSize: 13,
              ),
            ),
          ),
          Text(
            '$match%',
            style: GoogleFonts.poppins(
              color: CosmicTheme.auroraGreen,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _CompatNumber extends StatelessWidget {
  final int number;
  final int percent;

  const _CompatNumber({required this.number, required this.percent});

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
                valueColor: AlwaysStoppedAnimation(CosmicTheme.stardustGold),
                strokeWidth: 4,
              ),
            ),
            Text(
              '$number',
              style: GoogleFonts.orbitron(
                color: CosmicTheme.stardustGold,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          '$percent%',
          style: GoogleFonts.poppins(
            color: CosmicTheme.textSecondary,
            fontSize: 10,
          ),
        ),
      ],
    );
  }
}

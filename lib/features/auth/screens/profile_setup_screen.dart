import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../core/theme/cosmic_theme.dart';
import '../../../core/widgets/cosmic_background.dart';
import '../../../core/widgets/cosmic_button.dart';
import '../../../core/widgets/glass_card.dart';
import '../../../core/constants/app_strings.dart';

class ProfileSetupScreen extends ConsumerStatefulWidget {
  const ProfileSetupScreen({super.key});

  @override
  ConsumerState<ProfileSetupScreen> createState() =>
      _ProfileSetupScreenState();
}

class _ProfileSetupScreenState extends ConsumerState<ProfileSetupScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final _nameController = TextEditingController();
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  String? _selectedGender;
  String? _selectedZodiac;
  String? _selectedRelationship;

  final List<String> _genders = ['Male', 'Female', 'Other'];
  final List<String> _relationships = [
    'Single',
    'In a Relationship',
    'Married',
    'Divorced',
    'Complicated',
  ];

  void _nextPage() {
    if (_currentPage < 2) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _completeSetup();
    }
  }

  void _completeSetup() async {
    // Save profile data
    await Future.delayed(const Duration(seconds: 1));
    if (mounted) context.go('/');
  }

  @override
  void dispose() {
    _pageController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CosmicBackground(
        child: SafeArea(
          child: Column(
            children: [
              // Progress
              Padding(
                padding: const EdgeInsets.all(24),
                child: Row(
                  children: List.generate(3, (index) {
                    return Expanded(
                      child: Container(
                        height: 4,
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2),
                          gradient: index <= _currentPage
                              ? CosmicTheme.goldGradient
                              : null,
                          color: index <= _currentPage
                              ? null
                              : CosmicTheme.textMuted.withOpacity(0.2),
                        ),
                      ),
                    );
                  }),
                ),
              ),
              // Pages
              Expanded(
                child: PageView(
                  controller: _pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  onPageChanged: (index) {
                    setState(() => _currentPage = index);
                  },
                  children: [
                    _buildPersonalInfoPage(),
                    _buildBirthDetailsPage(),
                    _buildPreferencesPage(),
                  ],
                ),
              ),
              // Navigation
              Padding(
                padding: const EdgeInsets.all(24),
                child: Row(
                  children: [
                    if (_currentPage > 0)
                      Expanded(
                        child: CosmicButton(
                          text: 'Back',
                          color: CosmicTheme.cardLight,
                          onPressed: () {
                            _pageController.previousPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                          },
                        ),
                      ),
                    if (_currentPage > 0) const SizedBox(width: 16),
                    Expanded(
                      flex: 2,
                      child: CosmicButton(
                        text: _currentPage == 2 ? 'Complete' : 'Next',
                        icon: _currentPage == 2
                            ? Icons.check
                            : Icons.arrow_forward,
                        onPressed: _nextPage,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPersonalInfoPage() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          Text(
            '👤',
            style: TextStyle(fontSize: 50),
          ),
          const SizedBox(height: 16),
          Text(
            'Personal Info',
            style: GoogleFonts.orbitron(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: CosmicTheme.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Tell us about yourself',
            style: GoogleFonts.poppins(
              color: CosmicTheme.textSecondary,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 30),
          GlassCard(
            child: Column(
              children: [
                TextField(
                  controller: _nameController,
                  style: GoogleFonts.poppins(color: CosmicTheme.textPrimary),
                  decoration: InputDecoration(
                    hintText: 'Your Name',
                    prefixIcon: Icon(Icons.person_outline,
                        color: CosmicTheme.nebulaPurple),
                    border: InputBorder.none,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Gender',
            style: GoogleFonts.poppins(
              color: CosmicTheme.textSecondary,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: _genders.map((gender) {
              final isSelected = _selectedGender == gender;
              return Expanded(
                child: GestureDetector(
                  onTap: () => setState(() => _selectedGender = gender),
                  child: GlassCard(
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    border: Border.all(
                      color: isSelected
                          ? CosmicTheme.stardustGold
                          : CosmicTheme.nebulaPurple.withOpacity(0.3),
                      width: isSelected ? 2 : 1,
                    ),
                    child: Center(
                      child: Text(
                        gender,
                        style: GoogleFonts.poppins(
                          color: isSelected
                              ? CosmicTheme.stardustGold
                              : CosmicTheme.textSecondary,
                          fontWeight:
                              isSelected ? FontWeight.w600 : FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildBirthDetailsPage() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          Text(
            '🌟',
            style: TextStyle(fontSize: 50),
          ),
          const SizedBox(height: 16),
          Text(
            'Birth Details',
            style: GoogleFonts.orbitron(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: CosmicTheme.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'For accurate predictions',
            style: GoogleFonts.poppins(
              color: CosmicTheme.textSecondary,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 30),
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
              if (date != null) setState(() => _selectedDate = date);
            },
            child: Row(
              children: [
                Icon(Icons.calendar_today, color: CosmicTheme.nebulaPurple),
                const SizedBox(width: 16),
                Text(
                  _selectedDate != null
                      ? DateFormat('dd MMM yyyy').format(_selectedDate!)
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
          const SizedBox(height: 16),
          GlassCard(
            onTap: () async {
              final time = await showTimePicker(
                context: context,
                initialTime: TimeOfDay(hour: 12, minute: 0),
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
              if (time != null) setState(() => _selectedTime = time);
            },
            child: Row(
              children: [
                Icon(Icons.access_time, color: CosmicTheme.nebulaPurple),
                const SizedBox(width: 16),
                Text(
                  _selectedTime != null
                      ? _selectedTime!.format(context)
                      : 'Time of Birth',
                  style: GoogleFonts.poppins(
                    color: _selectedTime != null
                        ? CosmicTheme.textPrimary
                        : CosmicTheme.textMuted,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          GlassCard(
            onTap: () {
              // Open place picker
            },
            child: Row(
              children: [
                Icon(Icons.location_on_outlined,
                    color: CosmicTheme.nebulaPurple),
                const SizedBox(width: 16),
                Text(
                  'Place of Birth',
                  style: GoogleFonts.poppins(
                    color: CosmicTheme.textMuted,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPreferencesPage() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          Text(
            '🔮',
            style: TextStyle(fontSize: 50),
          ),
          const SizedBox(height: 16),
          Text(
            'Preferences',
            style: GoogleFonts.orbitron(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: CosmicTheme.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Customize your experience',
            style: GoogleFonts.poppins(
              color: CosmicTheme.textSecondary,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 30),
          Text(
            'Relationship Status',
            style: GoogleFonts.poppins(
              color: CosmicTheme.textSecondary,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _relationships.map((status) {
              final isSelected = _selectedRelationship == status;
              return GestureDetector(
                onTap: () =>
                    setState(() => _selectedRelationship = status),
                child: GlassCard(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  border: Border.all(
                    color: isSelected
                        ? CosmicTheme.stardustGold
                        : CosmicTheme.nebulaPurple.withOpacity(0.3),
                    width: isSelected ? 2 : 1,
                  ),
                  child: Text(
                    status,
                    style: GoogleFonts.poppins(
                      color: isSelected
                          ? CosmicTheme.stardustGold
                          : CosmicTheme.textSecondary,
                      fontWeight:
                          isSelected ? FontWeight.w600 : FontWeight.normal,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 30),
          Text(
            'Your Zodiac Sign',
            style: GoogleFonts.poppins(
              color: CosmicTheme.textSecondary,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            alignment: WrapAlignment.center,
            children: AppStrings.zodiacSigns.map((sign) {
              final isSelected = _selectedZodiac == sign;
              return GestureDetector(
                onTap: () => setState(() => _selectedZodiac = sign),
                child: GlassCard(
                  padding: const EdgeInsets.all(12),
                  border: Border.all(
                    color: isSelected
                        ? CosmicTheme.stardustGold
                        : CosmicTheme.nebulaPurple.withOpacity(0.3),
                    width: isSelected ? 2 : 1,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        AppStrings.zodiacSymbols[sign] ?? '',
                        style: TextStyle(
                          fontSize: 24,
                          color: isSelected
                              ? CosmicTheme.stardustGold
                              : CosmicTheme.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        sign,
                        style: GoogleFonts.poppins(
                          fontSize: 10,
                          color: isSelected
                              ? CosmicTheme.stardustGold
                              : CosmicTheme.textMuted,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

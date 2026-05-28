import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/theme/cosmic_theme.dart';
import '../../../core/widgets/cosmic_background.dart';
import '../../../core/widgets/glass_card.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  bool _notificationsEnabled = true;
  bool _dailyHoroscope = true;
  bool _luckyAlerts = true;
  bool _planetaryAlerts = false;
  bool _darkMode = true;
  String _language = 'English';

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
                      'Settings',
                      style: GoogleFonts.orbitron(
                        fontSize: 20,
                        color: CosmicTheme.stardustGold,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Notifications
                Text(
                  'Notifications',
                  style: GoogleFonts.poppins(
                    color: CosmicTheme.textMuted,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1,
                  ),
                ),
                const SizedBox(height: 8),
                _SwitchTile(
                  icon: Icons.notifications_outlined,
                  title: 'Push Notifications',
                  value: _notificationsEnabled,
                  onChanged: (v) =>
                      setState(() => _notificationsEnabled = v),
                ),
                _SwitchTile(
                  icon: Icons.star_outline,
                  title: 'Daily Horoscope',
                  value: _dailyHoroscope,
                  onChanged: (v) => setState(() => _dailyHoroscope = v),
                ),
                _SwitchTile(
                  icon: Icons.format_list_numbered,
                  title: 'Lucky Time Alerts',
                  value: _luckyAlerts,
                  onChanged: (v) => setState(() => _luckyAlerts = v),
                ),
                _SwitchTile(
                  icon: Icons.public,
                  title: 'Planetary Change Alerts',
                  value: _planetaryAlerts,
                  onChanged: (v) =>
                      setState(() => _planetaryAlerts = v),
                ),
                const SizedBox(height: 20),

                // Appearance
                Text(
                  'Appearance',
                  style: GoogleFonts.poppins(
                    color: CosmicTheme.textMuted,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1,
                  ),
                ),
                const SizedBox(height: 8),
                _SwitchTile(
                  icon: Icons.dark_mode_outlined,
                  title: 'Dark Mode',
                  value: _darkMode,
                  onChanged: (v) => setState(() => _darkMode = v),
                ),
                GlassCard(
                  margin: const EdgeInsets.only(bottom: 8),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  child: Row(
                    children: [
                      Icon(Icons.language,
                          color: CosmicTheme.nebulaPurple, size: 22),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Text(
                          'Language',
                          style: GoogleFonts.poppins(
                            color: CosmicTheme.textPrimary,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      DropdownButton<String>(
                        value: _language,
                        dropdownColor: CosmicTheme.cardDark,
                        style: GoogleFonts.poppins(
                          color: CosmicTheme.textSecondary,
                          fontSize: 13,
                        ),
                        underline: const SizedBox(),
                        items: ['English', 'Hindi', 'Bengali', 'Tamil', 'Telugu']
                            .map((l) => DropdownMenuItem(
                                  value: l,
                                  child: Text(l),
                                ))
                            .toList(),
                        onChanged: (v) {
                          if (v != null) setState(() => _language = v);
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // Account
                Text(
                  'Account',
                  style: GoogleFonts.poppins(
                    color: CosmicTheme.textMuted,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1,
                  ),
                ),
                const SizedBox(height: 8),
                _SettingsTile(
                  icon: Icons.lock_outline,
                  title: 'Change Password',
                  onTap: () {},
                ),
                _SettingsTile(
                  icon: Icons.privacy_tip_outlined,
                  title: 'Privacy Policy',
                  onTap: () {},
                ),
                _SettingsTile(
                  icon: Icons.description_outlined,
                  title: 'Terms of Service',
                  onTap: () {},
                ),
                _SettingsTile(
                  icon: Icons.delete_outline,
                  title: 'Delete Account',
                  titleColor: CosmicTheme.errorRed,
                  onTap: () {},
                ),
                const SizedBox(height: 20),

                // App Info
                Center(
                  child: Text(
                    'AI Jyotish v1.0.0',
                    style: GoogleFonts.poppins(
                      color: CosmicTheme.textMuted,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SwitchTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool value;
  final ValueChanged<bool> onChanged;

  const _SwitchTile({
    required this.icon,
    required this.title,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        children: [
          Icon(icon, color: CosmicTheme.nebulaPurple, size: 22),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              title,
              style: GoogleFonts.poppins(
                color: CosmicTheme.textPrimary,
                fontSize: 14,
              ),
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: CosmicTheme.stardustGold,
            activeTrackColor: CosmicTheme.stardustGold.withOpacity(0.3),
          ),
        ],
      ),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color? titleColor;
  final VoidCallback onTap;

  const _SettingsTile({
    required this.icon,
    required this.title,
    this.titleColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      onTap: onTap,
      child: Row(
        children: [
          Icon(icon, color: titleColor ?? CosmicTheme.nebulaPurple, size: 22),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              title,
              style: GoogleFonts.poppins(
                color: titleColor ?? CosmicTheme.textPrimary,
                fontSize: 14,
              ),
            ),
          ),
          Icon(
            Icons.arrow_forward_ios,
            color: CosmicTheme.textMuted,
            size: 16,
          ),
        ],
      ),
    );
  }
}

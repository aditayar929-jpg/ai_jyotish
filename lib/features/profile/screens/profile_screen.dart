import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/theme/cosmic_theme.dart';
import '../../../core/widgets/cosmic_background.dart';
import '../../../core/widgets/glass_card.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CosmicBackground(
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              // Profile Header
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
                'Cosmic Seeker',
                style: GoogleFonts.orbitron(
                  fontSize: 22,
                  color: CosmicTheme.textPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Aries ♈ • Member since 2024',
                style: GoogleFonts.poppins(
                  color: CosmicTheme.textSecondary,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 20),

              // Stats Row
              Row(
                children: [
                  Expanded(
                    child: _StatCard(
                      label: 'Credits',
                      value: '150',
                      icon: '💰',
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _StatCard(
                      label: 'Readings',
                      value: '23',
                      icon: '📊',
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _StatCard(
                      label: 'Chats',
                      value: '45',
                      icon: '💬',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Menu Items
              _ProfileMenuItem(
                icon: Icons.person_outline,
                title: 'Edit Profile',
                onTap: () {},
              ),
              _ProfileMenuItem(
                icon: Icons.history,
                title: 'My Kundli History',
                onTap: () {},
              ),
              _ProfileMenuItem(
                icon: Icons.chat_bubble_outline,
                title: 'Chat History',
                onTap: () {},
              ),
              _ProfileMenuItem(
                icon: Icons.workspace_premium,
                title: 'Premium Subscription',
                onTap: () => context.push('/premium'),
              ),
              _ProfileMenuItem(
                icon: Icons.account_balance_wallet_outlined,
                title: 'Wallet',
                onTap: () => context.push('/wallet'),
              ),
              _ProfileMenuItem(
                icon: Icons.notifications_outlined,
                title: 'Notifications',
                onTap: () {},
              ),
              _ProfileMenuItem(
                icon: Icons.language,
                title: 'Language',
                subtitle: 'English',
                onTap: () {},
              ),
              _ProfileMenuItem(
                icon: Icons.settings_outlined,
                title: 'Settings',
                onTap: () => context.push('/settings'),
              ),
              _ProfileMenuItem(
                icon: Icons.help_outline,
                title: 'Help & Support',
                onTap: () {},
              ),
              _ProfileMenuItem(
                icon: Icons.info_outline,
                title: 'About',
                onTap: () {},
              ),
              _ProfileMenuItem(
                icon: Icons.share_outlined,
                title: 'Share App',
                onTap: () {},
              ),
              const SizedBox(height: 20),

              // Logout
              GlassCard(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      backgroundColor: CosmicTheme.cardDark,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      title: Text(
                        'Logout',
                        style: GoogleFonts.poppins(
                          color: CosmicTheme.textPrimary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      content: Text(
                        'Are you sure you want to logout?',
                        style: GoogleFonts.poppins(
                          color: CosmicTheme.textSecondary,
                        ),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text(
                            'Cancel',
                            style: GoogleFonts.poppins(
                              color: CosmicTheme.textMuted,
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            context.go('/auth/login');
                          },
                          child: Text(
                            'Logout',
                            style: GoogleFonts.poppins(
                              color: CosmicTheme.errorRed,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
                border: Border.all(
                  color: CosmicTheme.errorRed.withOpacity(0.3),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.logout, color: CosmicTheme.errorRed, size: 20),
                    const SizedBox(width: 8),
                    Text(
                      'Logout',
                      style: GoogleFonts.poppins(
                        color: CosmicTheme.errorRed,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final String value;
  final String icon;

  const _StatCard({
    required this.label,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.all(14),
      child: Column(
        children: [
          Text(icon, style: TextStyle(fontSize: 24)),
          const SizedBox(height: 6),
          Text(
            value,
            style: GoogleFonts.orbitron(
              color: CosmicTheme.stardustGold,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            label,
            style: GoogleFonts.poppins(
              color: CosmicTheme.textMuted,
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }
}

class _ProfileMenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final VoidCallback onTap;

  const _ProfileMenuItem({
    required this.icon,
    required this.title,
    this.subtitle,
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
          if (subtitle != null)
            Text(
              subtitle!,
              style: GoogleFonts.poppins(
                color: CosmicTheme.textMuted,
                fontSize: 13,
              ),
            ),
          const SizedBox(width: 8),
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

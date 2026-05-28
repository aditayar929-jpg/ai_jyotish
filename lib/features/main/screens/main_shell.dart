import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/theme/cosmic_theme.dart';

class MainShell extends StatelessWidget {
  final Widget child;

  const MainShell({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: _CosmicBottomNav(),
      floatingActionButton: _AiChatFab(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class _CosmicBottomNav extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).matchedLocation;
    int currentIndex = 0;
    if (location == '/') currentIndex = 0;
    else if (location == '/horoscope') currentIndex = 1;
    else if (location == '/kundli') currentIndex = 2;
    else if (location == '/profile') currentIndex = 3;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            CosmicTheme.galaxyDark.withOpacity(0.95),
            CosmicTheme.deepSpace,
          ],
        ),
        border: Border(
          top: BorderSide(
            color: CosmicTheme.nebulaPurple.withOpacity(0.2),
            width: 1,
          ),
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _NavItem(
                icon: Icons.home_rounded,
                label: 'Home',
                isSelected: currentIndex == 0,
                onTap: () => context.go('/'),
              ),
              _NavItem(
                icon: Icons.star_rounded,
                label: 'Horoscope',
                isSelected: currentIndex == 1,
                onTap: () => context.go('/horoscope'),
              ),
              const SizedBox(width: 60), // Space for FAB
              _NavItem(
                icon: Icons.grid_view_rounded,
                label: 'Kundli',
                isSelected: currentIndex == 2,
                onTap: () => context.go('/kundli'),
              ),
              _NavItem(
                icon: Icons.person_rounded,
                label: 'Profile',
                isSelected: currentIndex == 3,
                onTap: () => context.go('/profile'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: isSelected
                  ? CosmicTheme.nebulaPurple.withOpacity(0.2)
                  : Colors.transparent,
            ),
            child: Icon(
              icon,
              color: isSelected
                  ? CosmicTheme.stardustGold
                  : CosmicTheme.textMuted,
              size: 26,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 11,
              color: isSelected
                  ? CosmicTheme.stardustGold
                  : CosmicTheme.textMuted,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}

class _AiChatFab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push('/ai-chat'),
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: CosmicTheme.purpleGradient,
          boxShadow: [
            BoxShadow(
              color: CosmicTheme.nebulaPurple.withOpacity(0.5),
              blurRadius: 20,
              spreadRadius: 2,
            ),
          ],
          border: Border.all(
            color: CosmicTheme.stardustGold.withOpacity(0.5),
            width: 2,
          ),
        ),
        child: Center(
          child: Text(
            '🔮',
            style: TextStyle(fontSize: 28),
          ),
        ),
      ),
    );
  }
}

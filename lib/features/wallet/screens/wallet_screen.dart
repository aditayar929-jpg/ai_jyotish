import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/theme/cosmic_theme.dart';
import '../../../core/widgets/cosmic_background.dart';
import '../../../core/widgets/glass_card.dart';
import '../../../core/widgets/cosmic_button.dart';

class WalletScreen extends ConsumerStatefulWidget {
  const WalletScreen({super.key});

  @override
  ConsumerState<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends ConsumerState<WalletScreen> {
  int _selectedPlan = 1;
  int _walletBalance = 150;

  final List<_RechargePlan> _plans = [
    _RechargePlan(coins: 50, price: 49, bonus: 0),
    _RechargePlan(coins: 100, price: 99, bonus: 10),
    _RechargePlan(coins: 250, price: 199, bonus: 50),
    _RechargePlan(coins: 500, price: 399, bonus: 150),
    _RechargePlan(coins: 1000, price: 699, bonus: 400),
    _RechargePlan(coins: 2000, price: 1299, bonus: 1000),
  ];

  final List<_Transaction> _transactions = [
    _Transaction('Chat with Dr. Sharma', '-25', '2 min ago', false),
    _Transaction('Wallet Recharge', '+100', '1 hr ago', true),
    _Transaction('AI Prediction', '-10', '3 hrs ago', false),
    _Transaction('Referral Bonus', '+50', 'Yesterday', true),
    _Transaction('Palm Reading', '-15', '2 days ago', false),
    _Transaction('Wallet Recharge', '+250', '3 days ago', true),
  ];

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
                      'Wallet',
                      style: GoogleFonts.orbitron(
                        fontSize: 20,
                        color: CosmicTheme.stardustGold,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Balance Card
                GlowCard(
                  glowColor: CosmicTheme.stardustGold,
                  child: Column(
                    children: [
                      Text(
                        '💰',
                        style: TextStyle(fontSize: 40),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Wallet Balance',
                        style: GoogleFonts.poppins(
                          color: CosmicTheme.textSecondary,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '$_walletBalance',
                            style: GoogleFonts.orbitron(
                              fontSize: 40,
                              color: CosmicTheme.stardustGold,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Coins',
                            style: GoogleFonts.poppins(
                              color: CosmicTheme.textMuted,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '1 Coin = ₹1',
                        style: GoogleFonts.poppins(
                          color: CosmicTheme.textMuted,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Recharge Plans
                Text(
                  'Recharge Plans',
                  style: GoogleFonts.orbitron(
                    fontSize: 16,
                    color: CosmicTheme.stardustGold,
                  ),
                ),
                const SizedBox(height: 12),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 0.9,
                  ),
                  itemCount: _plans.length,
                  itemBuilder: (context, index) {
                    final plan = _plans[index];
                    final isSelected = index == _selectedPlan;
                    return GestureDetector(
                      onTap: () => setState(() => _selectedPlan = index),
                      child: GlassCard(
                        padding: const EdgeInsets.all(12),
                        border: Border.all(
                          color: isSelected
                              ? CosmicTheme.stardustGold
                              : CosmicTheme.nebulaPurple.withOpacity(0.2),
                          width: isSelected ? 2 : 1,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '${plan.coins}',
                              style: GoogleFonts.orbitron(
                                fontSize: 22,
                                color: isSelected
                                    ? CosmicTheme.stardustGold
                                    : CosmicTheme.textPrimary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Coins',
                              style: GoogleFonts.poppins(
                                color: CosmicTheme.textMuted,
                                fontSize: 11,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '₹${plan.price}',
                              style: GoogleFonts.poppins(
                                color: CosmicTheme.textSecondary,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            if (plan.bonus > 0)
                              Container(
                                margin: const EdgeInsets.only(top: 4),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 2),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color:
                                      CosmicTheme.auroraGreen.withOpacity(0.2),
                                ),
                                child: Text(
                                  '+${plan.bonus} bonus',
                                  style: GoogleFonts.poppins(
                                    color: CosmicTheme.auroraGreen,
                                    fontSize: 9,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 20),

                CosmicButton(
                  text: 'Recharge Now',
                  icon: Icons.account_balance_wallet,
                  onPressed: () {},
                ),
                const SizedBox(height: 24),

                // Transaction History
                Text(
                  'Transaction History',
                  style: GoogleFonts.orbitron(
                    fontSize: 16,
                    color: CosmicTheme.stardustGold,
                  ),
                ),
                const SizedBox(height: 12),
                ..._transactions.map((t) => GlassCard(
                      margin: const EdgeInsets.only(bottom: 8),
                      padding: const EdgeInsets.all(14),
                      child: Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: t.isCredit
                                  ? CosmicTheme.auroraGreen.withOpacity(0.15)
                                  : CosmicTheme.errorRed.withOpacity(0.15),
                            ),
                            child: Icon(
                              t.isCredit
                                  ? Icons.arrow_downward
                                  : Icons.arrow_upward,
                              color: t.isCredit
                                  ? CosmicTheme.auroraGreen
                                  : CosmicTheme.errorRed,
                              size: 20,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  t.title,
                                  style: GoogleFonts.poppins(
                                    color: CosmicTheme.textPrimary,
                                    fontSize: 13,
                                  ),
                                ),
                                Text(
                                  t.time,
                                  style: GoogleFonts.poppins(
                                    color: CosmicTheme.textMuted,
                                    fontSize: 11,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            '${t.amount} Coins',
                            style: GoogleFonts.poppins(
                              color: t.isCredit
                                  ? CosmicTheme.auroraGreen
                                  : CosmicTheme.errorRed,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _RechargePlan {
  final int coins;
  final int price;
  final int bonus;

  const _RechargePlan({
    required this.coins,
    required this.price,
    required this.bonus,
  });
}

class _Transaction {
  final String title;
  final String amount;
  final String time;
  final bool isCredit;

  const _Transaction(this.title, this.amount, this.time, this.isCredit);
}

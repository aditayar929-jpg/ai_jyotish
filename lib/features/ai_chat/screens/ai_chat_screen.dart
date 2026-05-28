import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/theme/cosmic_theme.dart';
import '../../../core/widgets/cosmic_background.dart';
import '../../../core/widgets/glass_card.dart';

class AiChatScreen extends ConsumerStatefulWidget {
  const AiChatScreen({super.key});

  @override
  ConsumerState<AiChatScreen> createState() => _AiChatScreenState();
}

class _AiChatScreenState extends ConsumerState<AiChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final List<_ChatMessage> _messages = [];
  bool _isTyping = false;

  final List<String> _suggestions = [
    'Will I get a promotion this year?',
    'When will I find my soulmate?',
    'What career is best for me?',
    'Tell me about my health in 2026',
    'What are my lucky numbers?',
    'How will my finances be?',
  ];

  @override
  void initState() {
    super.initState();
    _addBotMessage(
      'Namaste! 🙏 I am your AI Jyotish assistant. I can help you with astrological predictions based on your birth chart. What would you like to know?',
    );
  }

  void _addBotMessage(String text) {
    setState(() {
      _messages.add(_ChatMessage(
        text: text,
        isUser: false,
        timestamp: DateTime.now(),
      ));
    });
  }

  void _sendMessage(String text) async {
    if (text.trim().isEmpty) return;

    setState(() {
      _messages.add(_ChatMessage(
        text: text,
        isUser: true,
        timestamp: DateTime.now(),
      ));
      _isTyping = true;
    });

    _messageController.clear();
    _scrollToBottom();

    // Simulate AI response
    await Future.delayed(const Duration(seconds: 2));

    final response = _generateResponse(text);
    setState(() {
      _isTyping = false;
      _messages.add(_ChatMessage(
        text: response,
        isUser: false,
        timestamp: DateTime.now(),
      ));
    });
    _scrollToBottom();
  }

  String _generateResponse(String query) {
    final q = query.toLowerCase();
    if (q.contains('marriage') || q.contains('marry') || q.contains('soulmate')) {
      return 'Based on your birth chart, Venus is positioned in your 7th house of partnerships. This indicates a strong possibility of finding your soulmate between April and September 2026. Jupiter\'s transit through your 5th house suggests romantic encounters through social gatherings. Keep your heart open! 💕';
    } else if (q.contains('job') || q.contains('career') || q.contains('promotion')) {
      return 'Your 10th house lord Saturn is currently transiting through Aquarius, which is highly favorable for career advancement. The period between June-August 2026 looks particularly promising for promotions or new opportunities. Focus on networking and skill development. Mercury retrograde in May advises caution with new contracts. 💼';
    } else if (q.contains('health')) {
      return 'Mars in your 6th house suggests you need to pay attention to your physical health. Regular exercise and a balanced diet are crucial. The planetary alignment indicates some stress-related issues in the coming months. I recommend meditation and yoga for mental well-being. Avoid spicy foods during Mars transit. 🏥';
    } else if (q.contains('money') || q.contains('finance') || q.contains('wealth')) {
      return 'Jupiter\'s favorable aspect on your 2nd house of wealth indicates financial growth in 2026. The period after July looks especially prosperous. Consider long-term investments during this time. Avoid speculative trading during Mercury retrograde periods. Your lucky numbers for financial decisions are 3, 7, and 9. 💰';
    } else if (q.contains('lucky') || q.contains('number')) {
      return 'Based on your birth chart and numerology:\n\n🔢 Lucky Numbers: 3, 7, 9, 12\n🎨 Lucky Colors: Gold, Royal Blue\n📅 Lucky Days: Thursday, Friday\n⏰ Lucky Time: 10 AM - 12 PM\n\nThese numbers resonate with your planetary positions and can bring positive energy! ✨';
    } else {
      return 'Based on your birth chart analysis, the cosmic energies are aligning in your favor. With Jupiter\'s positive influence and Saturn\'s grounding energy, this is a period of growth and transformation. Trust your intuition and stay focused on your goals. The stars suggest wonderful opportunities ahead! Would you like me to elaborate on any specific area of your life? 🔮';
    }
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CosmicBackground(
        child: SafeArea(
          child: Column(
            children: [
              // Header
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: CosmicTheme.nebulaPurple.withOpacity(0.2),
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(Icons.arrow_back_ios,
                          color: CosmicTheme.textPrimary),
                    ),
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: CosmicTheme.purpleGradient,
                      ),
                      child: Center(
                        child: Text('🔮', style: TextStyle(fontSize: 20)),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'AI Jyotish',
                            style: GoogleFonts.poppins(
                              color: CosmicTheme.textPrimary,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            'Online • Powered by AI',
                            style: GoogleFonts.poppins(
                              color: CosmicTheme.auroraGreen,
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.more_vert,
                          color: CosmicTheme.textSecondary),
                    ),
                  ],
                ),
              ),

              // Messages
              Expanded(
                child: ListView.builder(
                  controller: _scrollController,
                  padding: const EdgeInsets.all(16),
                  itemCount: _messages.length + (_isTyping ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index == _messages.length) {
                      return _TypingIndicator();
                    }
                    return _ChatBubble(message: _messages[index]);
                  },
                ),
              ),

              // Suggestions
              if (_messages.length <= 2)
                SizedBox(
                  height: 40,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: _suggestions.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () => _sendMessage(_suggestions[index]),
                        child: Container(
                          margin: const EdgeInsets.only(right: 8),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: CosmicTheme.cardDark,
                            border: Border.all(
                              color: CosmicTheme.nebulaPurple.withOpacity(0.3),
                            ),
                          ),
                          child: Text(
                            _suggestions[index],
                            style: GoogleFonts.poppins(
                              color: CosmicTheme.textSecondary,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              const SizedBox(height: 8),

              // Input
              Container(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: CosmicTheme.nebulaPurple.withOpacity(0.2),
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.mic,
                          color: CosmicTheme.nebulaPurple),
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24),
                          color: CosmicTheme.cardDark,
                          border: Border.all(
                            color: CosmicTheme.nebulaPurple.withOpacity(0.3),
                          ),
                        ),
                        child: TextField(
                          controller: _messageController,
                          style: GoogleFonts.poppins(
                            color: CosmicTheme.textPrimary,
                            fontSize: 14,
                          ),
                          decoration: InputDecoration(
                            hintText: 'Ask about your future...',
                            hintStyle: GoogleFonts.poppins(
                              color: CosmicTheme.textMuted,
                              fontSize: 14,
                            ),
                            border: InputBorder.none,
                            contentPadding:
                                const EdgeInsets.symmetric(vertical: 12),
                          ),
                          onSubmitted: _sendMessage,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: () => _sendMessage(_messageController.text),
                      child: Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: CosmicTheme.purpleGradient,
                        ),
                        child: Icon(Icons.send, color: Colors.white, size: 20),
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
}

class _ChatMessage {
  final String text;
  final bool isUser;
  final DateTime timestamp;

  const _ChatMessage({
    required this.text,
    required this.isUser,
    required this.timestamp,
  });
}

class _ChatBubble extends StatelessWidget {
  final _ChatMessage message;

  const _ChatBubble({required this.message});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment:
          message.isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.8,
        ),
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(16),
            topRight: const Radius.circular(16),
            bottomLeft: Radius.circular(message.isUser ? 16 : 4),
            bottomRight: Radius.circular(message.isUser ? 4 : 16),
          ),
          gradient: message.isUser
              ? LinearGradient(
                  colors: [
                    CosmicTheme.nebulaPurple,
                    CosmicTheme.nebulaPurple.withOpacity(0.8),
                  ],
                )
              : null,
          color: message.isUser ? null : CosmicTheme.cardDark,
          border: message.isUser
              ? null
              : Border.all(
                  color: CosmicTheme.nebulaPurple.withOpacity(0.2),
                ),
        ),
        child: Text(
          message.text,
          style: GoogleFonts.poppins(
            color: CosmicTheme.textPrimary,
            fontSize: 14,
            height: 1.5,
          ),
        ),
      ),
    );
  }
}

class _TypingIndicator extends StatefulWidget {
  @override
  State<_TypingIndicator> createState() => _TypingIndicatorState();
}

class _TypingIndicatorState extends State<_TypingIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: CosmicTheme.cardDark,
          border: Border.all(
            color: CosmicTheme.nebulaPurple.withOpacity(0.2),
          ),
        ),
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(3, (i) {
                final delay = i * 0.3;
                final value = ((_controller.value + delay) % 1.0);
                final opacity = (value < 0.5
                        ? value * 2
                        : 2 - value * 2)
                    .clamp(0.3, 1.0);
                return Container(
                  width: 8,
                  height: 8,
                  margin: const EdgeInsets.symmetric(horizontal: 2),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: CosmicTheme.nebulaPurple.withOpacity(opacity),
                  ),
                );
              }),
            );
          },
        ),
      ),
    );
  }
}

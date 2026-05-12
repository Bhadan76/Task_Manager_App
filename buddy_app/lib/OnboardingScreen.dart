import 'package:flutter/material.dart';
import 'OnboardingItem_widget/OnboardingItem_widget.dart';
import 'auth/welcome_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  static const Color _bgColor = Color(0xFFF4EFEA);
  static const Color _accentColor = Color(0xFFB7A9F9);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onNext() {
    if (_currentPage < 2) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOut,
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const WelcomeScreen()),
      );
    }
  }

  void _onSkip() {
    _controller.animateToPage(
      2,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bgColor,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 12),

            // ─── Robot mascot header ───────────────────────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/ChatGPT_Image_Apr_30__2026__10_00_26_PM-removebg-preview.png",
                    height: 120,
                    errorBuilder: (_, __, ___) => const SizedBox(height: 80),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 8),

            // ─── Page content ─────────────────────────────────────────────
            Expanded(
              child: PageView(
                controller: _controller,
                onPageChanged: (page) => setState(() => _currentPage = page),
                children: [
                  // PAGE 1
                  OnboardingItem(
                    image: '',
                    customContent: _buildPage1Content(),
                    title: '',
                    description: '',

                  ),

                  // PAGE 2
                  OnboardingItem(
                    image: 'assets/onboarding2.png',
                    title: 'How It Works',
                    description:
                        "Record or upload your lectures, and MyStudyBuddy will turn them into organized notes you can highlight, review, and study from — instantly.",
                  ),

                  // PAGE 3
                  OnboardingItem(
                    image: 'assets/onboarding3.png',
                    title: "Why You'll Love It",
                    description:
                        "Study solo or play with friends — test your knowledge through games, track your streaks, and make learning fun again.",
                  ),
                ],
              ),
            ),

            // ─── Dot indicators ───────────────────────────────────────────
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                3,
                (i) => _buildDot(i == _currentPage),
              ),
            ),

            const SizedBox(height: 24),

            // ─── Skip + Next/Continue buttons ─────────────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28),
              child: Column(
                children: [
                  // Skip row (hidden on last page)
                  if (_currentPage < 2)
                    GestureDetector(
                      onTap: _onSkip,
                      child: Text(
                        "Skip",
                        style: TextStyle(
                          color: Colors.grey.shade500,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),

                  const SizedBox(height: 12),

                  // Main CTA button
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      onPressed: _onNext,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _accentColor,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: Text(
                        _currentPage == 2 ? "Continue" : "Next",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.3,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  // ─── Page 1: floating feature icons ──────────────────────────────────────
  Widget _buildPage1Content() {
    return Column(
      children: [
        // Description text
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            "Turn your notes, lectures, or videos into flashcards,\nquizzes, study guides and fun study games.",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15,
              height: 1.6,
              color: Colors.grey.shade600,
            ),
          ),
        ),

        const SizedBox(height: 32),

        // Floating icons grid (2x2 with center offset like Figma)
        SizedBox(
          height: 350,
          width: 350,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Top-center: Note
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Center(child: _featureIcon(Icons.sticky_note_2_outlined, "Note", const Color(0xFFFFF3C7))),
              ),
              // Mid-left: Flashcard
              Positioned(
                top: 88,
                left: 15,
                child: _featureIcon(Icons.layers_outlined, "Flashcard", const Color(0xFFFFE0EC)),
              ),
              // Mid-right: Games
              Positioned(
                top: 88,
                right: 15,

                child: _featureIcon(Icons.sports_esports_outlined, "Games", const Color(0xFFD6F0FF)),
              ),
              // Bottom-center: Quiz
              Positioned(
                bottom: 53,
                left: 0,
                right: 0,
                child: Center(child: _featureIcon(Icons.quiz_outlined, "Quiz", const Color(0xFFE8DCFF))),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _featureIcon(IconData icon, String label, Color bgColor) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.06),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Icon(icon, size: 32, color: const Color(0xFF5A5A7A)),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Color(0xFF5A5A7A),
          ),
        ),
      ],
    );
  }

  // ─── Animated dot ─────────────────────────────────────────────────────────
  Widget _buildDot(bool active) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      width: active ? 24 : 8,
      height: 8,
      decoration: BoxDecoration(
        color: active ? _accentColor : Colors.grey.shade300,
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}

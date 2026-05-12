import 'package:flutter/material.dart';

import 'FlashCard_Screen/flashcard_screen.dart';
import 'Matching_Screen/matching_screen.dart';
import 'Quiz_Screen/quiz_screen.dart';
import 'Study_guide Screen/study_guide_screen.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDF8F3), // Off-white background
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Home',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            _buildHomeCard(
              title: 'Flashcard Generation',
              iconData: Icons.style,
              iconBgColor: const Color(0xFFFFEBF0),
              iconColor: const Color(0xFFFF7B93),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const FlashcardGenerationScreen(),
                  ),
                );
              },
            ),
            const SizedBox(height: 16),
            _buildHomeCard(
              title: 'Quiz Race',
              iconData: Icons.sports_esports,
              iconBgColor: const Color(0xFFEBE5FF),
              iconColor: const Color(0xFF8B6BFF),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const QuizRaceScreen(),
                  ),
                );
              },
            ),
            const SizedBox(height: 16),
            _buildHomeCard(
              title: 'Matching Sprint',
              iconData: Icons.grid_view,
              iconBgColor: const Color(0xFFE5F4FF),
              iconColor: const Color(0xFF4DB0FF),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MatchingSprintScreen(),
                  ),
                );
              },
            ),
            const SizedBox(height: 16),
            _buildHomeCard(
              title: 'Study Guide Builder',
              iconData: Icons.menu_book,
              iconBgColor: const Color(0xFFFFE5E5),
              iconColor: const Color(0xFFFF6B6B),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const StudyGuideBuilderScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHomeCard({
    required String title,
    required IconData iconData,
    required Color iconBgColor,
    required Color iconColor,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.02),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: iconBgColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(iconData, color: iconColor, size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF2D2D2D), // Dark text color
                ),
              ),
            ),
            const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}

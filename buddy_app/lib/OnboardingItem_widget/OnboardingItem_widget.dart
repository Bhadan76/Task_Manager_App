import 'package:flutter/material.dart';

class OnboardingItem extends StatelessWidget {
  final String image;
  final String  title;
  final String description;
  final Widget ? customContent; // For page 1 special floating icons

  const OnboardingItem({
    super.key,
    required this.image,
    required this.title,
    required this.description,
    this.customContent,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 10),

          // Main illustration
          if (customContent != null)
            customContent!
          else
            Image.asset(
              image,
              height: 220,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 220,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Icon(Icons.image, size: 60, color: Colors.grey),
                );
              },
            ),

          const SizedBox(height: 28),

          // Title
          if (title.isNotEmpty)
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2D2D2D),
                letterSpacing: 0.2,
              ),
            ),

          if (title.isNotEmpty) const SizedBox(height: 14),

          // Description
          Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15,
              height: 1.6,
              color: Colors.grey.shade600,
            ),
          ),

          const Spacer(),
        ],
      ),
    );
  }
}

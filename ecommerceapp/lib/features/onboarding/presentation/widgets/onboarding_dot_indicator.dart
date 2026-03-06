import 'package:flutter/material.dart';

/// Horizontal row of dots indicating the current onboarding page.
class OnboardingDotIndicator extends StatelessWidget {
  const OnboardingDotIndicator({
    super.key,
    required this.pageCount,
    required this.currentIndex,
    required this.colorScheme,
  });

  final int pageCount;
  final int currentIndex;
  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        pageCount,
        (index) {
          final isActive = index == currentIndex;
          return AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeOutCubic,
            margin: const EdgeInsets.symmetric(horizontal: 4),
            width: isActive ? 24 : 8,
            height: 8,
            decoration: BoxDecoration(
              color: isActive
                  ? colorScheme.primary
                  : colorScheme.onSurface.withOpacity(0.3),
              borderRadius: BorderRadius.circular(4),
            ),
          );
        },
      ),
    );
  }
}

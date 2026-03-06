import 'package:flutter/material.dart';

/// Small dot indicator for auth flow (e.g. Ready Start / Hello card).
class AuthPageDot extends StatelessWidget {
  const AuthPageDot({super.key, required this.isActive});

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      width: 8,
      height: 8,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isActive
            ? const Color(0xFF0054F6)
            : const Color(0xFFD8DEEA),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/onboarding_provider.dart';
import '../widgets/onboarding_content.dart';
import '../widgets/onboarding_dot_indicator.dart';

part 'onboarding_page_state.dart';

/// Onboarding / walkthrough flow with 3 screens.
///
/// Uses [PageView.builder] for horizontal swiping, a dot indicator,
/// Skip (top right), and Next / Get Started (bottom, StadiumBorder).
/// Theme-aware for light/dark mode.
class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => OnboardingPageState();
}

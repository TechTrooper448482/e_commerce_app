import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../features/onboarding/presentation/pages/onboarding_page.dart';
import '../../features/onboarding/presentation/providers/onboarding_provider.dart';
import 'root_navigator.dart';

/// Shows onboarding until the user completes it (Skip or Get Started),
/// then shows the main app (auth flow or shell).
class OnboardingGate extends StatelessWidget {
  const OnboardingGate({super.key});

  @override
  Widget build(BuildContext context) {
    final onboarding = context.watch<OnboardingProvider>();
    if (!onboarding.hasCompletedOnboarding) {
      return const OnboardingPage();
    }
    return const RootNavigator();
  }
}

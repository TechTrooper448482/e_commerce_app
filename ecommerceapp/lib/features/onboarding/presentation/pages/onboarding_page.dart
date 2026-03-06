import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/models/onboarding_model.dart';
import '../providers/onboarding_provider.dart';

/// Onboarding / walkthrough flow with 3 screens.
///
/// Uses [PageView.builder] for horizontal swiping, a dot indicator,
/// Skip (top right), and Next / Get Started (bottom, StadiumBorder).
/// Theme-aware for light/dark mode.
class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Skip button – top right
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                child: TextButton(
                  onPressed: () {
                    context.read<OnboardingProvider>().skip();
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: colorScheme.onSurface.withOpacity(0.7),
                  ),
                  child: const Text('Skip'),
                ),
              ),
            ),
            // PageView content
            Expanded(
              child: Consumer<OnboardingProvider>(
                builder: (context, provider, _) {
                  return PageView.builder(
                    controller: _pageController,
                    itemCount: provider.pageCount,
                    onPageChanged: provider.setPageIndex,
                    itemBuilder: (context, index) {
                      final page = provider.pages[index];
                      return _OnboardingContent(
                        model: page,
                        colorScheme: colorScheme,
                        textTheme: theme.textTheme,
                      );
                    },
                  );
                },
              ),
            ),
            // Dot indicator + Next / Get Started button
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Consumer<OnboardingProvider>(
                    builder: (context, provider, _) {
                      return _DotIndicator(
                        pageCount: provider.pageCount,
                        currentIndex: provider.currentPageIndex,
                        colorScheme: colorScheme,
                      );
                    },
                  ),
                  const SizedBox(height: 24),
                  Consumer<OnboardingProvider>(
                    builder: (context, provider, _) {
                      final isLast = provider.isLastPage;
                      return SizedBox(
                        width: double.infinity,
                        child: FilledButton(
                          onPressed: () {
                            if (isLast) {
                              provider.completeOnboarding();
                            } else {
                              provider.nextPage();
                              _pageController.nextPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeOutCubic,
                              );
                            }
                          },
                          style: FilledButton.styleFrom(
                            shape: const StadiumBorder(),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            textStyle: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          child: Text(isLast ? 'Get Started' : 'Next'),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Single onboarding screen: centered image, title, and description.
class _OnboardingContent extends StatelessWidget {
  const _OnboardingContent({
    required this.model,
    required this.colorScheme,
    required this.textTheme,
  });

  final OnboardingModel model;
  final ColorScheme colorScheme;
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Image – large placeholder / network image
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: AspectRatio(
              aspectRatio: 4 / 3,
              child: Image.network(
                model.imagePath,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  color: colorScheme.surfaceContainerHighest,
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.image_not_supported_outlined,
                    size: 48,
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 40),
          Text(
            model.title,
            textAlign: TextAlign.center,
            style: textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w700,
              color: colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            model.description,
            textAlign: TextAlign.center,
            style: textTheme.bodyLarge?.copyWith(
              color: colorScheme.onSurface.withOpacity(0.8),
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

/// Horizontal row of dots indicating the current page.
class _DotIndicator extends StatelessWidget {
  const _DotIndicator({
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

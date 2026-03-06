part of 'onboarding_page.dart';

class OnboardingPageState extends State<OnboardingPage> {
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
            Expanded(
              child: Consumer<OnboardingProvider>(
                builder: (context, provider, _) {
                  return PageView.builder(
                    controller: _pageController,
                    itemCount: provider.pageCount,
                    onPageChanged: provider.setPageIndex,
                    itemBuilder: (context, index) {
                      final page = provider.pages[index];
                      return OnboardingContent(
                        model: page,
                        colorScheme: colorScheme,
                        textTheme: theme.textTheme,
                      );
                    },
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Consumer<OnboardingProvider>(
                    builder: (context, provider, _) {
                      return OnboardingDotIndicator(
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

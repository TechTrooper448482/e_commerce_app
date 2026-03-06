import 'package:flutter/foundation.dart';

import '../../data/models/onboarding_model.dart';

/// Holds onboarding screens and completion state.
///
/// Use [currentPageIndex] for the PageView and dot indicator.
/// Call [completeOnboarding] when the user taps Skip or Get Started.
/// Persist [hasCompletedOnboarding] (e.g. via SharedPreferences) if you need
/// to show onboarding only on first launch.
class OnboardingProvider extends ChangeNotifier {
  OnboardingProvider({
    List<OnboardingModel>? pages,
    bool initialCompleted = false,
  })  : _pages = pages ?? _defaultPages,
        _hasCompletedOnboarding = initialCompleted;

  static final List<OnboardingModel> _defaultPages = [
    const OnboardingModel(
      title: 'Discover Products',
      description:
          'Browse a curated collection and find what you love with ease.',
      imagePath:
          'https://images.unsplash.com/photo-1607082348824-0a96f2a4b9da?w=800',
    ),
    const OnboardingModel(
      title: 'Secure Checkout',
      description:
          'Pay safely and track your orders from cart to delivery.',
      imagePath:
          'https://images.unsplash.com/photo-1556742049-0cfed4f6a45d?w=800',
    ),
    const OnboardingModel(
      title: 'Enjoy Shopping',
      description:
          'Get started and enjoy a seamless shopping experience.',
      imagePath:
          'https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=800',
    ),
  ];

  final List<OnboardingModel> _pages;
  int _currentPageIndex = 0;
  bool _hasCompletedOnboarding;

  /// List of onboarding screens (title, description, image path).
  List<OnboardingModel> get pages => List.unmodifiable(_pages);

  /// Total number of onboarding screens.
  int get pageCount => _pages.length;

  /// Current page index (0-based). Use with PageView and dot indicator.
  int get currentPageIndex => _currentPageIndex;

  /// Whether the user has finished onboarding (Skip or Get Started).
  bool get hasCompletedOnboarding => _hasCompletedOnboarding;

  /// Whether the current page is the last one.
  bool get isLastPage =>
      _pages.isNotEmpty && _currentPageIndex == _pages.length - 1;

  /// Updates the current page index (e.g. when user swipes).
  void setPageIndex(int index) {
    if (index == _currentPageIndex) return;
    if (index < 0 || index >= _pages.length) return;
    _currentPageIndex = index;
    notifyListeners();
  }

  /// Moves to the next page. Does nothing if already on the last page.
  void nextPage() {
    if (_currentPageIndex < _pages.length - 1) {
      _currentPageIndex++;
      notifyListeners();
    }
  }

  /// Marks onboarding as completed and notifies listeners.
  /// Call when the user taps Skip or Get Started.
  void completeOnboarding() {
    if (_hasCompletedOnboarding) return;
    _hasCompletedOnboarding = true;
    notifyListeners();
  }

  /// Skips the rest of onboarding (same as completing).
  void skip() => completeOnboarding();
}

/// Model for a single onboarding / walkthrough screen.
///
/// Holds the [title], [description], and [imagePath] (URL or asset path)
/// used to render each page in the onboarding flow.
class OnboardingModel {
  const OnboardingModel({
    required this.title,
    required this.description,
    required this.imagePath,
  });

  /// Main heading shown on the screen.
  final String title;

  /// Supporting text shown below the title.
  final String description;

  /// Image URL (e.g. Unsplash) or asset path for the screen illustration.
  final String imagePath;
}

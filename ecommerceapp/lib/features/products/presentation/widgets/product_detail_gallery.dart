import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

/// Image gallery with PageView, pinch-to-zoom via [InteractiveViewer], and dot indicator.
class ProductDetailGallery extends StatelessWidget {
  const ProductDetailGallery({
    super.key,
    required this.images,
    required this.pageController,
    required this.currentPage,
    this.onPageChanged,
  });

  final List<String> images;
  final PageController pageController;
  final int currentPage;
  final ValueChanged<int>? onPageChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    if (images.isEmpty) {
      return ColoredBox(
        color: theme.colorScheme.surfaceContainerHighest,
        child: Center(
          child: Icon(
            Icons.image_not_supported_outlined,
            size: 48,
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
      );
    }

    return Stack(
      fit: StackFit.expand,
      children: [
        PageView.builder(
          controller: pageController,
          onPageChanged: onPageChanged,
          itemCount: images.length,
          itemBuilder: (context, index) {
            return InteractiveViewer(
              minScale: 0.5,
              maxScale: 4.0,
              child: Image.network(
                images[index],
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => ColoredBox(
                  color: theme.colorScheme.surfaceContainerHighest,
                  child: Icon(
                    Icons.broken_image_outlined,
                    size: 48,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
            );
          },
        ),
        // Gradient overlay for indicator readability
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: Container(
            height: 80,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  theme.colorScheme.scrim.withValues(alpha: 0.4),
                ],
              ),
            ),
          ),
        ),
        if (images.length > 1)
          Positioned(
            left: 0,
            right: 0,
            bottom: 16,
            child: Center(
              child: SmoothPageIndicator(
                controller: pageController,
                count: images.length,
                effect: ExpandingDotsEffect(
                  dotHeight: 8,
                  dotWidth: 8,
                  expansionFactor: 3,
                  spacing: 6,
                  dotColor: theme.colorScheme.onSurface.withValues(alpha: 0.3),
                  activeDotColor: theme.colorScheme.primary,
                ),
              ),
            ),
          ),
      ],
    );
  }
}

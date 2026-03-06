import 'product_review_entity.dart';

class ProductEntity {
  const ProductEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrls,
    required this.categoryId,
    this.isFeatured = false,
    this.originalPrice,
    this.stockCount,
    this.urgencyTag,
    this.colorOptions,
    this.sizeOptions,
    this.reviews,
    this.averageRating,
    this.reviewCount,
  });

  final String id;
  final String name;
  final String description;
  final double price;
  final List<String> imageUrls;
  final String categoryId;
  final bool isFeatured;

  /// Optional: was price before discount (shown strikethrough).
  final double? originalPrice;

  /// Optional: for "Only X left" urgency.
  final int? stockCount;

  /// Optional: 'low_stock' | 'best_seller' or custom label.
  final String? urgencyTag;

  /// Optional: e.g. ['Black', 'White', 'Red'] for color swatches.
  final List<String>? colorOptions;

  /// Optional: e.g. ['S', 'M', 'L', 'XL'] for size chips.
  final List<String>? sizeOptions;

  /// Optional: list of reviews for social proof.
  final List<ProductReviewEntity>? reviews;

  /// Optional: average rating 0-5 (can be derived from reviews).
  final double? averageRating;

  /// Optional: total review count.
  final int? reviewCount;
}


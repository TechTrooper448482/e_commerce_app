/// Single product review for social proof on the detail page.
class ProductReviewEntity {
  const ProductReviewEntity({
    required this.id,
    required this.authorName,
    required this.rating,
    required this.body,
    this.avatarUrl,
    this.isVerifiedPurchase = false,
  });

  final String id;
  final String authorName;
  final int rating; // 1-5
  final String body;
  final String? avatarUrl;
  final bool isVerifiedPurchase;
}

import 'package:flutter/material.dart';

import '../../domain/entities/product_entity.dart';
import '../../domain/entities/product_review_entity.dart';

/// Rating summary and top reviews list with avatars and Verified Purchase badge.
class ProductDetailReviews extends StatelessWidget {
  const ProductDetailReviews({
    super.key,
    required this.product,
  });

  final ProductEntity product;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final reviews = product.reviews ?? [];
    final avgRating = product.averageRating ?? 0.0;
    final count = product.reviewCount ?? 0;

    if (count == 0 && reviews.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            ...List.generate(5, (i) {
              final star = i + 1;
              final filled = avgRating >= star;
              return Icon(
                filled ? Icons.star : Icons.star_border,
                size: 22,
                color: Colors.amber,
              );
            }),
            const SizedBox(width: 8),
            Text(
              avgRating.toStringAsFixed(1),
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(width: 4),
            Text(
              '($count reviews)',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
        if (reviews.isNotEmpty) ...[
          const SizedBox(height: 16),
          Text(
            'Top Reviews',
            style: theme.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          ...reviews.take(5).map((r) => _ReviewTile(review: r)),
        ],
      ],
    );
  }
}

class _ReviewTile extends StatelessWidget {
  const _ReviewTile({required this.review});

  final ProductReviewEntity review;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: theme.colorScheme.primaryContainer,
            backgroundImage: review.avatarUrl != null && review.avatarUrl!.isNotEmpty
                ? NetworkImage(review.avatarUrl!)
                : null,
            child: review.avatarUrl == null || review.avatarUrl!.isEmpty
                ? Text(
                    review.authorName.isNotEmpty
                        ? review.authorName[0].toUpperCase()
                        : '?',
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: theme.colorScheme.onPrimaryContainer,
                    ),
                  )
                : null,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      review.authorName,
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    if (review.isVerifiedPurchase) ...[
                      const SizedBox(width: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.primaryContainer
                              .withValues(alpha: 0.6),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          'Verified Purchase',
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: theme.colorScheme.onPrimaryContainer,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: List.generate(
                    5,
                    (i) => Icon(
                      i < review.rating ? Icons.star : Icons.star_border,
                      size: 16,
                      color: Colors.amber,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  review.body,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

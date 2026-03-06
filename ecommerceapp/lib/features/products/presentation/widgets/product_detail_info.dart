import 'package:flutter/material.dart';

import '../../domain/entities/product_entity.dart';

/// Title, price (with optional original strikethrough), and urgency tag.
class ProductDetailInfo extends StatelessWidget {
  const ProductDetailInfo({
    super.key,
    required this.product,
  });

  final ProductEntity product;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          product.name,
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text(
              '\$${product.price.toStringAsFixed(2)}',
              style: theme.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.w800,
                color: theme.colorScheme.primary,
              ),
            ),
            if (product.originalPrice != null &&
                product.originalPrice! > product.price) ...[
              const SizedBox(width: 12),
              Text(
                '\$${product.originalPrice!.toStringAsFixed(2)}',
                style: theme.textTheme.titleMedium?.copyWith(
                  decoration: TextDecoration.lineThrough,
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ],
        ),
        if (_urgencyLabel != null) ...[
          const SizedBox(height: 12),
          _UrgencyTag(label: _urgencyLabel!),
        ],
      ],
    );
  }

  String? get _urgencyLabel {
    if (product.stockCount != null && product.stockCount! <= 5 && product.stockCount! > 0) {
      return 'Only ${product.stockCount} left in stock!';
    }
    if (product.urgencyTag == 'best_seller') {
      return 'Best Seller';
    }
    if (product.urgencyTag == 'low_stock' && product.stockCount != null) {
      return 'Only ${product.stockCount} left in stock!';
    }
    return null;
  }
}

class _UrgencyTag extends StatelessWidget {
  const _UrgencyTag({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: theme.colorScheme.errorContainer.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(
          color: theme.colorScheme.error.withValues(alpha: 0.5),
        ),
      ),
      child: Text(
        label,
        style: theme.textTheme.labelMedium?.copyWith(
          fontWeight: FontWeight.w600,
          color: theme.colorScheme.onErrorContainer,
        ),
      ),
    );
  }
}

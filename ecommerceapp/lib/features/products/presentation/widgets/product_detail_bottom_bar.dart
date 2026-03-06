import 'package:flutter/material.dart';

import '../../../../core/widgets/app_button.dart';
import '../../domain/entities/product_entity.dart';

/// Sticky bottom bar: Favorite (heart) + Add to Cart + Buy Now. Min tap 48x48.
class ProductDetailBottomBar extends StatelessWidget {
  const ProductDetailBottomBar({
    super.key,
    required this.product,
    required this.quantity,
    required this.isFavorite,
    required this.onToggleFavorite,
    required this.onAddToCart,
    required this.onBuyNow,
  });

  final ProductEntity product;
  final int quantity;
  final bool isFavorite;
  final VoidCallback onToggleFavorite;
  final VoidCallback onAddToCart;
  final VoidCallback onBuyNow;

  static const double _minTapTarget = 48;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.shadow.withValues(alpha: 0.08),
            blurRadius: 16,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: _minTapTarget,
              height: _minTapTarget,
              child: IconButton(
                onPressed: onToggleFavorite,
                icon: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: isFavorite ? Colors.red : theme.colorScheme.onSurface,
                  size: 26,
                ),
                style: IconButton.styleFrom(
                  backgroundColor: theme.colorScheme.surfaceContainerHighest,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: AppButton(
                isPrimary: false,
                label: 'Add to Cart',
                onPressed: onAddToCart,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: AppButton(
                label: 'Buy Now',
                onPressed: onBuyNow,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

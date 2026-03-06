import 'package:flutter/material.dart';

import '../../domain/entities/product_entity.dart';

/// Description with ExpansionTile (accordion) for long text.
class ProductDetailDescription extends StatelessWidget {
  const ProductDetailDescription({
    super.key,
    required this.product,
  });

  final ProductEntity product;

  static const int _shortLength = 120;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final description = product.description;
    final isLong = description.length > _shortLength;

    return ExpansionTile(
      tilePadding: EdgeInsets.zero,
      childrenPadding: const EdgeInsets.only(top: 8),
      title: Text(
        'Description',
        style: theme.textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: isLong
          ? Padding(
              padding: const EdgeInsets.only(top: 6),
              child: Text(
                '${description.substring(0, _shortLength).trim()}...',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            )
          : Padding(
              padding: const EdgeInsets.only(top: 6),
              child: Text(
                description,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ),
      children: isLong
          ? [
              Text(
                description,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                  height: 1.5,
                ),
              ),
            ]
          : [],
    );
  }
}

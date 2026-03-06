import 'package:flutter/material.dart';

import '../../../products/domain/entities/product_entity.dart';
import '../../../products/presentation/pages/product_detail_page.dart';
import 'discovery_product_card.dart';

/// Two-column grid of trending products for discovery home.
class DiscoveryTrendingGrid extends StatelessWidget {
  const DiscoveryTrendingGrid({super.key, required this.products});

  final List<ProductEntity> products;

  @override
  Widget build(BuildContext context) {
    return SliverLayoutBuilder(
      builder: (context, constraints) {
        const crossAxisCount = 2;
        const spacing = 12.0;
        final width = (constraints.crossAxisExtent - spacing) / crossAxisCount;
        final aspectRatio = width / (width * 1.35);

        return SliverGrid(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            mainAxisSpacing: spacing,
            crossAxisSpacing: spacing,
            childAspectRatio: aspectRatio,
          ),
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              final product = products[index];
              return DiscoveryProductCard(
                product: product,
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => ProductDetailPage(productId: product.id),
                    ),
                  );
                },
              );
            },
            childCount: products.length,
          ),
        );
      },
    );
  }
}

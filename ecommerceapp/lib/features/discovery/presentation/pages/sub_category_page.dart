import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../products/domain/entities/product_entity.dart';
import '../../../products/presentation/pages/product_detail_page.dart';
import '../../data/services/mock_product_service.dart';
import '../providers/favorites_provider.dart';

/// Sub-category view: filtered product grid for a given category.
class SubCategoryPage extends StatefulWidget {
  const SubCategoryPage({
    super.key,
    required this.categoryId,
    required this.categoryName,
  });

  final String categoryId;
  final String categoryName;

  @override
  State<SubCategoryPage> createState() => _SubCategoryPageState();
}

class _SubCategoryPageState extends State<SubCategoryPage> {
  List<ProductEntity> _products = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final service = context.read<MockProductService>();
    final list = await service.getProductsByCategory(widget.categoryId);
    if (!mounted) return;
    setState(() {
      _products = list;
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.categoryName),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _products.isEmpty
              ? Center(
                  child: Text(
                    'No products in this category',
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                )
              : LayoutBuilder(
                  builder: (context, constraints) {
                    const crossAxisCount = 2;
                    const spacing = 12.0;
                    final width =
                        (constraints.maxWidth - spacing) / crossAxisCount;
                    final aspectRatio = width / (width * 1.35);

                    return GridView.builder(
                      padding: const EdgeInsets.all(20),
                      gridDelegate:
                          SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount,
                        mainAxisSpacing: spacing,
                        crossAxisSpacing: spacing,
                        childAspectRatio: aspectRatio,
                      ),
                      itemCount: _products.length,
                      itemBuilder: (context, index) {
                        final product = _products[index];
                        return _SubCategoryProductCard(
                          product: product,
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => ProductDetailPage(
                                  productId: product.id,
                                ),
                              ),
                            );
                          },
                        );
                      },
                    );
                  },
                ),
    );
  }
}

class _SubCategoryProductCard extends StatelessWidget {
  const _SubCategoryProductCard({
    required this.product,
    required this.onTap,
  });

  final ProductEntity product;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final favorites = context.watch<FavoritesProvider>();

    return Material(
      color: theme.colorScheme.surface,
      borderRadius: BorderRadius.circular(14),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    product.imageUrls.isNotEmpty
                        ? product.imageUrls.first
                        : '',
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      color: theme.colorScheme.surfaceContainerHighest,
                      child: Icon(
                        Icons.image_not_supported_outlined,
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Material(
                      color: Colors.white.withOpacity(0.9),
                      shape: const CircleBorder(),
                      child: InkWell(
                        onTap: () => favorites.toggle(product.id),
                        customBorder: const CircleBorder(),
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Icon(
                            favorites.isFavorite(product.id)
                                ? Icons.favorite
                                : Icons.favorite_border,
                            size: 20,
                            color: favorites.isFavorite(product.id)
                                ? Colors.red
                                : theme.colorScheme.onSurface,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 8, 10, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    product.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '\$${product.price.toStringAsFixed(2)}',
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

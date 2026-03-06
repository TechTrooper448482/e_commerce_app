import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

import '../../../../core/widgets/app_text_field.dart';
import '../../domain/entities/category_entity.dart';
import '../providers/product_provider.dart';
import '../widgets/category_chip.dart';
import '../widgets/product_card.dart';
import 'product_detail_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      if (!mounted) {
        return;
      }
      context.read<ProductProvider>().loadHome();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ProductProvider>();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top area with title and hero banner
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Flash Sale',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w700,
                          fontSize: 20,
                        ),
                  ),
                  const SizedBox(height: 16),
                  _FlashSaleHero(),
                ],
              ),
            ),
            const SizedBox(height: 12),
            // Slider category bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: _buildCategories(provider),
            ),
            const SizedBox(height: 8),
            // Products area styled like grid of sale cards
            Expanded(
              child: provider.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : _buildFlashSaleProducts(provider),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategories(ProductProvider provider) {
    if (provider.categories.isEmpty) {
      return const SizedBox.shrink();
    }

    final selected = provider.selectedCategory;

    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: provider.categories.length + 1,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          if (index == 0) {
            final isAllSelected = selected == null;
            final theme = Theme.of(context);
            return ChoiceChip(
              label: const Text('All'),
              selected: isAllSelected,
              onSelected: (_) => provider.selectCategory(null),
              backgroundColor: Colors.white,
              selectedColor: theme.colorScheme.primary,
              labelStyle: theme.textTheme.bodyMedium?.copyWith(
                fontWeight:
                    isAllSelected ? FontWeight.w600 : FontWeight.w400,
                color: isAllSelected ? Colors.white : Colors.black,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
                side: BorderSide(
                  color: isAllSelected
                      ? Colors.transparent
                      : theme.colorScheme.onSurface.withOpacity(0.06),
                ),
              ),
            );
          }
          final CategoryEntity category = provider.categories[index - 1];
          return CategoryChip(
            category: category,
            isSelected: selected?.id == category.id,
            onSelected: () => provider.selectCategory(category),
          );
        },
      ),
    );
  }

  Widget _buildProductsGrid(ProductProvider provider) {
    if (provider.visibleProducts.isEmpty) {
      return const Center(child: Text('No products found.'));
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        int crossAxisCount = 2;
        if (width > 900) {
          crossAxisCount = 4;
        } else if (width > 600) {
          crossAxisCount = 3;
        }

        return MasonryGridView.count(
          crossAxisCount: crossAxisCount,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          itemCount: provider.visibleProducts.length,
          itemBuilder: (context, index) {
            final product = provider.visibleProducts[index];
            return ProductCard(
              product: product,
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (_) => ProductDetailView(productId: product.id),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }

  Widget _buildFlashSaleProducts(ProductProvider provider) {
    final products = provider.visibleProducts;
    if (products.isEmpty) {
      return const Center(child: Text('No products available.'));
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GridView.builder(
        padding: const EdgeInsets.only(top: 8, bottom: 24),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 12,
          childAspectRatio: 0.68,
        ),
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (_) => ProductDetailView(productId: product.id),
                ),
              );
            },
            child: _FlashSaleProductCard(product: product),
          );
        },
      ),
    );
  }
}

class _FlashSaleHero extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 18,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          // Colored background with abstract shapes.
          Positioned.fill(
            child: Container(
              color: const Color(0xFFFECF4F),
            ),
          ),
          Positioned(
            top: -60,
            right: -40,
            child: Container(
              width: 190,
              height: 190,
              decoration: const BoxDecoration(
                color: Color(0xFF0054F6),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            bottom: -40,
            left: -40,
            child: Container(
              width: 160,
              height: 160,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
            ),
          ),
          // Content
          Row(
            children: [
              Expanded(
                flex: 6,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 18, 12, 18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Big Sale',
                        style:
                            Theme.of(context).textTheme.titleLarge?.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black87,
                                  fontSize: 22,
                                ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Up to 50%',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                      ),
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(999),
                        ),
                        child: Text(
                          'Happening Now',
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF0054F6),
                              ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Expanded(
                flex: 5,
                child: SizedBox(), // Placeholder where banner image would sit.
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _FlashSaleProductCard extends StatelessWidget {
  const _FlashSaleProductCard({required this.product});

  final dynamic product;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 120,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.network(
                  product.imageUrls.first,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  top: 8,
                  left: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFF4D67),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const Text(
                      '-20%',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
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
                    fontSize: 12,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Text(
                      '\$${product.price.toStringAsFixed(2)}',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                        fontSize: 13,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      '\$${(product.price * 1.25).toStringAsFixed(2)}',
                      style: theme.textTheme.bodySmall?.copyWith(
                        decoration: TextDecoration.lineThrough,
                        color: Colors.black38,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


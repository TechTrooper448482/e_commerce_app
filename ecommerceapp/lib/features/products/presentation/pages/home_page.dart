import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

import '../../../../core/widgets/app_text_field.dart';
import '../../domain/entities/category_entity.dart';
import '../providers/product_provider.dart';
import '../widgets/category_chip.dart';
import '../widgets/product_card.dart';
import 'product_detail_page.dart';

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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Discover',
                style: Theme.of(context).textTheme.displayLarge,
              ),
              const SizedBox(height: 4),
              Text(
                'Elevate your everyday essentials.',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 24),
              AppTextField(
                controller: _searchController,
                label: 'Search products',
                keyboardType: TextInputType.text,
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  TextButton(
                    onPressed: () {
                      provider.search(_searchController.text);
                    },
                    child: const Text('Search'),
                  ),
                  const SizedBox(width: 8),
                  if (provider.searchQuery.isNotEmpty)
                    TextButton(
                      onPressed: () {
                        _searchController.clear();
                        provider.loadHome();
                      },
                      child: const Text('Clear'),
                    ),
                ],
              ),
              const SizedBox(height: 20),
              _buildCategories(provider),
              const SizedBox(height: 20),
              Expanded(
                child: provider.isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : _buildProductsGrid(provider),
              ),
            ],
          ),
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
            return ChoiceChip(
              label: const Text('All'),
              selected: selected == null,
              onSelected: (_) => provider.selectCategory(null),
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
                    builder: (_) => ProductDetailPage(productId: product.id),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}


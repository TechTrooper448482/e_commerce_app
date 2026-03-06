import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../products/domain/entities/category_entity.dart';
import '../../../products/domain/entities/product_entity.dart';
import '../../../products/presentation/pages/product_detail_page.dart';
import '../../data/services/mock_product_service.dart';
import '../providers/favorites_provider.dart';
import '../providers/home_provider.dart';
import 'category_list_page.dart';
import 'search_filter_page.dart';
import 'sub_category_page.dart';

/// Discovery Home: search bar, auto-scrolling banner, horizontal categories, trending grid.
class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<DiscoveryCategory> _discoveryCategories = [];
  List<ProductEntity> _trendingProducts = [];
  bool _loading = true;
  late PageController _bannerPageController;

  @override
  void initState() {
    super.initState();
    _bannerPageController = PageController();
    _load();
  }

  @override
  void dispose() {
    _bannerPageController.dispose();
    super.dispose();
  }

  Future<void> _load() async {
    final service = context.read<MockProductService>();
    final categories = await service.getDiscoveryCategories();
    final products = await service.getTrendingProducts();
    if (!mounted) return;
    setState(() {
      _discoveryCategories = categories;
      _trendingProducts = products;
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _SearchBar(onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const SearchFilterPage(),
                        ),
                      );
                    }),
                    const SizedBox(height: 20),
                    _BannerSection(controller: _bannerPageController),
                    const SizedBox(height: 24),
                    _CategoriesSection(
                      discoveryCategories: _discoveryCategories,
                      onSeeAll: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const CategoryListPage(),
                          ),
                        );
                      },
                      onCategoryTap: (category) {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => SubCategoryPage(
                              categoryId: category.id,
                              categoryName: category.name,
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Trending',
                          style: theme.textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                  ],
                ),
              ),
            ),
            if (_loading)
              const SliverFillRemaining(
                child: Center(child: CircularProgressIndicator()),
              )
            else
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                sliver: _TrendingGrid(products: _trendingProducts),
              ),
          ],
        ),
      ),
    );
  }
}

class _SearchBar extends StatelessWidget {
  const _SearchBar({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Material(
      color: theme.colorScheme.surfaceContainerHighest.withOpacity(0.5),
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            children: [
              Icon(
                Icons.search,
                size: 22,
                color: theme.colorScheme.onSurfaceVariant,
              ),
              const SizedBox(width: 12),
              Text(
                'Search products',
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BannerSection extends StatefulWidget {
  const _BannerSection({required this.controller});

  final PageController controller;

  @override
  State<_BannerSection> createState() => _BannerSectionState();
}

class _BannerSectionState extends State<_BannerSection> {
  @override
  void initState() {
    super.initState();
    final provider = context.read<HomeProvider>();
    provider.addListener(_syncPageFromProvider);
  }

  @override
  void dispose() {
    context.read<HomeProvider>().removeListener(_syncPageFromProvider);
    super.dispose();
  }

  void _syncPageFromProvider() {
    final provider = context.read<HomeProvider>();
    if (widget.controller.hasClients &&
        provider.currentBannerIndex != widget.controller.page?.round()) {
      widget.controller.animateToPage(
        provider.currentBannerIndex,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutCubic,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (context, provider, _) {
        final banners = provider.banners;
        if (banners.isEmpty) return const SizedBox.shrink();

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 160,
              child: PageView.builder(
                controller: widget.controller,
                itemCount: banners.length,
                onPageChanged: provider.setBannerIndex,
                itemBuilder: (context, index) {
              final banner = banners[index];
              return Padding(
                padding: const EdgeInsets.only(right: 12),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.network(
                        banner.imageUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Container(
                          color: Theme.of(context).colorScheme.surfaceContainerHighest,
                        ),
                      ),
                      if (banner.title != null)
                        Positioned(
                          left: 16,
                          bottom: 16,
                          right: 16,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                banner.title!,
                                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  shadows: [
                                    Shadow(
                                      color: Colors.black54,
                                      offset: const Offset(0, 1),
                                      blurRadius: 4,
                                    ),
                                  ],
                                ),
                              ),
                              if (banner.subtitle != null) ...[
                                const SizedBox(height: 4),
                                Text(
                                  banner.subtitle!,
                                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: Colors.white70,
                                    shadows: [
                                      const Shadow(
                                        color: Colors.black45,
                                        offset: Offset(0, 1),
                                        blurRadius: 2,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              );
            },
          ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                banners.length,
                (i) => AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  margin: const EdgeInsets.symmetric(horizontal: 3),
                  width: i == provider.currentBannerIndex ? 18 : 6,
                  height: 6,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    color: i == provider.currentBannerIndex
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).colorScheme.onSurface.withOpacity(0.3),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _CategoriesSection extends StatelessWidget {
  const _CategoriesSection({
    required this.discoveryCategories,
    required this.onSeeAll,
    required this.onCategoryTap,
  });

  final List<DiscoveryCategory> discoveryCategories;
  final VoidCallback onSeeAll;
  final void Function(CategoryEntity) onCategoryTap;

  static IconData _iconFor(String iconName) {
    switch (iconName) {
      case 'devices':
        return Icons.devices;
      case 'checkroom':
        return Icons.checkroom;
      case 'weekend':
        return Icons.weekend;
      case 'brush':
        return Icons.brush;
      default:
        return Icons.category;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Categories',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            TextButton(
              onPressed: onSeeAll,
              child: const Text('See all'),
            ),
          ],
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 88,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: discoveryCategories.length,
            itemBuilder: (context, index) {
              final dc = discoveryCategories[index];
              final cat = dc.entity;
              return Padding(
                padding: const EdgeInsets.only(right: 16),
                child: _CategoryChip(
                  label: cat.name,
                  icon: _iconFor(cat.icon),
                  onTap: () => onCategoryTap(cat),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _CategoryChip extends StatelessWidget {
  const _CategoryChip({
    required this.label,
    required this.icon,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: SizedBox(
          width: 72,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: theme.colorScheme.surfaceContainerHighest,
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, size: 26, color: theme.colorScheme.primary),
              ),
              const SizedBox(height: 8),
              Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: theme.textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TrendingGrid extends StatelessWidget {
  const _TrendingGrid({required this.products});

  final List<ProductEntity> products;

  @override
  Widget build(BuildContext context) {
    return SliverLayoutBuilder(
      builder: (context, constraints) {
        final crossAxisCount = 2;
        final spacing = 12.0;
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
              return _ProductCard(
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

class _ProductCard extends StatelessWidget {
  const _ProductCard({
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

import '../../../products/domain/entities/category_entity.dart';
import '../../../products/domain/entities/product_entity.dart';
import '../../../products/domain/repositories/product_repository.dart';

/// Banner slide for the home auto-scrolling promo.
class BannerItem {
  const BannerItem({
    required this.imageUrl,
    this.title,
    this.subtitle,
  });
  final String imageUrl;
  final String? title;
  final String? subtitle;
}

/// Category with optional image for discovery list.
class DiscoveryCategory {
  const DiscoveryCategory({
    required this.entity,
    required this.imageUrl,
  });
  final CategoryEntity entity;
  final String imageUrl;
}

/// Single source for discovery data. Swap with a real API implementation
/// (e.g. Dio + endpoints) without changing the UI layer.
class MockProductService {
  MockProductService({required ProductRepository productRepository})
      : _repo = productRepository;

  final ProductRepository _repo;

  static const List<BannerItem> _banners = [
    BannerItem(
      imageUrl: 'https://images.unsplash.com/photo-1607082348824-0a96f2a4b9da?w=800',
      title: 'New Arrivals',
      subtitle: 'Discover the latest trends',
    ),
    BannerItem(
      imageUrl: 'https://images.unsplash.com/photo-1556742049-0cfed4f6a45d?w=800',
      title: 'Up to 50% Off',
      subtitle: 'Limited time only',
    ),
    BannerItem(
      imageUrl: 'https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=800',
      title: 'Free Shipping',
      subtitle: 'On orders over \$50',
    ),
  ];

  static const Map<String, String> _categoryImageUrls = {
    'c1': 'https://images.unsplash.com/photo-1498049794561-7780e7231661?w=600',
    'c2': 'https://images.unsplash.com/photo-1441984904996-e0b6ba687e04?w=600',
    'c3': 'https://images.unsplash.com/photo-1586023492125-27b2c045efd7?w=600',
    'c4': 'https://images.unsplash.com/photo-1596462502278-27bfdc403348?w=600',
  };

  /// Banners for the home auto-scrolling promo.
  Future<List<BannerItem>> getBanners() async {
    await Future<void>.delayed(const Duration(milliseconds: 100));
    return List.from(_banners);
  }

  /// Categories with image URLs for the discovery category list.
  Future<List<DiscoveryCategory>> getDiscoveryCategories() async {
    final categories = await _repo.getCategories();
    return categories
        .map((e) => DiscoveryCategory(
              entity: e,
              imageUrl: _categoryImageUrls[e.id] ?? 'https://images.unsplash.com/photo-1441984904996-e0b6ba687e04?w=600',
            ))
        .toList();
  }

  /// All products for home trending / search (can be replaced with featured/trending API).
  Future<List<ProductEntity>> getTrendingProducts() async {
    final data = await _repo.getFeaturedProducts();
    return data;
  }

  /// Products by category (delegate to repository).
  Future<List<ProductEntity>> getProductsByCategory(String categoryId) async {
    return _repo.getProductsByCategory(categoryId);
  }

  /// Search (delegate to repository).
  Future<List<ProductEntity>> searchProducts(String query) async {
    if (query.trim().isEmpty) return _repo.getFeaturedProducts();
    return _repo.searchProducts(query.trim());
  }

  /// Single product by id.
  Future<ProductEntity> getProductById(String id) => _repo.getProductById(id);
}

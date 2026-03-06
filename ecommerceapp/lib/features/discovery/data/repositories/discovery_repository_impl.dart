import '../../../products/domain/entities/product_entity.dart';
import '../../../products/domain/repositories/product_repository.dart';
import '../../domain/entities/banner_entity.dart';
import '../../domain/entities/discovery_category_entity.dart';
import '../../domain/repositories/discovery_repository.dart';

/// Discovery data implementation. Delegates product/category data to
/// [ProductRepository] and adds banners/category images. Swap with an
/// API-backed implementation without changing the domain or UI.
class DiscoveryRepositoryImpl implements DiscoveryRepository {
  DiscoveryRepositoryImpl({required ProductRepository productRepository})
      : _productRepository = productRepository;

  final ProductRepository _productRepository;

  static const List<BannerEntity> _banners = [
    BannerEntity(
      imageUrl: 'https://images.unsplash.com/photo-1607082348824-0a96f2a4b9da?w=800',
      title: 'New Arrivals',
      subtitle: 'Discover the latest trends',
    ),
    BannerEntity(
      imageUrl: 'https://images.unsplash.com/photo-1556742049-0cfed4f6a45d?w=800',
      title: 'Up to 50% Off',
      subtitle: 'Limited time only',
    ),
    BannerEntity(
      imageUrl: 'https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=800',
      title: 'Free Shipping',
      subtitle: 'On orders over \$50',
    ),
  ];

  static const String _defaultCategoryImage =
      'https://images.unsplash.com/photo-1441984904996-e0b6ba687e04?w=600';
  static const Map<String, String> _categoryImageUrls = {
    'c1': 'https://images.unsplash.com/photo-1498049794561-7780e7231661?w=600',
    'c2': 'https://images.unsplash.com/photo-1441984904996-e0b6ba687e04?w=600',
    'c3': 'https://images.unsplash.com/photo-1586023492125-27b2c045efd7?w=600',
    'c4': 'https://images.unsplash.com/photo-1596462502278-27bfdc403348?w=600',
  };

  @override
  Future<List<BannerEntity>> getBanners() async {
    await Future<void>.delayed(const Duration(milliseconds: 100));
    return List.from(_banners);
  }

  @override
  Future<List<DiscoveryCategoryEntity>> getDiscoveryCategories() async {
    final categories = await _productRepository.getCategories();
    return categories
        .map((e) => DiscoveryCategoryEntity(
              category: e,
              imageUrl: _categoryImageUrls[e.id] ?? _defaultCategoryImage,
            ))
        .toList();
  }

  @override
  Future<List<ProductEntity>> getTrendingProducts() async {
    return _productRepository.getFeaturedProducts();
  }

  @override
  Future<List<ProductEntity>> getProductsByCategory(String categoryId) async {
    return _productRepository.getProductsByCategory(categoryId);
  }

  @override
  Future<List<ProductEntity>> searchProducts(String query) async {
    if (query.trim().isEmpty) return _productRepository.getFeaturedProducts();
    return _productRepository.searchProducts(query.trim());
  }

  @override
  Future<ProductEntity> getProductById(String id) {
    return _productRepository.getProductById(id);
  }
}

import '../../../products/domain/entities/product_entity.dart';
import '../entities/banner_entity.dart';
import '../entities/discovery_category_entity.dart';

/// Abstract repository for discovery data. UI and providers depend on this
/// interface; the data layer provides the implementation (mock or API).
abstract class DiscoveryRepository {
  Future<List<BannerEntity>> getBanners();
  Future<List<DiscoveryCategoryEntity>> getDiscoveryCategories();
  Future<List<ProductEntity>> getTrendingProducts();
  Future<List<ProductEntity>> getProductsByCategory(String categoryId);
  Future<List<ProductEntity>> searchProducts(String query);
  Future<ProductEntity> getProductById(String id);
}

import '../entities/category_entity.dart';
import '../entities/product_entity.dart';

/// Abstract repository that defines how the UI talks to
/// the products backend.
///
/// Buyers should provide their own implementation using
/// REST, GraphQL, Firebase, etc. and can keep the mock
/// implementation for local development.
abstract class ProductRepository {
  Future<List<CategoryEntity>> getCategories();

  Future<List<ProductEntity>> getFeaturedProducts();

  Future<List<ProductEntity>> getProductsByCategory(String categoryId);

  Future<List<ProductEntity>> searchProducts(String query);

  Future<ProductEntity> getProductById(String id);
}


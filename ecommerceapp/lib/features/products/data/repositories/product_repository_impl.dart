import '../../domain/entities/category_entity.dart';
import '../../domain/entities/product_entity.dart';
import '../../domain/repositories/product_repository.dart';
import '../datasources/mock_product_remote_data_source.dart';

/// Default in-memory repository implementation used by the template.
///
/// It uses [MockProductRemoteDataSource] to simulate responses.
/// Buyers should create their own implementation that calls their
/// real backend and swap it where this implementation is used.
class ProductRepositoryImpl implements ProductRepository {
  ProductRepositoryImpl({
    required MockProductRemoteDataSource remoteDataSource,
  }) : _remoteDataSource = remoteDataSource;

  final MockProductRemoteDataSource _remoteDataSource;

  List<ProductEntity>? _cachedProducts;
  List<CategoryEntity>? _cachedCategories;

  @override
  Future<List<CategoryEntity>> getCategories() async {
    _cachedCategories ??= await _remoteDataSource.fetchCategories();
    return _cachedCategories!;
  }

  @override
  Future<List<ProductEntity>> getFeaturedProducts() async {
    final all = await _getAllProducts();
    return all.where((p) => p.isFeatured).toList();
  }

  @override
  Future<List<ProductEntity>> getProductsByCategory(String categoryId) async {
    final all = await _getAllProducts();
    return all.where((p) => p.categoryId == categoryId).toList();
  }

  @override
  Future<List<ProductEntity>> searchProducts(String query) async {
    final all = await _getAllProducts();
    if (query.trim().isEmpty) {
      return all;
    }
    final lower = query.toLowerCase();
    return all
        .where(
          (p) =>
              p.name.toLowerCase().contains(lower) ||
              p.description.toLowerCase().contains(lower),
        )
        .toList();
  }

  @override
  Future<ProductEntity> getProductById(String id) async {
    final all = await _getAllProducts();
    return all.firstWhere((p) => p.id == id);
  }

  Future<List<ProductEntity>> _getAllProducts() async {
    _cachedProducts ??= await _remoteDataSource.fetchProducts();
    return _cachedProducts!;
  }
}


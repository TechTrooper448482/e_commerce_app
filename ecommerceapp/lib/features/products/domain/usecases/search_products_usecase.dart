import '../entities/product_entity.dart';
import '../repositories/product_repository.dart';

class SearchProductsUseCase {
  const SearchProductsUseCase(this._repository);

  final ProductRepository _repository;

  Future<List<ProductEntity>> call(String query) {
    return _repository.searchProducts(query);
  }
}


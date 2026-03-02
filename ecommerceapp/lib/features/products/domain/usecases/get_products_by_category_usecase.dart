import '../entities/product_entity.dart';
import '../repositories/product_repository.dart';

class GetProductsByCategoryUseCase {
  const GetProductsByCategoryUseCase(this._repository);

  final ProductRepository _repository;

  Future<List<ProductEntity>> call(String categoryId) {
    return _repository.getProductsByCategory(categoryId);
  }
}


import '../entities/product_entity.dart';
import '../repositories/product_repository.dart';

class GetProductDetailUseCase {
  const GetProductDetailUseCase(this._repository);

  final ProductRepository _repository;

  Future<ProductEntity> call(String id) {
    return _repository.getProductById(id);
  }
}


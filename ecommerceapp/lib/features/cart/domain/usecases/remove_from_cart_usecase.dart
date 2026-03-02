import '../../../products/domain/entities/product_entity.dart';
import '../repositories/cart_repository.dart';

class RemoveFromCartUseCase {
  const RemoveFromCartUseCase(this._repository);

  final CartRepository _repository;

  Future<void> call(ProductEntity product) {
    return _repository.removeProduct(product);
  }
}


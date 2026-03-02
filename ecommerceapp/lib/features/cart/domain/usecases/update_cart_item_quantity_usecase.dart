import '../../../products/domain/entities/product_entity.dart';
import '../repositories/cart_repository.dart';

class UpdateCartItemQuantityUseCase {
  const UpdateCartItemQuantityUseCase(this._repository);

  final CartRepository _repository;

  Future<void> call(ProductEntity product, int quantity) {
    return _repository.updateQuantity(product, quantity);
  }
}


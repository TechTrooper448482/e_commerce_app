import '../../../products/domain/entities/product_entity.dart';
import '../repositories/cart_repository.dart';

class AddToCartUseCase {
  const AddToCartUseCase(this._repository);

  final CartRepository _repository;

  Future<void> call(ProductEntity product) {
    return _repository.addProduct(product);
  }
}


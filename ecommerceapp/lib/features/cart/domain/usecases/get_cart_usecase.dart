import '../entities/cart_item_entity.dart';
import '../repositories/cart_repository.dart';

class GetCartUseCase {
  const GetCartUseCase(this._repository);

  final CartRepository _repository;

  Future<List<CartItemEntity>> call() {
    return _repository.getCartItems();
  }
}


import '../../../products/domain/entities/product_entity.dart';
import '../entities/cart_item_entity.dart';

/// Abstract repository for cart operations.
///
/// Buyers can back this with local storage, remote APIs, or both.
abstract class CartRepository {
  Future<List<CartItemEntity>> getCartItems();

  Future<void> addProduct(ProductEntity product);

  Future<void> updateQuantity(ProductEntity product, int quantity);

  Future<void> removeProduct(ProductEntity product);

  Future<void> clear();
}


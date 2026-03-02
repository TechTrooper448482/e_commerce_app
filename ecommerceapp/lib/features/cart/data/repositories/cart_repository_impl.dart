import '../../../products/domain/entities/product_entity.dart';
import '../../domain/entities/cart_item_entity.dart';
import '../../domain/repositories/cart_repository.dart';
import '../models/cart_item_model.dart';

/// Simple in-memory cart implementation.
///
/// Buyers can replace this with a repository that persists
/// to local storage or calls remote APIs.
class CartRepositoryImpl implements CartRepository {
  final List<CartItemModel> _items = <CartItemModel>[];

  @override
  Future<List<CartItemEntity>> getCartItems() async {
    return List<CartItemEntity>.unmodifiable(_items);
  }

  @override
  Future<void> addProduct(ProductEntity product) async {
    final index = _items.indexWhere((e) => e.product.id == product.id);
    if (index == -1) {
      _items.add(CartItemModel(product: product, quantity: 1));
    } else {
      final existing = _items[index];
      _items[index] =
          existing.copyWith(quantity: existing.quantity + 1);
    }
  }

  @override
  Future<void> updateQuantity(ProductEntity product, int quantity) async {
    final index = _items.indexWhere((e) => e.product.id == product.id);
    if (index == -1) {
      return;
    }
    if (quantity <= 0) {
      _items.removeAt(index);
    } else {
      final existing = _items[index];
      _items[index] = existing.copyWith(quantity: quantity);
    }
  }

  @override
  Future<void> removeProduct(ProductEntity product) async {
    _items.removeWhere((e) => e.product.id == product.id);
  }

  @override
  Future<void> clear() async {
    _items.clear();
  }
}


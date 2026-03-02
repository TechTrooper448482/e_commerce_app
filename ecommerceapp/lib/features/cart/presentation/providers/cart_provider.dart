import 'package:flutter/foundation.dart';

import '../../../products/domain/entities/product_entity.dart';
import '../../domain/entities/cart_item_entity.dart';
import '../../domain/repositories/cart_repository.dart';
import '../../domain/usecases/add_to_cart_usecase.dart';
import '../../domain/usecases/clear_cart_usecase.dart';
import '../../domain/usecases/get_cart_usecase.dart';
import '../../domain/usecases/remove_from_cart_usecase.dart';
import '../../domain/usecases/update_cart_item_quantity_usecase.dart';

class CartProvider extends ChangeNotifier {
  CartProvider({required CartRepository cartRepository})
      : _getCartUseCase = GetCartUseCase(cartRepository),
        _addToCartUseCase = AddToCartUseCase(cartRepository),
        _updateQuantityUseCase =
            UpdateCartItemQuantityUseCase(cartRepository),
        _removeFromCartUseCase = RemoveFromCartUseCase(cartRepository),
        _clearCartUseCase = ClearCartUseCase(cartRepository);

  final GetCartUseCase _getCartUseCase;
  final AddToCartUseCase _addToCartUseCase;
  final UpdateCartItemQuantityUseCase _updateQuantityUseCase;
  final RemoveFromCartUseCase _removeFromCartUseCase;
  final ClearCartUseCase _clearCartUseCase;

  List<CartItemEntity> _items = <CartItemEntity>[];
  bool _isLoading = false;

  List<CartItemEntity> get items => _items;
  bool get isLoading => _isLoading;

  double get total =>
      _items.fold(0, (sum, e) => sum + e.lineTotal);

  Future<void> loadCart() async {
    _setLoading(true);
    try {
      _items = await _getCartUseCase();
    } finally {
      _setLoading(false);
    }
  }

  Future<void> addToCart(ProductEntity product) async {
    await _addToCartUseCase(product);
    await loadCart();
  }

  Future<void> updateQuantity(ProductEntity product, int quantity) async {
    await _updateQuantityUseCase(product, quantity);
    await loadCart();
  }

  Future<void> remove(ProductEntity product) async {
    await _removeFromCartUseCase(product);
    await loadCart();
  }

  Future<void> clear() async {
    await _clearCartUseCase();
    await loadCart();
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}


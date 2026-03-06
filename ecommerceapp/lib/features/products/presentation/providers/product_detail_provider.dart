import 'package:flutter/foundation.dart';

import '../../domain/entities/product_entity.dart';
import '../../domain/usecases/get_product_detail_usecase.dart';

/// State for the product detail screen: product, selected variant, quantity,
/// and favorite status. UI only reads state and calls methods.
class ProductDetailProvider extends ChangeNotifier {
  ProductDetailProvider({
    required GetProductDetailUseCase getProductDetailUseCase,
  }) : _getProductDetailUseCase = getProductDetailUseCase;

  final GetProductDetailUseCase _getProductDetailUseCase;

  ProductEntity? _product;
  bool _isLoading = true;
  String? _errorMessage;

  String? _selectedColor;
  String? _selectedSize;
  int _quantity = 1;
  bool _isFavorite = false;

  /// Syncs favorite state with external [FavoritesProvider] when product loads.
  void syncFavoriteFrom(bool isFavorite) {
    if (_isFavorite != isFavorite) {
      _isFavorite = isFavorite;
      notifyListeners();
    }
  }

  ProductEntity? get product => _product;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  String? get selectedColor => _selectedColor;
  String? get selectedSize => _selectedSize;
  int get quantity => _quantity;
  bool get isFavorite => _isFavorite;

  /// Load product by id and apply default variant selections.
  Future<void> loadProduct(String productId) async {
    _isLoading = true;
    _errorMessage = null;
    _product = null;
    _selectedColor = null;
    _selectedSize = null;
    _quantity = 1;
    notifyListeners();

    try {
      _product = await _getProductDetailUseCase(productId);
      final p = _product!;
      if (p.colorOptions != null && p.colorOptions!.isNotEmpty) {
        _selectedColor = p.colorOptions!.first;
      }
      if (p.sizeOptions != null && p.sizeOptions!.isNotEmpty) {
        _selectedSize = p.sizeOptions!.first;
      }
    } catch (e) {
      _errorMessage = 'Could not load product.';
      if (kDebugMode) debugPrint('ProductDetailProvider.loadProduct: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void setSelectedColor(String? color) {
    if (_selectedColor == color) return;
    _selectedColor = color;
    notifyListeners();
  }

  void setSelectedSize(String? size) {
    if (_selectedSize == size) return;
    _selectedSize = size;
    notifyListeners();
  }

  void setQuantity(int value) {
    final q = value.clamp(1, 99);
    if (_quantity == q) return;
    _quantity = q;
    notifyListeners();
  }

  void incrementQuantity() => setQuantity(_quantity + 1);
  void decrementQuantity() => setQuantity(_quantity - 1);

  void setFavorite(bool value) {
    if (_isFavorite == value) return;
    _isFavorite = value;
    notifyListeners();
  }

  void toggleFavorite() {
    _isFavorite = !_isFavorite;
    notifyListeners();
  }

  void clear() {
    _product = null;
    _selectedColor = null;
    _selectedSize = null;
    _quantity = 1;
    _isFavorite = false;
    _errorMessage = null;
    notifyListeners();
  }
}

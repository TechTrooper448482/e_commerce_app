import 'package:flutter/foundation.dart';

import '../../domain/entities/category_entity.dart';
import '../../domain/entities/product_entity.dart';
import '../../domain/repositories/product_repository.dart';
import '../../domain/usecases/get_home_data_usecase.dart';
import '../../domain/usecases/get_product_detail_usecase.dart';
import '../../domain/usecases/get_products_by_category_usecase.dart';
import '../../domain/usecases/search_products_usecase.dart';

class ProductProvider extends ChangeNotifier {
  ProductProvider({required ProductRepository productRepository})
      : _homeDataUseCase = GetHomeDataUseCase(productRepository),
        _searchUseCase = SearchProductsUseCase(productRepository),
        _getByCategoryUseCase =
            GetProductsByCategoryUseCase(productRepository),
        _detailUseCase = GetProductDetailUseCase(productRepository);

  final GetHomeDataUseCase _homeDataUseCase;
  final SearchProductsUseCase _searchUseCase;
  final GetProductsByCategoryUseCase _getByCategoryUseCase;
  final GetProductDetailUseCase _detailUseCase;

  List<CategoryEntity> _categories = <CategoryEntity>[];
  List<ProductEntity> _featuredProducts = <ProductEntity>[];
  List<ProductEntity> _visibleProducts = <ProductEntity>[];

  CategoryEntity? _selectedCategory;
  bool _isLoading = false;
  String? _errorMessage;
  String _searchQuery = '';

  List<CategoryEntity> get categories => _categories;
  List<ProductEntity> get featuredProducts => _featuredProducts;
  List<ProductEntity> get visibleProducts => _visibleProducts;
  CategoryEntity? get selectedCategory => _selectedCategory;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  String get searchQuery => _searchQuery;

  Future<void> loadHome() async {
    _setLoading(true);
    _errorMessage = null;

    try {
      final data = await _homeDataUseCase();
      _categories = data.categories;
      _featuredProducts = data.featuredProducts;
      _visibleProducts = _featuredProducts;
      _selectedCategory = null;
    } catch (e) {
      _errorMessage = 'Failed to load products.';
      if (kDebugMode) {
        // ignore: avoid_print
        print(e);
      }
    } finally {
      _setLoading(false);
    }
  }

  Future<void> selectCategory(CategoryEntity? category) async {
    _selectedCategory = category;
    _searchQuery = '';

    if (category == null) {
      _visibleProducts = _featuredProducts;
      notifyListeners();
      return;
    }

    _setLoading(true);
    try {
      _visibleProducts = await _getByCategoryUseCase(category.id);
    } catch (e) {
      _errorMessage = 'Failed to load category products.';
      if (kDebugMode) {
        // ignore: avoid_print
        print(e);
      }
    } finally {
      _setLoading(false);
    }
  }

  Future<void> search(String query) async {
    _searchQuery = query;
    _selectedCategory = null;

    _setLoading(true);
    try {
      _visibleProducts = await _searchUseCase(query);
    } catch (e) {
      _errorMessage = 'Search failed.';
      if (kDebugMode) {
        // ignore: avoid_print
        print(e);
      }
    } finally {
      _setLoading(false);
    }
  }

  Future<ProductEntity> loadProductDetail(String id) {
    return _detailUseCase(id);
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}


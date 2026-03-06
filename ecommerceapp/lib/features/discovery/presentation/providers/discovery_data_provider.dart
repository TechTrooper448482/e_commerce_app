import 'package:flutter/foundation.dart';

import '../../../products/domain/entities/product_entity.dart';
import '../../domain/entities/banner_entity.dart';
import '../../domain/entities/discovery_category_entity.dart';
import '../../domain/repositories/discovery_repository.dart';

/// Holds all discovery data (banners, categories, trending, category products).
/// Business logic and loading live here; widgets only read state and call methods.
class DiscoveryDataProvider extends ChangeNotifier {
  DiscoveryDataProvider({required DiscoveryRepository repository})
      : _repository = repository;

  final DiscoveryRepository _repository;

  List<BannerEntity> _banners = [];
  List<DiscoveryCategoryEntity> _discoveryCategories = [];
  List<ProductEntity> _trendingProducts = [];
  List<ProductEntity> _categoryProducts = [];
  bool _isLoadingHome = false;
  bool _isLoadingCategory = false;
  String? _loadedCategoryId;

  List<BannerEntity> get banners => List.unmodifiable(_banners);
  List<DiscoveryCategoryEntity> get discoveryCategories =>
      List.unmodifiable(_discoveryCategories);
  List<ProductEntity> get trendingProducts =>
      List.unmodifiable(_trendingProducts);
  List<ProductEntity> get categoryProducts =>
      List.unmodifiable(_categoryProducts);
  bool get isLoadingHome => _isLoadingHome;
  bool get isLoadingCategory => _isLoadingCategory;
  String? get loadedCategoryId => _loadedCategoryId;

  /// Loads banners, discovery categories, and trending products for the home screen.
  Future<void> loadDiscoveryHome() async {
    if (_isLoadingHome) return;
    _isLoadingHome = true;
    notifyListeners();

    try {
      final results = await Future.wait([
        _repository.getBanners(),
        _repository.getDiscoveryCategories(),
        _repository.getTrendingProducts(),
      ]);
      _banners = results[0] as List<BannerEntity>;
      _discoveryCategories =
          results[1] as List<DiscoveryCategoryEntity>;
      _trendingProducts = results[2] as List<ProductEntity>;
    } catch (e) {
      if (kDebugMode) debugPrint('DiscoveryDataProvider.loadDiscoveryHome: $e');
    } finally {
      _isLoadingHome = false;
      notifyListeners();
    }
  }

  /// Loads products for a category (sub-category page). Idempotent per category.
  Future<void> loadProductsByCategory(String categoryId) async {
    if (_loadedCategoryId == categoryId && _categoryProducts.isNotEmpty) return;
    _isLoadingCategory = true;
    _loadedCategoryId = categoryId;
    notifyListeners();

    try {
      _categoryProducts =
          await _repository.getProductsByCategory(categoryId);
    } catch (e) {
      if (kDebugMode) debugPrint('DiscoveryDataProvider.loadProductsByCategory: $e');
      _categoryProducts = [];
    } finally {
      _isLoadingCategory = false;
      notifyListeners();
    }
  }
}

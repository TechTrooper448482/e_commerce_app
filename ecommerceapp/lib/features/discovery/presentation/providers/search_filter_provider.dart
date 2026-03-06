import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../products/domain/entities/product_entity.dart';
import '../../domain/repositories/discovery_repository.dart';

/// Filter and search state for the Search & Filter page.
/// Holds search results, loading, filter state (price, colors, sizes, rating).
/// All search/filter logic lives here; widgets only read state and call methods.
class SearchFilterProvider extends ChangeNotifier {
  final List<String> _recentSearches = [];
  static const int _maxRecent = 8;

  String _query = '';
  RangeValues _priceRange = const RangeValues(0, 500);
  final Set<String> _selectedColors = {};
  final Set<String> _selectedSizes = {};
  int _minRating = 0; // 0 = any, 1-5 = stars
  bool _filterSheetVisible = false;

  List<ProductEntity> _searchResults = [];
  bool _isSearching = false;

  String get query => _query;
  RangeValues get priceRange => _priceRange;
  Set<String> get selectedColors => Set.unmodifiable(_selectedColors);
  Set<String> get selectedSizes => Set.unmodifiable(_selectedSizes);
  int get minRating => _minRating;
  bool get filterSheetVisible => _filterSheetVisible;
  List<String> get recentSearches => List.unmodifiable(_recentSearches);
  List<ProductEntity> get searchResults => List.unmodifiable(_searchResults);
  bool get isSearching => _isSearching;

  /// Filtered results by price range (and other filters when product data supports them).
  List<ProductEntity> get filteredSearchResults {
    return _searchResults.where((p) {
      if (p.price < _priceRange.start || p.price > _priceRange.end) return false;
      return true;
    }).toList();
  }

  static const List<String> colorOptions = [
    'Black', 'White', 'Red', 'Blue', 'Green', 'Grey', 'Beige', 'Pink',
  ];

  static const List<String> sizeOptions = ['S', 'M', 'L', 'XL'];

  void setQuery(String value) {
    if (_query == value) return;
    _query = value;
    notifyListeners();
  }

  void addRecentSearch(String term) {
    if (term.trim().isEmpty) return;
    _recentSearches.remove(term.trim());
    _recentSearches.insert(0, term.trim());
    if (_recentSearches.length > _maxRecent) _recentSearches.removeLast();
    notifyListeners();
  }

  void clearRecentSearches() {
    _recentSearches.clear();
    notifyListeners();
  }

  void setPriceRange(RangeValues values) {
    _priceRange = values;
    notifyListeners();
  }

  void toggleColor(String color) {
    if (_selectedColors.contains(color)) {
      _selectedColors.remove(color);
    } else {
      _selectedColors.add(color);
    }
    notifyListeners();
  }

  void toggleSize(String size) {
    if (_selectedSizes.contains(size)) {
      _selectedSizes.remove(size);
    } else {
      _selectedSizes.add(size);
    }
    notifyListeners();
  }

  void setMinRating(int stars) {
    _minRating = stars;
    notifyListeners();
  }

  void openFilterSheet() {
    _filterSheetVisible = true;
    notifyListeners();
  }

  void closeFilterSheet() {
    _filterSheetVisible = false;
    notifyListeners();
  }

  bool get hasActiveFilters =>
      _selectedColors.isNotEmpty ||
      _selectedSizes.isNotEmpty ||
      _minRating > 0 ||
      _priceRange.start > 0 ||
      _priceRange.end < 500;

  void clearFilters() {
    _priceRange = const RangeValues(0, 500);
    _selectedColors.clear();
    _selectedSizes.clear();
    _minRating = 0;
    notifyListeners();
  }

  /// Performs search via [DiscoveryRepository]. Updates [searchResults] and [isSearching].
  Future<void> search(DiscoveryRepository repository, String query) async {
    _query = query;
    _isSearching = true;
    notifyListeners();

    try {
      _searchResults = await repository.searchProducts(query);
    } catch (e) {
      if (kDebugMode) debugPrint('SearchFilterProvider.search: $e');
      _searchResults = [];
    } finally {
      _isSearching = false;
      notifyListeners();
    }
  }

  /// Loads initial/trending products for the search page (empty query).
  Future<void> loadTrendingResults(DiscoveryRepository repository) async {
    _isSearching = true;
    notifyListeners();
    try {
      _searchResults = await repository.getTrendingProducts();
    } catch (e) {
      if (kDebugMode) debugPrint('SearchFilterProvider.loadTrendingResults: $e');
      _searchResults = [];
    } finally {
      _isSearching = false;
      notifyListeners();
    }
  }
}

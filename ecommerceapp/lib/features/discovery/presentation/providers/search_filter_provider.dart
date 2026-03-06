import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Filter and search state for the Search & Filter page.
/// Price range, colors, sizes, and star rating.
class SearchFilterProvider extends ChangeNotifier {
  final List<String> _recentSearches = [];
  static const int _maxRecent = 8;

  String _query = '';
  RangeValues _priceRange = const RangeValues(0, 500);
  final Set<String> _selectedColors = {};
  final Set<String> _selectedSizes = {};
  int _minRating = 0; // 0 = any, 1-5 = stars
  bool _filterSheetVisible = false;

  String get query => _query;
  RangeValues get priceRange => _priceRange;
  Set<String> get selectedColors => Set.unmodifiable(_selectedColors);
  Set<String> get selectedSizes => Set.unmodifiable(_selectedSizes);
  int get minRating => _minRating;
  bool get filterSheetVisible => _filterSheetVisible;
  List<String> get recentSearches => List.unmodifiable(_recentSearches);

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
}

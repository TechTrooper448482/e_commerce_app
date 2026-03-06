import 'package:flutter/foundation.dart';

/// In-memory favorites (product IDs). Persist with SharedPreferences or API if needed.
class FavoritesProvider extends ChangeNotifier {
  final Set<String> _ids = {};

  bool isFavorite(String productId) => _ids.contains(productId);

  void toggle(String productId) {
    if (_ids.contains(productId)) {
      _ids.remove(productId);
    } else {
      _ids.add(productId);
    }
    notifyListeners();
  }
}

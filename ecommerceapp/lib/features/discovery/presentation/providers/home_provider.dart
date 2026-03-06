import 'dart:async';

import 'package:flutter/foundation.dart';

import '../../data/services/mock_product_service.dart';

/// Home screen state: auto-scrolling banner and banner list.
/// Timer is managed here and disposed in [dispose].
class HomeProvider extends ChangeNotifier {
  HomeProvider({required MockProductService productService})
      : _productService = productService {
    _init();
  }

  final MockProductService _productService;

  List<BannerItem> _banners = [];
  int _currentBannerIndex = 0;
  Timer? _bannerTimer;
  static const Duration _bannerDuration = Duration(seconds: 4);

  List<BannerItem> get banners => _banners;
  int get currentBannerIndex => _currentBannerIndex;

  Future<void> _init() async {
    _banners = await _productService.getBanners();
    notifyListeners();
    _startBannerTimer();
  }

  void _startBannerTimer() {
    _bannerTimer?.cancel();
    if (_banners.isEmpty) return;
    _bannerTimer = Timer.periodic(_bannerDuration, (_) {
      _currentBannerIndex = (_currentBannerIndex + 1) % _banners.length;
      notifyListeners();
    });
  }

  void setBannerIndex(int index) {
    if (index == _currentBannerIndex) return;
    if (index < 0 || index >= _banners.length) return;
    _currentBannerIndex = index;
    _startBannerTimer(); // reset timer on manual swipe
    notifyListeners();
  }

  @override
  void dispose() {
    _bannerTimer?.cancel();
    super.dispose();
  }
}

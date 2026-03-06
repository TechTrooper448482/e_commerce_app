import 'dart:async';

import 'package:flutter/foundation.dart';

/// Home screen UI state: auto-scrolling banner index and timer only.
/// Banner list comes from [DiscoveryDataProvider]; this provider only
/// manages current index and periodic advancement.
class HomeProvider extends ChangeNotifier {
  int _currentBannerIndex = 0;
  int _bannerCount = 0;
  Timer? _bannerTimer;
  static const Duration bannerDuration = Duration(seconds: 4);

  int get currentBannerIndex => _currentBannerIndex;
  int get bannerCount => _bannerCount;

  /// Call when the banner list is available (e.g. after [DiscoveryDataProvider] loads).
  /// Starts or restarts the auto-scroll timer when count > 0.
  void updateBannerCount(int count) {
    if (_bannerCount == count) return;
    _bannerCount = count;
    if (_currentBannerIndex >= _bannerCount) _currentBannerIndex = 0;
    _startBannerTimer();
    notifyListeners();
  }

  void _startBannerTimer() {
    _bannerTimer?.cancel();
    if (_bannerCount <= 1) return;
    _bannerTimer = Timer.periodic(bannerDuration, (_) {
      _currentBannerIndex = (_currentBannerIndex + 1) % _bannerCount;
      notifyListeners();
    });
  }

  void setBannerIndex(int index) {
    if (index == _currentBannerIndex) return;
    if (index < 0 || index >= _bannerCount) return;
    _currentBannerIndex = index;
    _startBannerTimer();
    notifyListeners();
  }

  @override
  void dispose() {
    _bannerTimer?.cancel();
    super.dispose();
  }
}

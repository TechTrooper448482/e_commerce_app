import 'package:flutter/material.dart';

/// Maps category icon name to [IconData].
class DiscoveryCategoryIcon {
  DiscoveryCategoryIcon._();

  static IconData forName(String iconName) {
    switch (iconName) {
      case 'devices':
        return Icons.devices;
      case 'checkroom':
        return Icons.checkroom;
      case 'weekend':
        return Icons.weekend;
      case 'brush':
        return Icons.brush;
      default:
        return Icons.category;
    }
  }
}

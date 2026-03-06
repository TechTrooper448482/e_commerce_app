import 'package:flutter/material.dart';

import 'app_colors.dart';

/// Maps filter color name to [Color].
Color colorFromFilterName(String name) {
  switch (name.toLowerCase()) {
    case 'black':
      return Colors.black;
    case 'white':
      return Colors.white;
    case 'red':
      return Colors.red;
    case 'blue':
      return Colors.blue;
    case 'green':
      return Colors.green;
    case 'grey':
      return Colors.grey;
    case 'beige':
      return AppColors.filterBeige;
    case 'pink':
      return Colors.pink;
    default:
      return Colors.grey;
  }
}

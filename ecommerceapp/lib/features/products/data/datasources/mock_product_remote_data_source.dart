import '../models/category_model.dart';
import '../models/product_model.dart';

/// Mock remote data source that returns hard-coded JSON-like maps.
///
/// Buyers can replace this with a real HTTP data source using
/// the `ApiClient` in `core/network/api_client.dart` and values
/// from `AppConfig`.
class MockProductRemoteDataSource {
  Future<List<CategoryModel>> fetchCategories() async {
    await Future<void>.delayed(const Duration(milliseconds: 400));

    final raw = <Map<String, dynamic>>[
      <String, dynamic>{'id': 'c1', 'name': 'Electronics', 'icon': 'devices'},
      <String, dynamic>{'id': 'c2', 'name': 'Fashion', 'icon': 'checkroom'},
      <String, dynamic>{'id': 'c3', 'name': 'Home', 'icon': 'weekend'},
      <String, dynamic>{'id': 'c4', 'name': 'Beauty', 'icon': 'brush'},
    ];

    return raw.map(CategoryModel.fromJson).toList();
  }

  Future<List<ProductModel>> fetchProducts() async {
    await Future<void>.delayed(const Duration(milliseconds: 500));

    final raw = <Map<String, dynamic>>[
      <String, dynamic>{
        'id': 'p1',
        'name': 'Wireless Headphones',
        'description': 'Noise-cancelling over-ear headphones with 30h battery.',
        'price': 129.99,
        'imageUrls': <String>[
          'https://via.placeholder.com/600x400?text=Headphones+1',
          'https://via.placeholder.com/600x400?text=Headphones+2',
        ],
        'categoryId': 'c1',
        'isFeatured': true,
      },
      <String, dynamic>{
        'id': 'p2',
        'name': 'Smart Watch',
        'description': 'Track your workouts, sleep, and notifications.',
        'price': 199.50,
        'imageUrls': <String>[
          'https://via.placeholder.com/600x400?text=Watch+1',
        ],
        'categoryId': 'c1',
        'isFeatured': true,
      },
      <String, dynamic>{
        'id': 'p3',
        'name': 'Casual Sneakers',
        'description': 'Comfortable sneakers for everyday wear.',
        'price': 79.90,
        'imageUrls': <String>[
          'https://via.placeholder.com/600x400?text=Sneakers+1',
        ],
        'categoryId': 'c2',
        'isFeatured': true,
      },
      <String, dynamic>{
        'id': 'p4',
        'name': 'Coffee Maker',
        'description': 'Brew rich coffee with programmable timer.',
        'price': 59.99,
        'imageUrls': <String>[
          'https://via.placeholder.com/600x400?text=Coffee+Maker',
        ],
        'categoryId': 'c3',
        'isFeatured': false,
      },
    ];

    return raw.map(ProductModel.fromJson).toList();
  }
}


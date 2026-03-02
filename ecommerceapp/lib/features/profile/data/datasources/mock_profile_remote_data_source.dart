import '../../../auth/domain/entities/user_entity.dart';
import '../models/order_model.dart';
import '../models/profile_model.dart';

/// Mock remote data source for profile and orders.
///
/// Buyers should replace this with real API calls using the
/// networking layer in `core/network/api_client.dart`.
class MockProfileRemoteDataSource {
  Future<ProfileModel> fetchProfile() async {
    await Future<void>.delayed(const Duration(milliseconds: 400));

    final user = UserEntity(
      id: 'user_1',
      name: 'John Doe',
      email: 'demo@shop.com',
    );

    final orders = await fetchOrders();
    return ProfileModel(user: user, orders: orders);
  }

  Future<List<OrderModel>> fetchOrders() async {
    await Future<void>.delayed(const Duration(milliseconds: 400));

    final raw = <Map<String, dynamic>>[
      <String, dynamic>{
        'id': 'o1',
        'date': DateTime.now()
            .subtract(const Duration(days: 1))
            .toIso8601String(),
        'total': 129.99,
        'status': 'Delivered',
      },
      <String, dynamic>{
        'id': 'o2',
        'date': DateTime.now()
            .subtract(const Duration(days: 5))
            .toIso8601String(),
        'total': 59.49,
        'status': 'Delivered',
      },
      <String, dynamic>{
        'id': 'o3',
        'date': DateTime.now()
            .subtract(const Duration(days: 10))
            .toIso8601String(),
        'total': 89.00,
        'status': 'Cancelled',
      },
    ];

    return raw.map(OrderModel.fromJson).toList();
  }

  Future<void> reorder(String orderId) async {
    await Future<void>.delayed(const Duration(milliseconds: 300));
  }

  Future<void> cancelOrder(String orderId) async {
    await Future<void>.delayed(const Duration(milliseconds: 300));
  }
}


import '../entities/profile_entity.dart';
import '../entities/order_entity.dart';

/// Abstract repository for profile and order history.
///
/// Buyers should implement this interface to call their
/// real backend APIs.
abstract class ProfileRepository {
  Future<ProfileEntity> getProfile();

  Future<List<OrderEntity>> getOrders();

  Future<void> reorder(String orderId);

  Future<void> cancelOrder(String orderId);
}


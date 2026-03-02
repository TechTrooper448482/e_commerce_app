import '../../domain/entities/order_entity.dart';
import '../../domain/entities/profile_entity.dart';
import '../../domain/repositories/profile_repository.dart';
import '../datasources/mock_profile_remote_data_source.dart';

/// Repository implementation backed by [MockProfileRemoteDataSource].
///
/// Buyers should implement [ProfileRepository] with real API calls and
/// swap this implementation in `main.dart`.
class ProfileRepositoryImpl implements ProfileRepository {
  ProfileRepositoryImpl({
    required MockProfileRemoteDataSource remoteDataSource,
  }) : _remoteDataSource = remoteDataSource;

  final MockProfileRemoteDataSource _remoteDataSource;

  ProfileEntity? _cachedProfile;

  @override
  Future<ProfileEntity> getProfile() async {
    _cachedProfile ??= await _remoteDataSource.fetchProfile();
    return _cachedProfile!;
  }

  @override
  Future<List<OrderEntity>> getOrders() async {
    final profile = await getProfile();
    return profile.orders;
  }

  @override
  Future<void> reorder(String orderId) {
    return _remoteDataSource.reorder(orderId);
  }

  @override
  Future<void> cancelOrder(String orderId) {
    return _remoteDataSource.cancelOrder(orderId);
  }
}


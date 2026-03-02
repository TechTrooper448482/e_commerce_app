import '../entities/user_entity.dart';

/// Abstract contract for authentication operations.
///
/// Buyers should create a concrete implementation that talks
/// to their real backend (REST, GraphQL, Firebase, etc.) and
/// wire it where [MockAuthRepositoryImpl] is currently used.
abstract class AuthRepository {
  Future<UserEntity> login({
    required String email,
    required String password,
  });

  Future<UserEntity> signup({
    required String name,
    required String email,
    required String password,
  });

  Future<void> logout();
}


import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/mock_auth_remote_data_source.dart';

/// Default repository implementation used by this template.
///
/// It delegates to [MockAuthRemoteDataSource] which returns
/// dummy data. Buyers should create another implementation
/// that talks to a real backend and swap it in the app root.
class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl({
    required MockAuthRemoteDataSource remoteDataSource,
  }) : _remoteDataSource = remoteDataSource;

  final MockAuthRemoteDataSource _remoteDataSource;

  @override
  Future<UserEntity> login({
    required String email,
    required String password,
  }) {
    return _remoteDataSource.login(email: email, password: password);
  }

  @override
  Future<UserEntity> signup({
    required String name,
    required String email,
    required String password,
  }) {
    return _remoteDataSource.signup(
      name: name,
      email: email,
      password: password,
    );
  }

  @override
  Future<void> logout() {
    return _remoteDataSource.logout();
  }
}


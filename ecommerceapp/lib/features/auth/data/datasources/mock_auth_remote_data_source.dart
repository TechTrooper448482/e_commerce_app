import '../../../../core/constants/app_config.dart';
import '../models/user_model.dart';

/// Mock implementation that simulates remote auth calls.
///
/// When integrating a real backend, buyers can:
/// - Replace this class with a real remote data source using [AppConfig.baseUrl]
///   and [AppConfig.apiKey], OR
/// - Keep it for development and add a second implementation.
class MockAuthRemoteDataSource {
  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 600));

    return UserModel(
      id: 'user_1',
      name: 'John Doe',
      email: email,
    );
  }

  Future<UserModel> signup({
    required String name,
    required String email,
    required String password,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 800));

    return UserModel(
      id: 'user_2',
      name: name,
      email: email,
    );
  }

  Future<void> logout() async {
    await Future<void>.delayed(const Duration(milliseconds: 300));
  }
}


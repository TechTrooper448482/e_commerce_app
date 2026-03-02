import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

class SignupUseCase {
  const SignupUseCase(this._repository);

  final AuthRepository _repository;

  Future<UserEntity> call({
    required String name,
    required String email,
    required String password,
  }) {
    return _repository.signup(
      name: name,
      email: email,
      password: password,
    );
  }
}


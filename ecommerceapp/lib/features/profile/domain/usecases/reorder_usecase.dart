import '../repositories/profile_repository.dart';

class ReorderUseCase {
  const ReorderUseCase(this._repository);

  final ProfileRepository _repository;

  Future<void> call(String orderId) {
    return _repository.reorder(orderId);
  }
}


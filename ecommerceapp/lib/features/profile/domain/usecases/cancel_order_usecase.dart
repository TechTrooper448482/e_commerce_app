import '../repositories/profile_repository.dart';

class CancelOrderUseCase {
  const CancelOrderUseCase(this._repository);

  final ProfileRepository _repository;

  Future<void> call(String orderId) {
    return _repository.cancelOrder(orderId);
  }
}


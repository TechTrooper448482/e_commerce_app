import '../entities/order_entity.dart';
import '../repositories/profile_repository.dart';

class GetOrdersUseCase {
  const GetOrdersUseCase(this._repository);

  final ProfileRepository _repository;

  Future<List<OrderEntity>> call() {
    return _repository.getOrders();
  }
}


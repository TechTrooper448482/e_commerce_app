import 'package:flutter/foundation.dart';

import '../../domain/entities/order_entity.dart';
import '../../domain/entities/profile_entity.dart';
import '../../domain/repositories/profile_repository.dart';
import '../../domain/usecases/cancel_order_usecase.dart';
import '../../domain/usecases/get_orders_usecase.dart';
import '../../domain/usecases/get_profile_usecase.dart';
import '../../domain/usecases/reorder_usecase.dart';

class ProfileProvider extends ChangeNotifier {
  ProfileProvider({required ProfileRepository repository})
      : _getProfileUseCase = GetProfileUseCase(repository),
        _getOrdersUseCase = GetOrdersUseCase(repository),
        _reorderUseCase = ReorderUseCase(repository),
        _cancelOrderUseCase = CancelOrderUseCase(repository);

  final GetProfileUseCase _getProfileUseCase;
  final GetOrdersUseCase _getOrdersUseCase;
  final ReorderUseCase _reorderUseCase;
  final CancelOrderUseCase _cancelOrderUseCase;

  ProfileEntity? _profile;
  List<OrderEntity> _orders = <OrderEntity>[];
  bool _isLoading = false;

  ProfileEntity? get profile => _profile;
  List<OrderEntity> get orders => _orders;
  bool get isLoading => _isLoading;

  Future<void> loadProfile() async {
    _setLoading(true);
    try {
      _profile = await _getProfileUseCase();
      _orders = await _getOrdersUseCase();
    } finally {
      _setLoading(false);
    }
  }

  Future<void> reorder(String orderId) async {
    await _reorderUseCase(orderId);
  }

  Future<void> cancelOrder(String orderId) async {
    await _cancelOrderUseCase(orderId);
    _orders = _orders
        .map(
          (o) => o.id == orderId
              ? OrderEntity(
                  id: o.id,
                  date: o.date,
                  total: o.total,
                  status: 'Cancelled',
                )
              : o,
        )
        .toList();
    notifyListeners();
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}


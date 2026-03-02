import '../../../auth/domain/entities/user_entity.dart';
import 'order_entity.dart';

class ProfileEntity {
  const ProfileEntity({
    required this.user,
    required this.orders,
  });

  final UserEntity user;
  final List<OrderEntity> orders;
}


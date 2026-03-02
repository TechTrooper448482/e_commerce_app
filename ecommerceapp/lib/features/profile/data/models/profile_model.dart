import '../../../auth/domain/entities/user_entity.dart';
import '../../domain/entities/profile_entity.dart';
import '../../domain/entities/order_entity.dart';

class ProfileModel extends ProfileEntity {
  const ProfileModel({
    required super.user,
    required super.orders,
  });

  ProfileModel copyWith({
    UserEntity? user,
    List<OrderEntity>? orders,
  }) {
    return ProfileModel(
      user: user ?? this.user,
      orders: orders ?? this.orders,
    );
  }
}


import '../../../products/domain/entities/category_entity.dart';

/// Domain entity: category with an image URL for discovery list/cards.
class DiscoveryCategoryEntity {
  const DiscoveryCategoryEntity({
    required this.category,
    required this.imageUrl,
  });

  final CategoryEntity category;
  final String imageUrl;
}

import '../../domain/entities/product_entity.dart';
import '../../domain/entities/product_review_entity.dart';

class ProductModel extends ProductEntity {
  const ProductModel({
    required super.id,
    required super.name,
    required super.description,
    required super.price,
    required super.imageUrls,
    required super.categoryId,
    super.isFeatured = false,
    super.originalPrice,
    super.stockCount,
    super.urgencyTag,
    super.colorOptions,
    super.sizeOptions,
    super.reviews,
    super.averageRating,
    super.reviewCount,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    final reviewsList = json['reviews'] as List<dynamic>?;
    List<ProductReviewEntity>? reviews;
    if (reviewsList != null) {
      reviews = reviewsList
          .map((e) => _reviewFromJson(e as Map<String, dynamic>))
          .toList();
    }
    return ProductModel(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      price: (json['price'] as num).toDouble(),
      imageUrls: (json['imageUrls'] as List<dynamic>).cast<String>(),
      categoryId: json['categoryId'] as String,
      isFeatured: json['isFeatured'] as bool? ?? false,
      originalPrice: (json['originalPrice'] as num?)?.toDouble(),
      stockCount: json['stockCount'] as int?,
      urgencyTag: json['urgencyTag'] as String?,
      colorOptions: (json['colorOptions'] as List<dynamic>?)?.cast<String>(),
      sizeOptions: (json['sizeOptions'] as List<dynamic>?)?.cast<String>(),
      reviews: reviews,
      averageRating: (json['averageRating'] as num?)?.toDouble(),
      reviewCount: json['reviewCount'] as int?,
    );
  }

  static ProductReviewEntity _reviewFromJson(Map<String, dynamic> json) {
    return ProductReviewEntity(
      id: json['id'] as String,
      authorName: json['authorName'] as String,
      rating: json['rating'] as int,
      body: json['body'] as String,
      avatarUrl: json['avatarUrl'] as String?,
      isVerifiedPurchase: json['isVerifiedPurchase'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'imageUrls': imageUrls,
      'categoryId': categoryId,
      'isFeatured': isFeatured,
      if (originalPrice != null) 'originalPrice': originalPrice,
      if (stockCount != null) 'stockCount': stockCount,
      if (urgencyTag != null) 'urgencyTag': urgencyTag,
      if (colorOptions != null) 'colorOptions': colorOptions,
      if (sizeOptions != null) 'sizeOptions': sizeOptions,
      if (averageRating != null) 'averageRating': averageRating,
      if (reviewCount != null) 'reviewCount': reviewCount,
    };
  }
}


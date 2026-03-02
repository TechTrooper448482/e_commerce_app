class ProductEntity {
  const ProductEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrls,
    required this.categoryId,
    this.isFeatured = false,
  });

  final String id;
  final String name;
  final String description;
  final double price;
  final List<String> imageUrls;
  final String categoryId;
  final bool isFeatured;
}


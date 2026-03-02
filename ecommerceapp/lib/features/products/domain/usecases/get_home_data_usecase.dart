import '../entities/category_entity.dart';
import '../entities/product_entity.dart';
import '../repositories/product_repository.dart';

class HomeData {
  const HomeData({
    required this.categories,
    required this.featuredProducts,
  });

  final List<CategoryEntity> categories;
  final List<ProductEntity> featuredProducts;
}

class GetHomeDataUseCase {
  const GetHomeDataUseCase(this._repository);

  final ProductRepository _repository;

  Future<HomeData> call() async {
    final categories = await _repository.getCategories();
    final featured = await _repository.getFeaturedProducts();
    return HomeData(categories: categories, featuredProducts: featured);
  }
}


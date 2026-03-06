import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../cart/presentation/providers/cart_provider.dart';
import '../../../discovery/presentation/providers/favorites_provider.dart';
import '../providers/product_detail_provider.dart';
import '../widgets/product_detail_bottom_bar.dart';
import '../widgets/product_detail_description.dart';
import '../widgets/product_detail_gallery.dart';
import '../widgets/product_detail_info.dart';
import '../widgets/product_detail_quantity_selector.dart';
import '../widgets/product_detail_reviews.dart';
import '../widgets/product_detail_variants.dart';

part 'product_detail_view_state.dart';

/// High-conversion product detail screen: gallery with pinch-zoom, variants,
/// quantity, description accordion, reviews, and sticky Add to Cart / Buy Now.
/// State is managed by [ProductDetailProvider] and [FavoritesProvider].
class ProductDetailView extends StatefulWidget {
  const ProductDetailView({
    super.key,
    required this.productId,
  });

  final String productId;

  @override
  State<ProductDetailView> createState() => ProductDetailViewState();
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../products/domain/entities/product_entity.dart';
import '../../../products/presentation/pages/product_detail_view.dart';
import '../providers/discovery_data_provider.dart';
import '../widgets/sub_category_product_card.dart';

part 'sub_category_page_state.dart';

/// Sub-category view: product grid for a given category.
/// Data and loading from [DiscoveryDataProvider]; no business logic in widget.
class SubCategoryPage extends StatefulWidget {
  const SubCategoryPage({
    super.key,
    required this.categoryId,
    required this.categoryName,
  });

  final String categoryId;
  final String categoryName;

  @override
  State<SubCategoryPage> createState() => SubCategoryPageState();
}

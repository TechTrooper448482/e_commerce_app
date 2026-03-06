import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/app_constants.dart';
import '../providers/discovery_data_provider.dart';
import '../widgets/category_list_tile.dart';
import 'sub_category_page.dart';

part 'category_list_page_state.dart';

/// Main category list with high-quality background images.
/// Data and loading from [DiscoveryDataProvider]; no business logic in widget.
class CategoryListPage extends StatefulWidget {
  const CategoryListPage({super.key});

  @override
  State<CategoryListPage> createState() => CategoryListPageState();
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../products/domain/entities/product_entity.dart';
import '../../../products/presentation/pages/product_detail_page.dart';
import '../../domain/repositories/discovery_repository.dart';
import '../providers/search_filter_provider.dart';
import '../widgets/search_filter_product_card.dart';
import '../widgets/search_filter_sheet.dart';

part 'search_filter_page_state.dart';

/// Search & Filter: active search, recent chips, filter sheet (price, color, size, rating).
/// All search and filter logic is in [SearchFilterProvider]; this widget only displays state.
class SearchFilterPage extends StatefulWidget {
  const SearchFilterPage({super.key});

  @override
  State<SearchFilterPage> createState() => SearchFilterPageState();
}

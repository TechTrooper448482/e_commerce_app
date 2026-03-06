import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/app_constants.dart';
import '../providers/discovery_data_provider.dart';
import '../providers/home_provider.dart';
import '../widgets/discovery_banner_section.dart';
import '../widgets/discovery_categories_section.dart';
import '../widgets/discovery_search_bar.dart';
import '../widgets/discovery_trending_grid.dart';
import 'category_list_page.dart';
import 'search_filter_page.dart';
import 'sub_category_page.dart';

part 'home_view_state.dart';

/// Discovery Home: search bar, auto-scrolling banner, horizontal categories, trending grid.
/// All data and loading logic live in [DiscoveryDataProvider] and [HomeProvider].
class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => HomeViewState();
}

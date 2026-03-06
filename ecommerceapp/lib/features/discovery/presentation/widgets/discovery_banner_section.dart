import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/discovery_data_provider.dart';
import '../providers/home_provider.dart';
import 'discovery_banner_slide.dart';

part 'discovery_banner_section_state.dart';

/// Auto-scrolling banner carousel with dots. Uses [HomeProvider] for index/timer.
class DiscoveryBannerSection extends StatefulWidget {
  const DiscoveryBannerSection({super.key, required this.controller});

  final PageController controller;

  @override
  State<DiscoveryBannerSection> createState() => DiscoveryBannerSectionState();
}

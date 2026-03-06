part of 'home_view.dart';

class HomeViewState extends State<HomeView> {
  late PageController _bannerPageController;

  @override
  void initState() {
    super.initState();
    _bannerPageController = PageController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      context.read<DiscoveryDataProvider>().loadDiscoveryHome();
    });
  }

  @override
  void dispose() {
    _bannerPageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final discovery = context.watch<DiscoveryDataProvider>();
    final home = context.read<HomeProvider>();

    if (discovery.banners.isNotEmpty && home.bannerCount != discovery.banners.length) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) home.updateBannerCount(discovery.banners.length);
      });
    }

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DiscoverySearchBar(onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const SearchFilterPage(),
                        ),
                      );
                    }),
                    const SizedBox(height: 20),
                    DiscoveryBannerSection(controller: _bannerPageController),
                    const SizedBox(height: 24),
                    DiscoveryCategoriesSection(
                      discoveryCategories: discovery.discoveryCategories,
                      onSeeAll: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const CategoryListPage(),
                          ),
                        );
                      },
                      onCategoryTap: (category) {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => SubCategoryPage(
                              categoryId: category.id,
                              categoryName: category.name,
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                    Text(
                      AppConstants.sectionTrending,
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 12),
                  ],
                ),
              ),
            ),
            if (discovery.isLoadingHome)
              const SliverFillRemaining(
                child: Center(child: CircularProgressIndicator()),
              )
            else
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                sliver: DiscoveryTrendingGrid(products: discovery.trendingProducts),
              ),
          ],
        ),
      ),
    );
  }
}

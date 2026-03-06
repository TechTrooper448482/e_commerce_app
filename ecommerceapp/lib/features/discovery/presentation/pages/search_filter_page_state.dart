part of 'search_filter_page.dart';

class SearchFilterPageState extends State<SearchFilterPage> {
  final _focusNode = FocusNode();
  final _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      final repo = context.read<DiscoveryRepository>();
      context.read<SearchFilterProvider>().loadTrendingResults(repo);
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }

  void _onSearchSubmitted(String value) {
    context.read<SearchFilterProvider>().addRecentSearch(value);
    final repo = context.read<DiscoveryRepository>();
    context.read<SearchFilterProvider>().search(repo, value);
  }

  void _showFilterSheet(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const SearchFilterSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final filterProvider = context.watch<SearchFilterProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppConstants.searchTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.tune),
            onPressed: () => _showFilterSheet(context),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _controller,
              focusNode: _focusNode,
              autofocus: true,
              decoration: InputDecoration(
                hintText: AppConstants.searchPlaceholder,
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
              ),
              onSubmitted: _onSearchSubmitted,
            ),
          ),
          if (filterProvider.recentSearches.isNotEmpty) ...[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppConstants.recentSearches,
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  TextButton(
                    onPressed: () => filterProvider.clearRecentSearches(),
                    child: const Text(AppConstants.clear),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 40,
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                scrollDirection: Axis.horizontal,
                itemCount: filterProvider.recentSearches.length,
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  final term = filterProvider.recentSearches[index];
                  return ActionChip(
                    label: Text(term),
                    onPressed: () {
                      _controller.text = term;
                      _onSearchSubmitted(term);
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
          ],
          Expanded(
            child: filterProvider.isSearching
                ? const Center(child: CircularProgressIndicator())
                : _buildProductGrid(filterProvider.filteredSearchResults, theme),
          ),
        ],
      ),
    );
  }

  Widget _buildProductGrid(List<ProductEntity> products, ThemeData theme) {
    if (products.isEmpty) {
      return Center(
        child: Text(
          AppConstants.noProductsMatch,
          style: theme.textTheme.bodyLarge?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
      );
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        const crossAxisCount = 2;
        const spacing = 12.0;
        final width =
            (constraints.maxWidth - spacing) / crossAxisCount;
        final aspectRatio = width / (width * 1.35);

        return GridView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            mainAxisSpacing: spacing,
            crossAxisSpacing: spacing,
            childAspectRatio: aspectRatio,
          ),
          itemCount: products.length,
          itemBuilder: (context, index) {
            final product = products[index];
            return SearchFilterProductCard(
              product: product,
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => ProductDetailPage(productId: product.id),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}

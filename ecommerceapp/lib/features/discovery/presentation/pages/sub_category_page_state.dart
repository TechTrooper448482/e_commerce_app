part of 'sub_category_page.dart';

class SubCategoryPageState extends State<SubCategoryPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      context.read<DiscoveryDataProvider>().loadProductsByCategory(widget.categoryId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final discovery = context.watch<DiscoveryDataProvider>();

    final products = discovery.loadedCategoryId == widget.categoryId
        ? discovery.categoryProducts
        : <ProductEntity>[];
    final loading = discovery.isLoadingCategory && discovery.loadedCategoryId == widget.categoryId;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.categoryName),
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : products.isEmpty
              ? Center(
                  child: Text(
                    AppConstants.noProductsInCategory,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                )
              : LayoutBuilder(
                  builder: (context, constraints) {
                    const crossAxisCount = 2;
                    const spacing = 12.0;
                    final width =
                        (constraints.maxWidth - spacing) / crossAxisCount;
                    final aspectRatio = width / (width * 1.35);

                    return GridView.builder(
                      padding: const EdgeInsets.all(20),
                      gridDelegate:
                          SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount,
                        mainAxisSpacing: spacing,
                        crossAxisSpacing: spacing,
                        childAspectRatio: aspectRatio,
                      ),
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        final product = products[index];
                        return SubCategoryProductCard(
                          product: product,
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => ProductDetailView(
                                  productId: product.id,
                                ),
                              ),
                            );
                          },
                        );
                      },
                    );
                  },
                ),
    );
  }
}

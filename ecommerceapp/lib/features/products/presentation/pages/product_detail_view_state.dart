part of 'product_detail_view.dart';

class ProductDetailViewState extends State<ProductDetailView> {
  late PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      context.read<ProductDetailProvider>().loadProduct(widget.productId);
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _syncFavoriteFromFavorites() {
    final favorites = context.read<FavoritesProvider>();
    final detail = context.read<ProductDetailProvider>();
    if (detail.product != null) {
      detail.syncFavoriteFrom(favorites.isFavorite(detail.product!.id));
    }
  }

  @override
  Widget build(BuildContext context) {
    final detail = context.watch<ProductDetailProvider>();
    final favorites = context.read<FavoritesProvider>();
    final cart = context.read<CartProvider>();

    if (detail.isLoading) {
      return Scaffold(
        appBar: AppBar(title: const Text('Product')),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    if (detail.errorMessage != null || detail.product == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Product')),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Text(
              detail.errorMessage ?? 'Product not found',
              textAlign: TextAlign.center,
            ),
          ),
        ),
      );
    }

    final product = detail.product!;

    if (detail.isFavorite != favorites.isFavorite(product.id)) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _syncFavoriteFromFavorites());
    }

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: MediaQuery.of(context).size.height * 0.45,
            pinned: true,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.of(context).pop(),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: ProductDetailGallery(
                images: product.imageUrls,
                pageController: _pageController,
                currentPage: _currentPage,
                onPageChanged: (i) => setState(() => _currentPage = i),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SafeArea(
              top: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ProductDetailInfo(product: product),
                    const SizedBox(height: 24),
                    ProductDetailVariants(
                      product: product,
                      selectedColor: detail.selectedColor,
                      selectedSize: detail.selectedSize,
                      onColorSelected: detail.setSelectedColor,
                      onSizeSelected: detail.setSelectedSize,
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Quantity',
                          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        ProductDetailQuantitySelector(
                          quantity: detail.quantity,
                          onDecrement: detail.decrementQuantity,
                          onIncrement: detail.incrementQuantity,
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    const Divider(),
                    const SizedBox(height: 8),
                    ProductDetailDescription(product: product),
                    const SizedBox(height: 24),
                    if (product.reviews != null ||
                        (product.reviewCount != null && product.reviewCount! > 0)) ...[
                      Text(
                        'Reviews & Rating',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 12),
                      ProductDetailReviews(product: product),
                    ],
                    const SizedBox(height: 100),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: ProductDetailBottomBar(
        product: product,
        quantity: detail.quantity,
        isFavorite: detail.isFavorite,
        onToggleFavorite: () {
          detail.toggleFavorite();
          favorites.toggle(product.id);
        },
        onAddToCart: () {
          for (var i = 0; i < detail.quantity; i++) {
            cart.addToCart(product);
          }
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Added to cart')),
          );
        },
        onBuyNow: () {
          for (var i = 0; i < detail.quantity; i++) {
            cart.addToCart(product);
          }
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Proceeding to checkout...')),
          );
        },
      ),
    );
  }
}

part of 'category_list_page.dart';

class CategoryListPageState extends State<CategoryListPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      final discovery = context.read<DiscoveryDataProvider>();
      if (discovery.discoveryCategories.isEmpty && !discovery.isLoadingHome) {
        discovery.loadDiscoveryHome();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final discovery = context.watch<DiscoveryDataProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppConstants.categoriesTitle),
      ),
      body: discovery.isLoadingHome
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              itemCount: discovery.discoveryCategories.length,
              itemBuilder: (context, index) {
                final dc = discovery.discoveryCategories[index];
                final cat = dc.category;
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: CategoryListTile(
                    imageUrl: dc.imageUrl,
                    label: cat.name,
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => SubCategoryPage(
                            categoryId: cat.id,
                            categoryName: cat.name,
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}

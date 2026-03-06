import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/services/mock_product_service.dart';
import 'sub_category_page.dart';

/// Main category list with high-quality background images.
/// Tapping a category navigates to [SubCategoryPage].
class CategoryListPage extends StatefulWidget {
  const CategoryListPage({super.key});

  @override
  State<CategoryListPage> createState() => _CategoryListPageState();
}

class _CategoryListPageState extends State<CategoryListPage> {
  List<DiscoveryCategory> _categories = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final service = context.read<MockProductService>();
    final list = await service.getDiscoveryCategories();
    if (!mounted) return;
    setState(() {
      _categories = list;
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Categories'),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              itemCount: _categories.length,
              itemBuilder: (context, index) {
                final dc = _categories[index];
                final cat = dc.entity;
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: _CategoryTile(
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

class _CategoryTile extends StatelessWidget {
  const _CategoryTile({
    required this.imageUrl,
    required this.label,
    required this.onTap,
  });

  final String imageUrl;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Material(
      borderRadius: BorderRadius.circular(16),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: SizedBox(
          height: 140,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.network(
                imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  color: theme.colorScheme.surfaceContainerHighest,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.6),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 20,
                right: 20,
                bottom: 16,
                child: Text(
                  label,
                  style: theme.textTheme.titleLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    shadows: [
                      Shadow(
                        color: Colors.black54,
                        offset: const Offset(0, 1),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../products/domain/entities/category_entity.dart';
import '../../domain/entities/discovery_category_entity.dart';
import 'discovery_category_chip.dart';
import 'discovery_category_icon.dart';

/// Horizontal categories list with "See all" for discovery home.
class DiscoveryCategoriesSection extends StatelessWidget {
  const DiscoveryCategoriesSection({
    super.key,
    required this.discoveryCategories,
    required this.onSeeAll,
    required this.onCategoryTap,
  });

  final List<DiscoveryCategoryEntity> discoveryCategories;
  final VoidCallback onSeeAll;
  final void Function(CategoryEntity) onCategoryTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              AppConstants.sectionCategories,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            TextButton(
              onPressed: onSeeAll,
              child: const Text(AppConstants.seeAll),
            ),
          ],
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 88,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: discoveryCategories.length,
            itemBuilder: (context, index) {
              final dc = discoveryCategories[index];
              final cat = dc.category;
              return Padding(
                padding: const EdgeInsets.only(right: 16),
                child: DiscoveryCategoryChip(
                  label: cat.name,
                  icon: DiscoveryCategoryIcon.forName(cat.icon),
                  onTap: () => onCategoryTap(cat),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

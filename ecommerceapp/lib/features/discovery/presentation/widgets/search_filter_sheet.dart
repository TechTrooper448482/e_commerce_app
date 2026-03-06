import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/filter_color_util.dart';
import '../providers/search_filter_provider.dart';

/// Bottom sheet for price, color, size, and rating filters.
class SearchFilterSheet extends StatelessWidget {
  const SearchFilterSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return DraggableScrollableSheet(
      initialChildSize: 0.5,
      minChildSize: 0.3,
      maxChildSize: 0.9,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Consumer<SearchFilterProvider>(
            builder: (context, provider, _) {
              return ListView(
                controller: scrollController,
                padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        AppConstants.filters,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    AppConstants.priceRange,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  RangeSlider(
                    values: provider.priceRange,
                    min: 0,
                    max: 500,
                    divisions: 50,
                    onChanged: provider.setPriceRange,
                  ),
                  Text(
                    '\$${provider.priceRange.start.toStringAsFixed(0)} - \$${provider.priceRange.end.toStringAsFixed(0)}',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    AppConstants.color,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 12,
                    runSpacing: 8,
                    children: SearchFilterProvider.colorOptions.map((color) {
                      final isSelected = provider.selectedColors.contains(color);
                      return GestureDetector(
                        onTap: () => provider.toggleColor(color),
                        child: Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: colorFromFilterName(color),
                            border: Border.all(
                              color: isSelected
                                  ? Theme.of(context).colorScheme.primary
                                  : Colors.transparent,
                              width: 3,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    AppConstants.size,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    children: SearchFilterProvider.sizeOptions.map((size) {
                      return FilterChip(
                        label: Text(size),
                        selected: provider.selectedSizes.contains(size),
                        onSelected: (_) => provider.toggleSize(size),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    AppConstants.minimumRating,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: List.generate(5, (i) {
                      final star = i + 1;
                      final selected = provider.minRating >= star;
                      return Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: ChoiceChip(
                          label: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.star,
                                size: 18,
                                color: selected
                                    ? Colors.amber
                                    : Theme.of(context).colorScheme.onSurfaceVariant,
                              ),
                              const SizedBox(width: 4),
                              Text('$star'),
                            ],
                          ),
                          selected: provider.minRating == star,
                          onSelected: (_) => provider.setMinRating(selected ? 0 : star),
                        ),
                      );
                    }),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      OutlinedButton(
                        onPressed: provider.clearFilters,
                        style: OutlinedButton.styleFrom(
                          shape: const StadiumBorder(),
                        ),
                        child: const Text(AppConstants.clear),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: FilledButton(
                          onPressed: () => Navigator.of(context).pop(),
                          style: FilledButton.styleFrom(
                            shape: const StadiumBorder(),
                          ),
                          child: const Text(AppConstants.apply),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}

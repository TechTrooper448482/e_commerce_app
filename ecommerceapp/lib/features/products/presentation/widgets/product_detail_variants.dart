import 'package:flutter/material.dart';

import '../../../../core/theme/filter_color_util.dart';
import '../../domain/entities/product_entity.dart';

/// Color swatches and size ChoiceChips. Uses [ProductDetailProvider] state via callbacks.
class ProductDetailVariants extends StatelessWidget {
  const ProductDetailVariants({
    super.key,
    required this.product,
    required this.selectedColor,
    required this.selectedSize,
    required this.onColorSelected,
    required this.onSizeSelected,
  });

  final ProductEntity product;
  final String? selectedColor;
  final String? selectedSize;
  final ValueChanged<String?> onColorSelected;
  final ValueChanged<String?> onSizeSelected;

  static const double _tapTargetMin = 48;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (product.colorOptions != null && product.colorOptions!.isNotEmpty) ...[
          Text(
            'Color',
            style: theme.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: _tapTargetMin,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: product.colorOptions!.length,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (context, index) {
                final colorName = product.colorOptions![index];
                final isSelected = selectedColor == colorName;
                final color = colorFromFilterName(colorName);

                return GestureDetector(
                  onTap: () => onColorSelected(colorName),
                  behavior: HitTestBehavior.opaque,
                  child: SizedBox(
                    width: _tapTargetMin,
                    height: _tapTargetMin,
                    child: Center(
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: color,
                          border: Border.all(
                            color: isSelected
                                ? theme.colorScheme.primary
                                : theme.colorScheme.outline.withValues(alpha: 0.3),
                            width: isSelected ? 3 : 1,
                          ),
                          boxShadow: color == Colors.white || color == Colors.grey
                              ? [
                                  BoxShadow(
                                    color: theme.colorScheme.shadow.withValues(alpha: 0.2),
                                    blurRadius: 4,
                                    offset: const Offset(0, 2),
                                  ),
                                ]
                              : null,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 20),
        ],
        if (product.sizeOptions != null && product.sizeOptions!.isNotEmpty) ...[
          Text(
            'Size',
            style: theme.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: product.sizeOptions!.map((size) {
              final isSelected = selectedSize == size;
              return ConstrainedBox(
                constraints: const BoxConstraints(minWidth: 48, minHeight: 48),
                child: ChoiceChip(
                  label: Text(size),
                  selected: isSelected,
                  onSelected: (_) => onSizeSelected(size),
                  selectedColor: theme.colorScheme.primaryContainer,
                ),
              );
            }).toList(),
          ),
        ],
      ],
    );
  }
}

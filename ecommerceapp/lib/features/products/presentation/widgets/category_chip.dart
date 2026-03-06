import 'package:flutter/material.dart';

import '../../domain/entities/category_entity.dart';

class CategoryChip extends StatelessWidget {
  const CategoryChip({
    super.key,
    required this.category,
    required this.isSelected,
    required this.onSelected,
  });

  final CategoryEntity category;
  final bool isSelected;
  final VoidCallback onSelected;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ChoiceChip(
      label: Text(category.name),
      selected: isSelected,
      onSelected: (_) => onSelected(),
      backgroundColor: Colors.white,
      selectedColor: theme.colorScheme.primary,
      labelStyle: theme.textTheme.bodyMedium?.copyWith(
        fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
        color: isSelected ? Colors.white : Colors.black,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
        side: BorderSide(
          color: isSelected
              ? Colors.transparent
              : theme.colorScheme.onSurface.withOpacity(0.06),
        ),
      ),
    );
  }
}


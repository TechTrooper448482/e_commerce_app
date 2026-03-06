import 'package:flutter/material.dart';

/// Quantity selector with [-] [value] [+]. Min tap target 48x48.
class ProductDetailQuantitySelector extends StatelessWidget {
  const ProductDetailQuantitySelector({
    super.key,
    required this.quantity,
    required this.onDecrement,
    required this.onIncrement,
  });

  final int quantity;
  final VoidCallback onDecrement;
  final VoidCallback onIncrement;

  static const double _minTapTarget = 48;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _MinTapInkWell(
          onTap: onDecrement,
          child: Container(
            width: _minTapTarget,
            height: _minTapTarget,
            decoration: BoxDecoration(
              border: Border.all(color: theme.colorScheme.outline),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              Icons.remove,
              color: theme.colorScheme.onSurface,
            ),
          ),
        ),
        SizedBox(
          width: 48,
          child: Center(
            child: Text(
              '$quantity',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
        _MinTapInkWell(
          onTap: onIncrement,
          child: Container(
            width: _minTapTarget,
            height: _minTapTarget,
            decoration: BoxDecoration(
              border: Border.all(color: theme.colorScheme.outline),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              Icons.add,
              color: theme.colorScheme.onSurface,
            ),
          ),
        ),
      ],
    );
  }
}

class _MinTapInkWell extends StatelessWidget {
  const _MinTapInkWell({
    required this.onTap,
    required this.child,
  });

  final VoidCallback onTap;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: child,
      ),
    );
  }
}

import 'package:flutter/material.dart';

/// Circular +/- quantity button for cart item tile.
class CartQuantityButton extends StatelessWidget {
  const CartQuantityButton({
    super.key,
    required this.icon,
    this.onPressed,
  });

  final IconData icon;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final enabled = onPressed != null;
    return Material(
      color: enabled ? const Color(0xFF0054F6) : Colors.grey.shade300,
      shape: const CircleBorder(),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onPressed,
        customBorder: const CircleBorder(),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Icon(
            icon,
            color: enabled ? Colors.white : Colors.white70,
            size: 18,
          ),
        ),
      ),
    );
  }
}

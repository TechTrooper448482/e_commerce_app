import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isPrimary = true,
    this.isLoading = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool isPrimary;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final buttonChild = isLoading
        ? SizedBox(
            height: 18,
            width: 18,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(
                isPrimary
                    ? theme.colorScheme.onPrimary
                    : theme.colorScheme.primary,
              ),
            ),
          )
        : Text(
            label,
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          );

    final shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(999),
    );

    final padding = const EdgeInsets.symmetric(
      horizontal: 20,
      vertical: 12,
    );

    if (isPrimary) {
      return SizedBox(
        width: double.infinity,
        child: FilledButton(
          onPressed: isLoading ? null : onPressed,
          style: FilledButton.styleFrom(
            shape: shape,
            padding: padding,
          ),
          child: buttonChild,
        ),
      );
    }

    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        onPressed: isLoading ? null : onPressed,
        style: OutlinedButton.styleFrom(
          shape: shape,
          padding: padding,
        ),
        child: buttonChild,
      ),
    );
  }
}

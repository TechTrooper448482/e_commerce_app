import 'package:flutter/material.dart';

/// Central palette for feature-specific colors (discovery, auth, cart).
/// Use these instead of hardcoding hex in widgets. Prefer Theme.of(context)
/// when the theme already exposes the color (e.g. primary, error).
class AppColors {
  AppColors._();

  // Discovery & shared accent (e.g. banners, CTAs)
  static const Color discoveryPrimary = Color(0xFF0054F6);
  static const Color discoveryPrimaryLight = Color(0xFFE4ECFF);
  static const Color discoveryBackgroundTint = Color(0xFFEAF1FF);
  static const Color discoveryDotInactive = Color(0xFFD8DEEA);

  // Auth flow
  static const Color authAvatarRing = Color(0xFFFF6EC7);
  static const Color authCardPink = Color(0xFFFF7FA8);
  static const Color authPastelBlue = Color(0xFFB8E0F0);
  static const Color authPastelPink = Color(0xFFFFB6C1);

  // Cart & product
  static const Color cartRemoveIcon = Color(0xFFB3261E);
  static const Color cartQuantityBg = Color(0xFFE8ECF4);
  static const Color cartScaffoldBg = Color(0xFFF5F6FA);
  static const Color productDiscountBadge = Color(0xFFFF4D67);

  // Filter / UI
  static const Color filterBeige = Color(0xFFF5F5DC);
}

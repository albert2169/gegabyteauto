import 'package:flutter/material.dart';

abstract final class AppColors {
  // Backgrounds
  static const Color background = Color(0xFF0A0A0E);
  static const Color surface = Color(0xFF13131A);
  static const Color surfaceVariant = Color(0xFF1C1C26);
  static const Color cardBackground = Color(0xFF1A1A24);

  // Accent / Blue
  static const Color primary = Color(0xFF355AFA);
  static const Color primaryLight = Color(0xFF6B85FC);
  static const Color primaryDark = Color(0xFF1A3DD8);

  // Text
  static const Color textPrimary = Color(0xFFF0F0F5);
  static const Color textSecondary = Color(0xFF9090A0);
  static const Color textHint = Color(0xFF5A5A6A);

  // Status
  static const Color error = Color(0xFFCF6679);
  static const Color success = Color(0xFF4CAF7D);

  // Borders / dividers
  static const Color border = Color(0xFF2A2A36);
  static const Color divider = Color(0xFF1E1E2A);

  // Gradients
  static const Gradient primaryGradient = LinearGradient(
    colors: [Color(0xFF355AFA), Color(0xFF1A3DD8)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  static const Gradient secondaryGradient = LinearGradient(
    colors: [
      Color(0xFF34C759),
      Color(0xFF28A745),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const Gradient darkBackgroundGradient = LinearGradient(
    colors: [Color(0xFF0A0A0E), Color(0xFF13131A), Color(0xFF0A0A0E)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const Gradient goldShimmerGradient = LinearGradient(
    colors: [Color(0xFF1A3DD8), Color(0xFF6B85FC), Color(0xFF1A3DD8)],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );
}

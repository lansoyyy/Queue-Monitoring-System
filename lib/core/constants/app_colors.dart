import 'package:flutter/material.dart';

/// App Colors for Queue Monitoring System — Healthcare Green Palette
class AppColors {
  // Primary Green Colors
  static const Color primary = Color(0xFF1E7B3E);        // Deep healthcare green
  static const Color primaryDark = Color(0xFF145529);    // Darker for pressed states
  static const Color primaryLight = Color(0xFF2EA055);   // Lighter variant
  static const Color primaryMedium = Color(0xFF27AE60);  // Medium green for highlights

  // Secondary Colors
  static const Color secondary = Color(0xFF2ECC71);
  static const Color secondaryDark = Color(0xFF1E8449);
  static const Color secondaryLight = Color(0xFF58D68D);

  // Background Colors
  static const Color background = Color(0xFFFFFFFF);
  static const Color backgroundDark = Color(0xFFF9FAFB);
  static const Color backgroundLight = Color(0xFFF3F4F6);
  static const Color backgroundCard = Color(0xFFFFFFFF);

  // Text Colors
  static const Color textPrimary = Color(0xFF111827);
  static const Color textSecondary = Color(0xFF6B7280);
  static const Color textTertiary = Color(0xFF9CA3AF);
  static const Color textDisabled = Color(0xFFD1D5DB);
  static const Color textWhite = Color(0xFFFFFFFF);

  // Border Colors
  static const Color border = Color(0xFFE5E7EB);
  static const Color borderDark = Color(0xFFD1D5DB);
  static const Color borderLight = Color(0xFFF3F4F6);

  // Status Colors
  static const Color success = Color(0xFF10B981);
  static const Color successLight = Color(0xFFD1FAE5);
  static const Color warning = Color(0xFFF59E0B);
  static const Color warningLight = Color(0xFFFEF3C7);
  static const Color error = Color(0xFFEF4444);
  static const Color errorLight = Color(0xFFFEE2E2);
  static const Color info = Color(0xFF3B82F6);
  static const Color infoLight = Color(0xFFDBEAFE);

  // Queue Status Colors
  static const Color queueWaiting = Color(0xFFF59E0B);
  static const Color queueProcessing = Color(0xFF3B82F6);
  static const Color queueCompleted = Color(0xFF10B981);
  static const Color queueCancelled = Color(0xFFEF4444);
  static const Color queueSkipped = Color(0xFF6B7280);

  // Tile Colors (for service tiles)
  static const Color tileActive = Color(0xFF1E7B3E);       // Active service tile
  static const Color tileInactive = Color(0xFFA8D5B5);     // Inactive tile (light green)
  static const Color tileUnavailable = Color(0xFFD6EFE0);  // Unavailable (very faded)
  static const Color sidebarBg = Color(0xFFF0FAF4);        // Sidebar background
  static const Color sidebarSelected = Color(0xFF1E7B3E);  // Selected sidebar item

  // Shadow Colors
  static const Color shadow = Color(0x1A000000);
  static const Color shadowLight = Color(0x0D000000);

  // Overlay Colors
  static const Color overlay = Color(0x80000000);
  static const Color overlayLight = Color(0x40000000);

  // Gradient Colors
  static const List<Color> primaryGradient = [
    Color(0xFF1E7B3E),
    Color(0xFF145529),
  ];

  static const List<Color> welcomeGradient = [
    Color(0xFF1E7B3E),
    Color(0xFF27AE60),
  ];

  // Special Colors
  static const Color transparent = Color(0x00000000);
  static const Color divider = Color(0xFFE5E7EB);
}

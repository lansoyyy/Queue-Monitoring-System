import 'package:flutter/material.dart';

/// App Constants for Queue Monitoring System
class AppConstants {
  AppConstants._();

  // ==================== APP INFO ====================

  static const String appName = 'Queue Monitoring System';
  static const String appVersion = '1.0.0';
  static const String appBuildNumber = '1';

  // ==================== DIMENSIONS ====================

  // Padding
  static const double paddingXS = 4.0;
  static const double paddingS = 8.0;
  static const double paddingM = 16.0;
  static const double paddingL = 24.0;
  static const double paddingXL = 32.0;
  static const double paddingXXL = 48.0;

  // Border Radius
  static const double radiusXS = 4.0;
  static const double radiusS = 8.0;
  static const double radiusM = 12.0;
  static const double radiusL = 16.0;
  static const double radiusXL = 20.0;
  static const double radiusXXL = 24.0;
  static const double radiusCircle = 999.0;

  // Icon Sizes
  static const double iconXS = 16.0;
  static const double iconS = 20.0;
  static const double iconM = 24.0;
  static const double iconL = 32.0;
  static const double iconXL = 48.0;
  static const double iconXXL = 64.0;

  // Avatar Sizes
  static const double avatarXS = 24.0;
  static const double avatarS = 32.0;
  static const double avatarM = 40.0;
  static const double avatarL = 56.0;
  static const double avatarXL = 80.0;

  // ==================== DURATIONS ====================

  static const Duration durationFast = Duration(milliseconds: 150);
  static const Duration durationNormal = Duration(milliseconds: 300);
  static const Duration durationSlow = Duration(milliseconds: 500);
  static const Duration durationSlower = Duration(milliseconds: 800);

  // ==================== ANIMATION CURVES ====================

  static const Curve curveEaseIn = Curves.easeIn;
  static const Curve curveEaseOut = Curves.easeOut;
  static const Curve curveEaseInOut = Curves.easeInOut;
  static const Curve curveFastOutSlowIn = Curves.fastOutSlowIn;
  static const Curve curveBounceIn = Curves.bounceIn;
  static const Curve curveBounceOut = Curves.bounceOut;

  // ==================== QUEUE SPECIFIC ====================

  // Queue Status
  static const String queueStatusWaiting = 'waiting';
  static const String queueStatusProcessing = 'processing';
  static const String queueStatusCompleted = 'completed';
  static const String queueStatusCancelled = 'cancelled';
  static const String queueStatusSkipped = 'skipped';

  // Queue Priorities
  static const String priorityLow = 'low';
  static const String priorityNormal = 'normal';
  static const String priorityHigh = 'high';
  static const String priorityUrgent = 'urgent';

  // ==================== STORAGE KEYS ====================

  static const String keyIsLoggedIn = 'is_logged_in';
  static const String keyAuthToken = 'auth_token';
  static const String keyUserId = 'user_id';
  static const String keyUserName = 'user_name';
  static const String keyUserEmail = 'user_email';
  static const String keyThemeMode = 'theme_mode';
  static const String keyLanguage = 'language';
  static const String keyNotificationsEnabled = 'notifications_enabled';

  // ==================== API ====================

  static const int apiTimeout = 30000; // 30 seconds
  static const int apiRetryCount = 3;
  static const int apiRetryDelay = 1000; // 1 second

  // ==================== VALIDATION ====================

  // Email validation regex
  static final RegExp emailRegex = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );

  // Phone validation regex (international format)
  static final RegExp phoneRegex = RegExp(r'^\+?[1-9]\d{1,14}$');

  // Password requirements
  static const int passwordMinLength = 8;
  static const int passwordMaxLength = 128;
  static const bool passwordRequireUppercase = true;
  static const bool passwordRequireLowercase = true;
  static const bool passwordRequireNumber = true;
  static const bool passwordRequireSpecialChar = true;

  // ==================== PAGINATION ====================

  static const int defaultPageSize = 20;
  static const int maxPageSize = 100;

  // ==================== DATE & TIME ====================

  static const String dateFormatDisplay = 'MMM dd, yyyy';
  static const String dateFormatShort = 'MM/dd/yyyy';
  static const String dateFormatInput = 'yyyy-MM-dd';
  static const String timeFormatDisplay = 'hh:mm a';
  static const String timeFormatShort = 'HH:mm';
  static const String dateTimeFormatDisplay = 'MMM dd, yyyy hh:mm a';
  static const String dateTimeFormatShort = 'MM/dd/yyyy HH:mm';

  // ==================== SCREEN SIZES ====================

  // Breakpoints for responsive design
  static const double breakpointMobile = 600.0;
  static const double breakpointTablet = 900.0;
  static const double breakpointDesktop = 1200.0;

  // ==================== OTHER ====================

  static const int maxRetryAttempts = 3;
  static const double defaultElevation = 2.0;
  static const double defaultOpacity = 0.7;
}

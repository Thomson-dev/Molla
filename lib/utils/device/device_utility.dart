import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:flutter/foundation.dart';

/// Utility class for device-related operations
class TDeviceUtils {
  /// Hide keyboard
  static void hideKeyboard(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  /// Set status bar color
  static Future<void> setStatusBarColor(Color color) async {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: color),
    );
  }

  /// Check if device is in landscape orientation
  static bool isLandscapeOrientation(BuildContext context) {
    final view = View.of(context);
    return view.viewInsets.bottom == 0;
  }

  /// Check if device is in portrait orientation
  static bool isPortraitOrientation(BuildContext context) {
    final view = View.of(context);
    return view.viewInsets.bottom != 0;
  }

  /// Get device screen size
  static Size getScreenSize(BuildContext context) {
    return MediaQuery.of(context).size;
  }

  /// Get device screen width
  static double getScreenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  /// Get device screen height
  static double getScreenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  /// Get device pixel ratio
  static double getPixelRatio(BuildContext context) {
    return MediaQuery.of(context).devicePixelRatio;
  }

  /// Get device text scale factor
  static double getTextScaleFactor(BuildContext context) {
    return MediaQuery.of(context).textScaleFactor;
  }

  /// Check if device has notch
  static bool hasNotch(BuildContext context) {
    final padding = MediaQuery.of(context).padding;
    return padding.top > 24 || padding.bottom > 0;
  }

  /// Get safe area padding
  static EdgeInsets getSafeAreaPadding(BuildContext context) {
    return MediaQuery.of(context).padding;
  }

  /// Get status bar height
  static double getStatusBarHeight(BuildContext context) {
    return MediaQuery.of(context).padding.top;
  }

  /// Get bottom navigation bar height
  static double getBottomNavBarHeight(BuildContext context) {
    return MediaQuery.of(context).padding.bottom;
  }

  /// Check if device is tablet
  static bool isTablet(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return size.width > 600;
  }

  /// Check if device is phone
  static bool isPhone(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return size.width <= 600;
  }

  /// Check if device is desktop
  static bool isDesktop(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return size.width > 1200;
  }

  /// Get device platform
  static bool get isAndroid => Platform.isAndroid;
  static bool get isIOS => Platform.isIOS;
  static bool get isWindows => Platform.isWindows;
  static bool get isMacOS => Platform.isMacOS;
  static bool get isLinux => Platform.isLinux;
  static bool get isWeb => kIsWeb;

  /// Get AppBar height
  static double getAppBarHeight() {
    return kToolbarHeight;
  }

  static double getBottomNavigationBarHeight(BuildContext context) {
    return MediaQuery.of(context).viewPadding.bottom;
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SettingsController extends GetxController {
  static SettingsController get instance => Get.find();

  // Storage instance
  final _storage = GetStorage();

  // Observable variables
  final _themeMode = ThemeMode.system.obs;
  final _isNotificationEnabled = true.obs;

  // Getters
  bool get isDarkMode {
    if (_themeMode.value == ThemeMode.system) {
      // Check system theme
      return WidgetsBinding.instance.platformDispatcher.platformBrightness ==
          Brightness.dark;
    }
    return _themeMode.value == ThemeMode.dark;
  }

  bool get isNotificationEnabled => _isNotificationEnabled.value;

  @override
  void onInit() {
    super.onInit();
    loadSettings();
  }

  // Load saved settings
  void loadSettings() {
    try {
      // Load theme settings
      final themeModeIndex = _storage.read<int>('themeMode');
      if (themeModeIndex != null) {
        _themeMode.value = ThemeMode.values[themeModeIndex];
      }

      // Load notification settings
      _isNotificationEnabled.value =
          _storage.read<bool>('notifications') ?? true;

      // Apply theme
      Get.changeThemeMode(_themeMode.value);
    } catch (e) {
      debugPrint('Error loading settings: $e');
    }
  }

  // Toggle between light and dark theme
  void toggleThemeMode() {
    // Current state
    final currentMode = _themeMode.value;
    final currentIsDark = isDarkMode;

    // Determine new theme
    if (currentMode == ThemeMode.system) {
      // If system, switch to explicit dark/light opposite of current system
      _themeMode.value = currentIsDark ? ThemeMode.light : ThemeMode.dark;
    } else {
      // Toggle between dark and light
      _themeMode.value =
          currentMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    }

    // Apply theme change to GetX
    Get.changeThemeMode(_themeMode.value);

    // Save setting
    _storage.write('themeMode', _themeMode.value.index);
  }

  // Toggle notifications
  void toggleNotifications() {
    _isNotificationEnabled.toggle();
    _storage.write('notifications', _isNotificationEnabled.value);
  }
}

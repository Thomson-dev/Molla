import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'dart:math';

class THelperFunctions {
  /// Define your product specific colors here and it will match the attribute colors and show specific
  static Color? getColor(String value) {
    if (value == 'Green') {
      return Colors.green;
    } else if (value == 'Red') {
      return Colors.red;
    } else if (value == 'Blue') {
      return Colors.blue;
    } else if (value == 'Pink') {
      return Colors.pink;
    } else if (value == 'Grey') {
      return Colors.grey;
    } else if (value == 'Purple') {
      return Colors.purple;
    } else if (value == 'Black') {
      return Colors.black;
    } else if (value == 'White') {
      return Colors.white;
    } else if (value == 'Yellow') {
      return Colors.yellow;
    } else if (value == 'Orange') {
      return Colors.orange;
    } else if (value == 'Brown') {
      return Colors.brown;
    } else if (value == 'Cyan') {
      return Colors.cyan;
    } else if (value == 'Teal') {
      return Colors.teal;
    } else if (value == 'Indigo') {
      return Colors.indigo;
    } else if (value == 'Amber') {
      return Colors.amber;
    } else if (value == 'DeepPurple') {
      return Colors.deepPurple;
    } else if (value == 'LightBlue') {
      return Colors.lightBlue;
    } else if (value == 'LightGreen') {
      return Colors.lightGreen;
    } else if (value == 'Lime') {
      return Colors.lime;
    } else if (value == 'DeepOrange') {
      return Colors.deepOrange;
    }
    return null;
  }

  /// Show a custom snack bar
  static void showSnackBar({
    required String title,
    required String message,
    Color backgroundColor = Colors.black87,
    Color textColor = Colors.white,
    Duration duration = const Duration(seconds: 3),
    SnackPosition position = SnackPosition.BOTTOM,
  }) {
    Get.snackbar(
      title,
      message,
      backgroundColor: backgroundColor,
      colorText: textColor,
      duration: duration,
      snackPosition: position,
      margin: const EdgeInsets.all(10),
      borderRadius: 8,
      isDismissible: true,
      dismissDirection: DismissDirection.horizontal,
    );
  }

  /// Show a success snack bar
  static void showSuccessSnackBar({
    required String message,
    String title = 'Success',
  }) {
    showSnackBar(
      title: title,
      message: message,
      backgroundColor: Colors.green,
      textColor: Colors.white,
    );
  }

  /// Show an error snack bar
  static void showErrorSnackBar({
    required String message,
    String title = 'Error',
  }) {
    showSnackBar(
      title: title,
      message: message,
      backgroundColor: Colors.red,
      textColor: Colors.white,
    );
  }

  /// Show a warning snack bar
  static void showWarningSnackBar({
    required String message,
    String title = 'Warning',
  }) {
    showSnackBar(
      title: title,
      message: message,
      backgroundColor: Colors.orange,
      textColor: Colors.white,
    );
  }

  /// Show an info snack bar
  static void showInfoSnackBar({
    required String message,
    String title = 'Info',
  }) {
    showSnackBar(
      title: title,
      message: message,
      backgroundColor: Colors.blue,
      textColor: Colors.white,
    );
  }

  /// Get initials from name
  static String getInitials(String name) {
    if (name.isEmpty) return '';

    List<String> nameParts = name.trim().split(' ');
    if (nameParts.length == 1) {
      return nameParts[0].substring(0, 1).toUpperCase();
    } else if (nameParts.length >= 2) {
      return '${nameParts[0].substring(0, 1)}${nameParts[1].substring(0, 1)}'
          .toUpperCase();
    }
    return '';
  }

  /// Format file size
  static String formatFileSize(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    if (bytes < 1024 * 1024 * 1024)
      return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
    return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(1)} GB';
  }

  /// Check if string is valid email
  static bool isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  /// Check if string is valid phone number
  static bool isValidPhoneNumber(String phone) {
    return RegExp(r'^\+?[\d\s-\(\)]{10,}$').hasMatch(phone);
  }

  /// Check if string is valid password
  static bool isValidPassword(String password) {
    // At least 8 characters, 1 uppercase, 1 lowercase, 1 number
    return RegExp(
      r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d@$!%*?&]{8,}$',
    ).hasMatch(password);
  }

  /// Generate random string
  static String generateRandomString(int length) {
    const chars =
        'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    Random random = Random();
    return String.fromCharCodes(
      Iterable.generate(
        length,
        (_) => chars.codeUnitAt(random.nextInt(chars.length)),
      ),
    );
  }

  /// Capitalize first letter of each word
  static String capitalizeWords(String text) {
    if (text.isEmpty) return text;

    return text
        .split(' ')
        .map((word) {
          if (word.isEmpty) return word;
          return word[0].toUpperCase() + word.substring(1).toLowerCase();
        })
        .join(' ');
  }

  /// Truncate text with ellipsis
  static String truncateText(String text, int maxLength) {
    if (text.length <= maxLength) return text;
    return '${text.substring(0, maxLength)}...';
  }

  /// Check if device is in dark mode
  static bool isDarkMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  /// Get responsive font size
  static double getResponsiveFontSize(BuildContext context, double baseSize) {
    double screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth < 600) {
      return baseSize * 0.8; // Mobile
    } else if (screenWidth < 1200) {
      return baseSize * 1.0; // Tablet
    } else {
      return baseSize * 1.2; // Desktop
    }
  }

  /// Get responsive padding
  static EdgeInsets getResponsivePadding(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth < 600) {
      return const EdgeInsets.all(16.0); // Mobile
    } else if (screenWidth < 1200) {
      return const EdgeInsets.all(24.0); // Tablet
    } else {
      return const EdgeInsets.all(32.0); // Desktop
    }
  }

  static double screenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double screenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }
}

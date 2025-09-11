import 'package:flutter/material.dart';

class TElevatedButtonTheme {
  TElevatedButtonTheme._(); // avoid creating instances

  static const Color _primaryBlue = Color(0xFF1565C0); // Professional blue
  static const Color _disabledGrey = Color(0xFFBDBDBD);

  /// Light Theme
  static final lightElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      foregroundColor: Colors.white,
      backgroundColor: _primaryBlue,
      disabledForegroundColor: Colors.white,
      disabledBackgroundColor: _disabledGrey,
      side: const BorderSide(color: _primaryBlue),
      padding: const EdgeInsets.symmetric(vertical: 15),
      textStyle: const TextStyle(
        fontSize: 16,
        color: Colors.white,
        fontWeight: FontWeight.w600,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
  );

  /// Dark Theme
  static final darkElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      foregroundColor: Colors.white,
      backgroundColor: _primaryBlue,
      disabledForegroundColor: Colors.white,
      disabledBackgroundColor: _disabledGrey,
      side: const BorderSide(color: _primaryBlue),
      padding: const EdgeInsets.symmetric(vertical: 15),
      textStyle: const TextStyle(
        fontSize: 16,
        color: Colors.white,
        fontWeight: FontWeight.w600,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
  );
}

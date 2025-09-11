import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

class TLoggerHelper {
  static final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 2,
      errorMethodCount: 8,
      lineLength: 120,
      colors: true,
      printEmojis: true,
      printTime: true,
    ),
    // Reduce noise in release builds
    level: kReleaseMode ? Level.warning : Level.debug,
  );

  static void debug(String message) => _logger.d(message);
  static void info(String message) => _logger.i(message);
  static void warning(String message) => _logger.w(message);
  static void error(String message, {dynamic error, StackTrace? stackTrace}) =>
      _logger.e(message, error: error, stackTrace: stackTrace);
  static void verbose(String message) => _logger.v(message);
  static void wtf(String message) => _logger.wtf(message);

  // Log JSON or maps nicely
  static void json(dynamic data, {String? tag}) {
    final text = tag == null ? data : '[$tag] $data';
    _logger.t(text);
  }

  // Optional: adjust level at runtime

}

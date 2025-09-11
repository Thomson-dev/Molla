import 'package:get_storage/get_storage.dart';

class TLocalStorage {
  TLocalStorage._internal();
  static final TLocalStorage _instance = TLocalStorage._internal();
  factory TLocalStorage() => _instance;

  static final GetStorage _storage = GetStorage();

  // Call once before runApp()
  static Future<void> init() async {
    await GetStorage.init();
  }

  // Write
  static Future<void> saveData<T>(String key, T value) async {
    await _storage.write(key, value);
  }

  // Read (returns null if missing)
  static T? readData<T>(String key) {
    return _storage.read<T>(key);
  }

  // Read with default
  static T readOrDefault<T>(String key, T defaultValue) {
    final v = _storage.read<T>(key);
    return v ?? defaultValue;
  }

  // Remove key
  static Future<void> remove(String key) async {
    await _storage.remove(key);
  }

  // Clear all
  static Future<void> clear() async {
    await _storage.erase();
  }

  // Exists
  static bool has(String key) => _storage.hasData(key);

  // Convenience helpers
  static Future<void> setString(String key, String value) =>
      saveData(key, value);
  static String? getString(String key) => readData<String>(key);

  static Future<void> setBool(String key, bool value) => saveData(key, value);
  static bool? getBool(String key) => readData<bool>(key);

  static Future<void> setInt(String key, int value) => saveData(key, value);
  static int? getInt(String key) => readData<int>(key);

  static Future<void> setDouble(String key, double value) =>
      saveData(key, value);
  static double? getDouble(String key) => readData<double>(key);

  static Future<void> setMap(String key, Map<String, dynamic> value) =>
      saveData(key, value);
  static Map<String, dynamic>? getMap(String key) =>
      readData<Map<String, dynamic>>(key);

  // Write only if key is absent
  static Future<void> writeIfNull<T>(String key, T value) async {
    if (!has(key)) await saveData(key, value);
  }
}

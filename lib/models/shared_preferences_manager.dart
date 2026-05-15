import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesManager {
  static SharedPreferences? _preferences;

  // Load preferences from shared preferences using Singleton pattern
  static Future<void> init() async {
    _preferences ??= await SharedPreferences.getInstance();
  }

  static SharedPreferences get instance {
    if (_preferences == null) {
      throw Exception(
          'SharedPreferencesManager is not initialized. Call init() first.');
    }
    return _preferences!;
  }
}

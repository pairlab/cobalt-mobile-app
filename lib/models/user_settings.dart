import 'package:cobalt/models/shared_preferences_manager.dart';

enum Setting {
  // String: TCP IP Address
  // ignore: constant_identifier_names
  IPAddress,

  // UInt32: TCP Port Number
  Port,

  // String: Username
  username,

  // String: TCP publish string format
  publishFormat,

  // Float: TCP publish interval (in seconds)
  publishInterval,

  // Type of task
  task,

  // Bool: whether to use bimanual mode
  bimanual,

  // String: Session ID for bimanual mode
  sessionId,
}

const Map<Setting, dynamic> defaultSettings = {
  Setting.IPAddress: '127.0.0.1',
  Setting.Port: 8080,
  Setting.username: 'default',
  Setting.publishFormat: '{"id": %d, "enable": %d, "dpos": [%.5f, %.5f, %.5f], "grasp": %d, "reset": %d, "completion": %d, "timeout": %d, "valid": %d, "keep_demo_decision": %d, "demo_decision_indicator": %d, "timestamp": %.5f, "rotation" : [%.5f, %.5f, %.5f, %.5f, %.5f, %.5f, %.5f, %.5f, %.5f]}',
  Setting.publishInterval: 0.05,
  Setting.task: 'test',
  Setting.bimanual: false,
  Setting.sessionId: '',
};

class UserSettings {
  static final UserSettings _instance = UserSettings._internal();

  // Private constructor
  UserSettings._internal() {
    _loadPreferences();
  }

  factory UserSettings() {
    return _instance;
  }

  // Update shared preferences if necessary
  void _loadPreferences() {
    print('Loading preferences...');
    final prefs = SharedPreferencesManager.instance;

    for (Setting setting in Setting.values) {
      if (!prefs.containsKey(setting.toString()) || setting == Setting.publishFormat) {
        updateSetting(setting, defaultSettings[setting]!);
      }
    }

    // Clear sessionId on app initialization so it doesn't persist across sessions
    updateSetting(Setting.sessionId, '');
  }

  // Update a setting in the shared preferences
  // Function overloading not allowed in Flutter, so must use dynamic type
  Future<void> updateSetting(Setting setting, dynamic value) async {
    final prefs = SharedPreferencesManager.instance;
    if (value is int) {
      await prefs.setInt(setting.toString(), value);
    } else if (value is double) {
      await prefs.setDouble(setting.toString(), value);
    } else if (value is String) {
      await prefs.setString(setting.toString(), value);
    } else if (value is bool) {
      await prefs.setBool(setting.toString(), value);
    } else {
      throw Exception('Invalid setting type');
    }
  }

  // Update multiple settings at once
  Future<void> updateSettings(Map<Setting, dynamic> settings) async {
    for (final setting in settings.entries) {
      await updateSetting(setting.key, setting.value);
    }
  }

  // Getters for all settings
  Map<Setting, dynamic> get allSettings {
    final settings = <Setting, dynamic>{};
    for (final setting in Setting.values) {
      settings[setting] = getSetting(setting);
    }
    return settings;
  }

  dynamic getSetting(Setting setting) {
    switch (setting) {
      case Setting.IPAddress:
        return IPAddress;
      case Setting.Port:
        return Port;
      case Setting.username:
        return username;
      case Setting.publishFormat:
        return publishFormat;
      case Setting.publishInterval:
        return publishInterval;
      case Setting.task:
        return task;
      case Setting.bimanual:
        return bimanual;
      case Setting.sessionId:
        return sessionId;
      default:
        throw Exception('Invalid setting');
    }
  }

  String get IPAddress => SharedPreferencesManager.instance
      .getString(Setting.IPAddress.toString())!;
  int get Port => SharedPreferencesManager.instance
      .getInt(Setting.Port.toString())!;
  String get username => SharedPreferencesManager.instance
      .getString(Setting.username.toString())!;
  String get publishFormat => SharedPreferencesManager.instance
      .getString(Setting.publishFormat.toString())!;
  double get publishInterval => SharedPreferencesManager.instance
      .getDouble(Setting.publishInterval.toString())!;
  String get task => SharedPreferencesManager.instance
      .getString(Setting.task.toString())!;
  bool get bimanual => SharedPreferencesManager.instance
      .getBool(Setting.bimanual.toString())!;
  String get sessionId => SharedPreferencesManager.instance
      .getString(Setting.sessionId.toString())!;
}

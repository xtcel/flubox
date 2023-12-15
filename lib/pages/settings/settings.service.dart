import 'package:hive/hive.dart';

import 'settings.dto.dart';

/// Settings service
class SettingsService {
  const SettingsService._();

  /// Storage key
  static const key = 'settings_box';

  /// Storage box
  static Box<FluboxSettings>? box;

  /// Initialize storage
  static Future<void> init() async {
    box = await Hive.openBox<FluboxSettings>(key);
  }

  /// Save sidekick settings
  static Future<void> save(FluboxSettings settings) async {
    await box?.put(FluboxSettings.key, settings);
  }

  /// Read sidekick settings
  static FluboxSettings read() {
    // Make sure its initialized
    final settings = box?.get(FluboxSettings.key);
    if (settings != null) {
      return settings;
    } else {
      return FluboxSettings();
    }
  }

  /// Reset settings
  static Future<FluboxSettings> reset() async {
    /// Will set all AppSettings to default
    final emptySettings = FluboxSettings();
    await box?.put(FluboxSettings.key, emptySettings);
    return emptySettings;
  }
}

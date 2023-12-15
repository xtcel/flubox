import 'package:flubox/pages/settings/settings.utils.dart';
import 'package:flubox/pages/settings/settings_state.dart';
import 'package:flutter/material.dart';
import 'package:fvm/fvm.dart';
import 'package:get/get.dart';

import '../version_manager/flutter_config.service.dart';
import 'settings.dto.dart';
import 'settings.service.dart';

class SettingsController extends GetxController {
  final SettingsState state = SettingsState();

  @override
  void onInit() {
    _loadState();

    super.onInit();
  }

  Future<void> _loadState() async {
    /// Update app state right away
    final sidekickSettings = SettingsService.read();
    state.settings = AllSettings.create(sidekick: sidekickSettings);

    //Go get async state
    final fvmSettings = await FVMClient.readSettings();
    final flutterSettings = await FlutterConfigService.getFlutterConfig();
    state.settings = AllSettings(
      // Set state
      flubox: sidekickSettings,
      fvm: fvmSettings,
      flutter: FlutterSettings.fromMap(flutterSettings),
    );

    state.prevSettings = state.settings;
  }

  ThemeMode themeStateFromHiveSettingBox() {
    String themeModeString = state.settings.flubox.themeMode;
    ThemeMode themeMode = getThemeMode(themeModeString);

    return themeMode;
  }

  /// Save settings
  Future<void> save(AllSettings settings) async {
    // Check for changes
    try {
      // Trigger refresh
      state.settings = state.settings.copy();
      await _checkFvmSettingsChanges(settings.fvm);
      await _checkAppSettingsChanges(settings.flubox);
      await _checkAnalyticsChanges(settings.flutter);
      // Set previous state only after success
      state.prevSettings = state.settings.copy();
      update();
    } on Exception {
      // Revert settings in case of errors
      state.settings = state.prevSettings;
      rethrow;
    }
  }

  Future<void> _checkAppSettingsChanges(FluboxSettings settings) async {
    final changed = settings != state.prevSettings.flubox;

    // Save sidekick settings changed
    if (changed) {
      await SettingsService.save(settings);
    }
  }

  Future<void> _checkAnalyticsChanges(FlutterSettings settings) async {
    final changed = settings != state.prevSettings.flutter;
    // Return if nothing changed
    if (changed) {
      // Toggle analytics
      await FlutterConfigService.setFluterConfig(settings.toMap());
    }
  }

  Future<void> _checkFvmSettingsChanges(FvmSettings settings) async {
    final changed = settings != state.prevSettings.fvm;
    if (changed) {
      await FVMClient.saveSettings(settings);
    }
  }

  // Method to change the Theme State when the user call it via Theme Chaneg Button
  void changeTheme(
    String modeName,
  ) {
    ThemeMode themeMode = getThemeMode(modeName);

    _changeThemeMode(themeMode);
  }

  //Private Method to change theme
  void _changeThemeMode(ThemeMode themeMode) => Get.changeThemeMode(themeMode);
}

import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:fvm/fvm.dart';
import 'package:hive/hive.dart';

import 'settings.utils.dart';

/// All Settings
class AllSettings {
  FluboxSettings flubox;
  FvmSettings fvm;
  FlutterSettings flutter;

  AllSettings({
    required this.fvm,
    required this.flutter,
    required this.flubox,
  });

  static AllSettings create({
    FluboxSettings? sidekick,
    FvmSettings? fvm,
    FlutterSettings? flutter,
  }) {
    return AllSettings(
      fvm: fvm ?? FvmSettings(),
      flutter: flutter ?? FlutterSettings(),
      flubox: sidekick ?? FluboxSettings(),
    );
  }

  AllSettings copy() => AllSettings(
        flubox: FluboxSettings.fromJson(flubox.toJson()),
        fvm: FvmSettings.fromJson(fvm.toJson()),
        flutter: FlutterSettings.fromMap(flutter.toMap()),
      );
}

/// Sidekick settings
class FluboxSettings {
  /// Constructor
  FluboxSettings({
    this.onlyProjectsWithFvm = false,
    this.projectPaths = const [],
    this.themeMode = SettingsThemeMode.system,
    this.locale,
    this.ide,
    this.customIdeLocation,
  });

  // : localizationsDelegate = I18NextLocalizationDelegate(
  //         locales: languageManager.supportedLocales.toList(),
  //         dataSource: AssetBundleLocalizationDataSource(
  //           bundlePath: 'localizations',
  //         ),
  //         options: I18NextOptions(formatter: languageManager.formatter),
  //       )

  /// Storage key
  static const key = 'settings_key';

  bool onlyProjectsWithFvm;
  List<String> projectPaths;
  String themeMode;
  // I18NextLocalizationDelegate localizationsDelegate;
  Locale? locale;
  String? ide;
  String? customIdeLocation;

  factory FluboxSettings.fromJson(String str) =>
      FluboxSettings.fromMap(json.decode(str));

  factory FluboxSettings.fromMap(Map<String, dynamic> json) {
    final language = json['i18Locale'];
    final locale = language != null
        ? Locale.fromSubtags(
            languageCode: (language as String).split('-')[0],
            countryCode: language.split('-')[1])
        : null;

    return FluboxSettings(
      projectPaths: (json['projectPaths'] as List<dynamic>).cast<String>(),
      onlyProjectsWithFvm: json['onlyProjectsWithFvm'] as bool? ?? false,
      themeMode: json['themeMode'] as String? ?? SettingsThemeMode.system,
      locale: locale,
      ide: json['ide'],
      customIdeLocation: json['customIdeLocation'],
    );
  }

  /// Converts Master Secret to Json
  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() {
    return {
      'projectPaths': projectPaths,
      'onlyProjectsWithFvm': onlyProjectsWithFvm,
      'themeMode': themeMode,
      'i18Locale': locale?.toLanguageTag(),
      // languageManager.supportedLocales.first.toLanguageTag(),
      'ide': ide,
      'customIdeLocation': customIdeLocation,
    };
  }
}

class FluboxSettingsAdapter extends TypeAdapter<FluboxSettings> {
  @override
  int get typeId => 1; // this is unique, no other Adapter can have the same id.

  @override
  FluboxSettings read(BinaryReader reader) {
    // FIXME: Check why subtype does not match
    final value = Map<String, dynamic>.from(reader.readMap());
    return FluboxSettings.fromMap(value);
  }

  @override
  void write(BinaryWriter writer, FluboxSettings obj) {
    writer.writeMap(obj.toMap());
  }
}

/// Flutter settings
class FlutterSettings {
  /// Constructor
  FlutterSettings({
    this.analytics = true,
    this.linux = false,
    this.macos = false,
    this.windows = false,
    this.web = false,
  });

  /// Analytics enabled
  bool analytics;

  /// MacOS enabled
  bool macos;

  /// Linux enabled
  bool linux;

  /// Windows enabled
  bool windows;

  /// Web enabled
  bool web;

  /// Flutter settings from map
  factory FlutterSettings.fromMap(Map<String, bool> map) {
    return FlutterSettings(
      analytics: map['analytics'] ?? false,
      macos: map['macos'] ?? false,
      windows: map['windows'] ?? false,
      linux: map['linux'] ?? false,
      web: map['web'] ?? false,
    );
  }

  /// Flutter settings to map
  Map<String, bool> toMap() {
    return {
      'analytics': analytics,
      'macos': macos,
      'linux': linux,
      'windows': windows,
      'web': web,
    };
  }
}

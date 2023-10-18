import 'package:hive/hive.dart';

@HiveType(typeId: 0)
class Project extends HiveObject {
  /// Constructor
  Project({
    required this.name,
    required this.path,
  });

  @HiveField(0)

  /// Project name
  final String name;

  @HiveField(1)

  /// Project path
  final String path;

  /// Creates a project path from map
  factory Project.fromMap(Map<String, String> map) {
    return Project(
      name: map['name'] ?? '',
      path: map['path'] ?? '',
    );
  }

  /// Returns project path as a map
  Map<String, String> toMap() {
    return {
      'name': name,
      'path': path,
    };
  }
}

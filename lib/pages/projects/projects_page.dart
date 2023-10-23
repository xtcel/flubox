import 'dart:io';

import 'package:bruno/bruno.dart';
import 'package:file_selector/file_selector.dart';
import 'package:flubox/router/app_routers.dart';
import 'package:flubox/router/arguments_keys.dart';
import 'package:flutter/material.dart';
import 'package:fvm/fvm.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:responsive_grid/responsive_grid.dart';

/// projects page
///

class ProjectsPage extends StatefulWidget {
  const ProjectsPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ProjectsPageState();
  }
}

class _ProjectsPageState extends State<ProjectsPage> {
  /// Storage key
  static const _key = 'projects_service_box';
  late Box<ProjectRef> box;

  List<Project> projects = <Project>[];
  final bool _dragging = false;
  final List<XFile> _dropFileList = [];
  List<CacheVersion> versions = [];

  @override
  void initState() {
    // TODO: implement initState
    getProjects();
    getFlutterReleases();

    super.initState();
  }

  void getProjects() async {
    // 获取项目列表
    // List<Project> projects = await FVMClient.fetchProjects();
    // ProjectRef project = const ProjectRef(name: 'test', path: '/Users/test');
    // box.add(project);
    box = await Hive.openBox<ProjectRef>(_key);
    // box.clear();
    try {
      List<Directory> directories =
          box.values.map((e) => Directory(e.path)).toList();
      projects = await FVMClient.fetchProjects(directories);
      print("box: $box");
      setState(() {});
    } catch (e) {}
  }

  void getFlutterReleases() async {
    CacheVersion? globalVersion = await FVMClient.getGlobal();
    print("global version: $globalVersion");
    // currentVersion = globalVersion?.name ?? "";

    versions = await FVMClient.getCachedVersions();
    print("cached versions :$versions");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("项目", style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  TextButton(onPressed: () {}, child: const Text("所有项目")),
                  TextButton(onPressed: () {}, child: const Text("FVM Only")),
                ],
              ),
              ElevatedButton.icon(
                  onPressed: onAddProjectButton,
                  icon: const Icon(Icons.add),
                  label: const Text("添加项目"))
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: ResponsiveGridList(
                desiredItemWidth: 250,
                minSpacing: 10,
                children: projects.map((project) {
                  final GlobalKey selectedVersionButtonKey = GlobalKey();

                  return SizedBox(
                      height: 180,
                      child: InkWell(
                        onTap: () {
                          // 进入项目详情页面
                          Get.toNamed(Routers.projectDetailPage, arguments: {
                            ArgumentsKeys.model: project,
                          });
                        },
                        child: BrnShadowCard(
                            padding: const EdgeInsets.all(20),
                            color: const Color.fromRGBO(255, 255, 255, 1),
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                children: [
                                  const Icon(Icons.folder),
                                  Text(project.name ?? ""),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      TextButton.icon(
                                        key: selectedVersionButtonKey,
                                        onPressed: () {
                                          // 选择版本
                                          BrnPopupListWindow.showPopListWindow(
                                            context,
                                            selectedVersionButtonKey,
                                            data: versions
                                                .map((version) => version.name)
                                                .toList(),
                                            onItemClick: (index, item) {
                                              // 切换项目版本
                                              checkVersion(project, item);

                                              return false;
                                            },
                                          );
                                        },
                                        icon: const Icon(Icons.arrow_drop_down),
                                        label: Text(
                                          project.pinnedVersion ?? "选择版本",
                                          style: const TextStyle(fontSize: 12),
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            )),
                      ));
                }).toList()),
          ),
        ],
      ),
    );
  }

  // 切换项目版本
  void checkVersion(Project project, String version) async {
    await FVMClient.pinVersion(project, version);
    String toast = "${project.name}已切换到version: $version";
    BrnToast.show(toast, context);
    // 刷新项目列表数据
    setState(() {
      getProjects();
    });
  }

  void onAddProjectButton() async {
    // 添加项目（选择项目路径）
    // 1. 打开文件选择器,选择项目路径
    final String? directoryPath = await getDirectoryPath();
    print("path: $directoryPath");
    if (directoryPath == null) {
      // Operation was canceled by the user.
      return;
    }
    // 2. 检测是否为flutter项目目录 ,添加项目
    addProject(context, directoryPath);
  }

  /// Adds a project
  Future<void> addProject(BuildContext context, String path) async {
    final project = await FVMClient.getProjectByDirectory(Directory(path));
    if (project.isFlutterProject) {
      final ref = ProjectRef(name: path.split('/').last, path: path);
      box.put(path, ref);

      // 刷新数据
      getProjects();
    } else {
      // ignore: use_build_context_synchronously
      BrnToast.show('modules:projects.notAFlutterProject'.tr, context);
      // notify(context.i18n('modules:projects.notAFlutterProject'));
    }
  }
}

/// Ref to project path
class ProjectRef {
  /// Constructor
  const ProjectRef({
    required this.name,
    required this.path,
  });

  /// Project name
  final String name;

  /// Project path
  final String path;

  /// Creates a project path from map
  factory ProjectRef.fromMap(Map<String, String> map) {
    return ProjectRef(
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

/// Project path adapter
class ProjectPathAdapter extends TypeAdapter<ProjectRef> {
  @override
  int get typeId => 2; // this is unique, no other Adapter can have the same id.

  @override
  ProjectRef read(BinaryReader reader) {
    final value = Map<String, String>.from(reader.readMap());
    return ProjectRef.fromMap(value);
  }

  @override
  void write(BinaryWriter writer, ProjectRef obj) {
    writer.writeMap(obj.toMap());
  }
}

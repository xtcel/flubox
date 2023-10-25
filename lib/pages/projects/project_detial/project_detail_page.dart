/// 项目详情页面

import 'package:flubox/router/app_routers.dart';
import 'package:flutter/material.dart';
import 'package:fvm/fvm.dart';
import 'package:get/get.dart';

import '../../../router/arguments_keys.dart';

class ProjectDetailPage extends StatefulWidget {
  const ProjectDetailPage({super.key});

  @override
  _ProjectDetailPageState createState() => _ProjectDetailPageState();
}

class _ProjectDetailPageState extends State<ProjectDetailPage> {
  late Project project;

  @override
  void initState() {
    /// 获取路由参数
    Get.arguments?.forEach((key, value) {
      if (key == ArgumentsKeys.model) {
        project = value as Project;
      }
      debugPrint('key:$key value:$value');
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(project.name ?? ""),
      ),
      body: Column(
        children: [
          const Text("project_name"),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: Wrap(
              children: [
                ..._buildItemWidgets(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildItemWidgets() {
    return [
      InkWell(
        onTap: () {
          Get.toNamed(Routers.resourceManagerPage,
              arguments: {ArgumentsKeys.model: project});
        },
        child: Container(
          padding: const EdgeInsets.all(10),
          child: const Column(
            children: [Icon(Icons.folder), Text("资源管理")],
          ),
        ),
      ),
      Container(
        padding: const EdgeInsets.all(10),
        child: const Text("项目路径"),
      ),
    ];
  }
}

import 'package:bruno/bruno.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../generated/locales.g.dart';
import '../../router/app_routers.dart';

/// 工具页面

class ToolsIndexPage extends StatefulWidget {
  const ToolsIndexPage({super.key});

  @override
  State<StatefulWidget> createState() => _ToolsIndexPageState();
}

class _ToolsIndexPageState extends State<ToolsIndexPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(LocaleKeys.labels_tools.tr,
                    style: Theme.of(context).textTheme.titleMedium),
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(10),
              width: double.infinity,
              child: Wrap(
                spacing: 15,
                runSpacing: 10,
                children: [
                  ToolsMenuItem(
                    icon: Icons.av_timer,
                    title: LocaleKeys.labels_unix_time_stamp.tr,
                    summary: LocaleKeys.labels_unix_time_stmap_desc.tr,
                    onTap: () {
                      Get.toNamed(Routers.unixTimeConvertPage);
                    },
                  ),
                  ToolsMenuItem(
                    icon: MdiIcons.counter,
                    title: LocaleKeys.labels_binary_convert.tr,
                    summary: LocaleKeys.labels_binary_convert_desc.tr,
                    onTap: () {
                      Get.toNamed(Routers.binaryConvertPage);
                    },
                  ),
                  // Flutter 图标库
                  ToolsMenuItem(
                    icon: Icons.flutter_dash,
                    title: LocaleKeys.labels_material_design_icons.tr,
                    summary: LocaleKeys.labels_material_design_icons_desc.tr,
                    onTap: () {
                      Get.toNamed(Routers.flutterIconsPage);
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ToolsMenuItem extends StatelessWidget {
  const ToolsMenuItem(
      {Key? key,
      required this.title,
      required this.icon,
      required this.summary,
      required this.onTap})
      : super(key: key);

  final IconData icon;
  final String title;
  final String summary;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Container(
        width: 250,
        height: 80,
        decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).dividerColor),
          borderRadius: BorderRadius.circular(10),
        ),
        clipBehavior: Clip.antiAlias,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Row(
            children: [
              Container(
                width: 50,
                height: double.infinity,
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                ),
                child: Icon(
                  icon,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Flexible(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      summary,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

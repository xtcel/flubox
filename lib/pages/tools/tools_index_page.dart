import 'package:bruno/bruno.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
                children: [
                  ToolsMenuItem(
                    icon: Icons.av_timer,
                    title: LocaleKeys.labels_unix_time_stamp.tr,
                    onTap: () {
                      Get.toNamed(Routers.unixTimeConvertPage);
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
      {Key? key, required this.title, required this.icon, required this.onTap})
      : super(key: key);

  final String title;
  final IconData icon;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        width: 100,
        child: Column(
          children: [
            Icon(
              icon,
              color: Colors.grey,
            ),
            Text(
              title,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:bruno/bruno.dart';
import 'package:flutter/material.dart';

/// 工具页面

class ToolsPage extends StatefulWidget {
  const ToolsPage({super.key});

  @override
  State<StatefulWidget> createState() => _ToolsPageState();
}

class _ToolsPageState extends State<ToolsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BrnAppBar(
        title: "工具",
        automaticallyImplyLeading: false,
        actions: [
          // 设置按钮
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.settings,
                color: Colors.grey,
              ))
        ],
      ),
      body: Wrap(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            child: const Column(
              children: [
                Icon(
                  Icons.av_timer,
                  color: Colors.grey,
                ),
                Text(
                  "时间戳",
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

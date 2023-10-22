import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';

/// 解压管理组件

class UnzipFileManagerWidget extends StatefulWidget {
  final XFile? file;

  const UnzipFileManagerWidget({
    Key? key,
    required this.file,
  }) : super(key: key);

  @override
  _UnzipFileManagerWidgetState createState() => _UnzipFileManagerWidgetState();
}

class _UnzipFileManagerWidgetState extends State<UnzipFileManagerWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(),
        Row(
          children: [
            ListView(
              children: [],
            )
          ],
        )
      ],
    );
  }
}

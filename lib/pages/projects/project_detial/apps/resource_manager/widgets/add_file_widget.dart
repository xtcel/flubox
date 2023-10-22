import 'package:desktop_drop/desktop_drop.dart';
import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';

/// 添加zip资源组件

class AddFileWidget extends StatefulWidget {
  const AddFileWidget({Key? key, this.onAddFile}) : super(key: key);

  /// 添加文件回调
  final Function(List<XFile>)? onAddFile;

  @override
  _AddFileWidgetState createState() => _AddFileWidgetState();
}

class _AddFileWidgetState extends State<AddFileWidget> {
  final List<XFile> _dropFileList = [];
  bool _dragging = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: DropTarget(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Container(
                  // 虚线框
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: _dragging ? Colors.blue : Colors.grey,
                        width: 1,
                        style: BorderStyle.solid),
                  ),
                  child: const Icon(Icons.add_box_outlined)),
              const Text("drap .zip file here"),
            ],
          ),
        ),
        onDragDone: (detail) {
          print("detail: $detail");
          // 解压文件
          // _unzipFile(detail.files);
          widget.onAddFile?.call(detail.files);
          setState(() {
            _dropFileList.addAll(detail.files);
          });
        },
        onDragEntered: (detail) {
          setState(() {
            _dragging = true;
          });
        },
        onDragExited: (detail) {
          setState(() {
            _dragging = false;
          });
        },
      ),
    );
  }
}

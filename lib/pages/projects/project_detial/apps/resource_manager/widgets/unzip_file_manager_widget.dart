import 'package:archive/archive_io.dart';
import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fancy_tree_view/flutter_fancy_tree_view.dart';
import 'package:fvm/fvm.dart';
import 'dart:io';

import 'package:path/path.dart';

/// 解压管理组件

class UnzipFileManagerWidget extends StatefulWidget {
  final XFile? file;
  final Project project;

  const UnzipFileManagerWidget({
    Key? key,
    required this.file,
    required this.project,
  }) : super(key: key);

  @override
  _UnzipFileManagerWidgetState createState() => _UnzipFileManagerWidgetState();
}

class _UnzipFileManagerWidgetState extends State<UnzipFileManagerWidget> {
  /// 源文件树控制器
  late final TreeController<MyNode> sourceTreeController;
  // 待解压文件
  List<MyNode> fromFileNodes = [];
  List<MyNode> formFileRoots = [];

  /// 解压效果预览文件树控制器
  late final TreeController<MyNode> previewTreeController;
  // 解压效果预览文件
  List<MyNode> previewFileNodes = [];
  List<MyNode> previewFileRoot = [];
  // 目标文件夹名称
  String targetFolderName = 'assets/images';
  // 目标文件夹
  String targetFolderPath = 'assets/images';

  @override
  void initState() {
    super.initState();

    /// 添加源文件根节点
    formFileRoots.add(
      MyNode(title: widget.file?.name ?? '', children: fromFileNodes),
    );
    sourceTreeController = TreeController<MyNode>(
      roots: formFileRoots,
      childrenProvider: (MyNode node) => node.children,
    );

    /// 添加解压效果预览文件根节点
    previewFileRoot.add(
      MyNode(title: targetFolderName, children: previewFileNodes),
    );
    previewTreeController = TreeController<MyNode>(
      roots: previewFileRoot,
      childrenProvider: (MyNode node) => node.children,
    );

    refreshDatas();
  }

  /// 获取解压文件
  void refreshDatas() async {
    List<ArchiveFile>? files = await _getUnzipFiles(widget.file);
    if (files != null) {
      fromFileNodes.addAll(files.map((e) => MyNode(title: e.name)).toList());

      previewFileNodes.addAll(_handlePreviewUnzipFiles(files));
    }

    setState(() {
      sourceTreeController.rebuild();
      sourceTreeController.expandAll();
      previewTreeController.rebuild();
      previewTreeController.expandAll();
    });
  }

  /// 处理解压文件
  List<MyNode> _handlePreviewUnzipFiles(List<ArchiveFile> files) {
    List<MyNode> nodes = [];
    for (var file in files) {
      if (file.isFile) {
        String fileName = file.name.substring(0, file.name.lastIndexOf('.'));
        String suffix = extension(file.name);
        // 获取图片尺寸后缀
        int index = fileName.lastIndexOf('@');
        String sizeSuffix = index != -1 ? fileName.substring(index + 1) : "";
        // fileName.substring(fileName.lastIndexOf('@'));
        // 获取文件名
        String name = index != -1 ? fileName.substring(0, index) : fileName;
        if (sizeSuffix.isEmpty) {
          // 1x 图片
          nodes.add(MyNode(title: '$name$suffix'));
        } else {
          // 2x 3x 4x 图片
          // 建立文件夹
          String folderName = sizeSuffix;
          nodes.add(MyNode(title: folderName, children: [
            MyNode(title: '$name$suffix'),
          ]));
        }
      }
    }
    return nodes;
  }

  // 获取解压文件
  Future<List<ArchiveFile>?> _getUnzipFiles(XFile? file) async {
    if (file == null) {
      return null;
    }
    // XFile xfile = files.first;

    // Use an InputFileStream to access the zip file without storing it in memory.
    final inputStream = InputFileStream(file.path);
    // Decode the zip from the InputFileStream. The archive will have the contents of the
    // zip, without having stored the data in memory.
    final archive = ZipDecoder().decodeBuffer(inputStream);
    // For all of the entries in the archive
    for (var file in archive.files) {
      // If it's a file and not a directory
      if (file.isFile) {
        print("fileName: ${file.name}");
      }
    }

    return archive.files;
  }

  /// 解压文件
  void _unzipFile(XFile? file) async {
    if (file == null) {
      return null;
    }
    // XFile xfile = files.first;

    // Use an InputFileStream to access the zip file without storing it in memory.
    final inputStream = InputFileStream(file.path);
    // Decode the zip from the InputFileStream. The archive will have the contents of the
    // zip, without having stored the data in memory.
    final archive = ZipDecoder().decodeBuffer(inputStream);
    // For all of the entries in the archive
    for (var file in archive.files) {
      // If it's a file and not a directory
      if (file.isFile) {
        print("fileName: ${file.name}");

        String fileName = file.name.substring(0, file.name.lastIndexOf('.'));
        String suffix = extension(file.name);
        // 获取图片尺寸后缀
        int index = fileName.lastIndexOf('@');
        String sizeSuffix = index != -1 ? fileName.substring(index + 1) : "";
        // fileName.substring(fileName.lastIndexOf('@'));
        // 获取文件名
        String name = index != -1 ? fileName.substring(0, index) : fileName;

        String projectPath = widget.project.projectDir.path;
        String outputPath = sizeSuffix.isEmpty
            ? '$projectPath/$targetFolderPath/$name$suffix'
            : '$projectPath/$targetFolderPath/$sizeSuffix/$name$suffix';
        final outputStream = OutputFileStream(outputPath);
        // The writeContent method will decompress the file content directly to disk without
        // storing the decompressed data in memory.
        file.writeContent(outputStream);
        // Make sure to close the output stream so the File is closed.
        outputStream.close();
      }
    }
  }

  @override
  void dispose() {
    // Remember to dispose your tree controller to release resources.
    sourceTreeController.dispose();
    previewTreeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildTopToolsBarWidget(),
        Expanded(
          child: Row(
            children: [
              Expanded(flex: 1, child: _buildFromZipFilesTreeViewWidget()),
              // 分割线
              VerticalDivider(
                width: 1,
                thickness: 1,
                color: Colors.grey[400],
              ),
              Expanded(flex: 3, child: _buildPreviewUnzipFileWidget()),
            ],
          ),
        ),
        // 确认解压
        Container(
          color: Colors.grey[200],
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton.icon(
                  onPressed: () {
                    // 解压文件
                    _unzipFile(widget.file);
                  },
                  icon: const Icon(Icons.file_download_done_rounded),
                  label: const Text("确认解压")),
              const SizedBox(
                width: 20,
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildTopToolsBarWidget() {
    return Container(
      color: Colors.grey[200],
      height: 50,
      child: Row(
        children: [
          // TextField(
          //   decoration: InputDecoration(
          //     hintText: '搜索',
          //     border: OutlineInputBorder(
          //       borderRadius: BorderRadius.circular(8),
          //     ),
          //   ),
          // ),
          IconButton(
            onPressed: () async {
              const typeGroup = XTypeGroup(
                label: 'zip',
                extensions: ['zip'],
              );
              final file = await openFile(acceptedTypeGroups: [typeGroup]);
              if (file != null) {
                print(file.path);
              }
            },
            icon: const Icon(Icons.add),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.delete),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
    );
  }

  Widget _buildFromZipFilesTreeViewWidget() {
    return AnimatedTreeView<MyNode>(
      treeController: sourceTreeController,
      nodeBuilder: (BuildContext context, TreeEntry<MyNode> entry) {
        return MyTreeTile(
          // Add a key to your tiles to avoid syncing descendant animations.
          key: ValueKey(entry.node),
          entry: entry,
          // Add a callback to toggle the expansion state of this node.
          onTap: () => sourceTreeController.toggleExpansion(entry.node),
        );
      },
    );
  }

  /// 解压效果预览
  Widget _buildPreviewUnzipFileWidget() {
    return AnimatedTreeView<MyNode>(
      treeController: previewTreeController,
      nodeBuilder: (BuildContext context, TreeEntry<MyNode> entry) {
        return MyTreeTile(
          // Add a key to your tiles to avoid syncing descendant animations.
          key: ValueKey(entry.node),
          entry: entry,
          // Add a callback to toggle the expansion state of this node.
          onTap: () => previewTreeController.toggleExpansion(entry.node),
        );
      },
    );
  }
}

class MyNode {
  const MyNode({
    required this.title,
    this.children = const <MyNode>[],
  });

  final String title;
  final List<MyNode> children;
}

// Create a widget to display the data held by your tree nodes.
class MyTreeTile extends StatelessWidget {
  const MyTreeTile({
    super.key,
    required this.entry,
    required this.onTap,
  });

  final TreeEntry<MyNode> entry;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      // Wrap your content in a TreeIndentation widget which will properly
      // indent your nodes (and paint guides, if required).
      //
      // If you don't want to display indent guides, you could replace this
      // TreeIndentation with a Padding widget, providing a padding of
      // `EdgeInsetsDirectional.only(start: TreeEntry.level * indentAmount)`
      child: TreeIndentation(
        entry: entry,
        // Provide an indent guide if desired. Indent guides can be used to
        // add decorations to the indentation of tree nodes.
        // This could also be provided through a DefaultTreeIndentGuide
        // inherited widget placed above the tree view.
        guide: const IndentGuide.connectingLines(indent: 48),
        // The widget to render next to the indentation. TreeIndentation
        // respects the text direction of `Directionality.maybeOf(context)`
        // and defaults to left-to-right.
        child: Padding(
          padding: const EdgeInsets.fromLTRB(4, 8, 8, 8),
          child: Row(
            children: [
              // Add a widget to indicate the expansion state of this node.
              // See also: ExpandIcon.
              FolderButton(
                isOpen: entry.hasChildren ? entry.isExpanded : null,
                onPressed: entry.hasChildren ? onTap : null,
              ),
              Text(entry.node.title),
            ],
          ),
        ),
      ),
    );
  }
}

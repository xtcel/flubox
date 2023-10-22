/// 资源管理

import 'package:archive/archive_io.dart';
import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';

import 'widgets/add_file_widget.dart';
import 'widgets/unzip_file_manager_widget.dart';

class ResourceManagerPage extends StatefulWidget {
  const ResourceManagerPage({Key? key}) : super(key: key);

  @override
  _ResourceManagerPageState createState() => _ResourceManagerPageState();
}

class _ResourceManagerPageState extends State<ResourceManagerPage> {
  bool showAddFile = true;
  XFile? selectedFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("资源管理"),
        ),
        body: showAddFile
            ? AddFileWidget(
                onAddFile: (files) {
                  setState(() {
                    showAddFile = false;
                    selectedFile = files.first;
                  });
                },
              )
            : UnzipFileManagerWidget(file: selectedFile));
  }

  /// 解压文件
  void _unzipFile(List<XFile> files) async {
    XFile xfile = files.first;

    // Use an InputFileStream to access the zip file without storing it in memory.
    final inputStream = InputFileStream(xfile.path);
    // Decode the zip from the InputFileStream. The archive will have the contents of the
    // zip, without having stored the data in memory.
    final archive = ZipDecoder().decodeBuffer(inputStream);
    // For all of the entries in the archive
    for (var file in archive.files) {
      // If it's a file and not a directory
      if (file.isFile) {
        print("fileName: ${file.name}");
        // Write the file content to a directory called 'out'.
        // In practice, you should make sure file.name doesn't include '..' paths
        // that would put it outside of the extraction directory.
        // An OutputFileStream will write the data to disk.
        // final outputStream = OutputFileStream('out/${file.name}');
        // The writeContent method will decompress the file content directly to disk without
        // storing the decompressed data in memory.
        // file.writeContent(outputStream);
        // Make sure to close the output stream so the File is closed.
        // outputStream.close();
      }
    }

    // final typeGroup = XTypeGroup(
    //   label: 'zip',
    //   extensions: ['zip'],
    // );
    // final file = await openFile(acceptedTypeGroups: [typeGroup]);
    // if (file == null) {
    //   // Operation was canceled by the user.
    //   return;
    // }
    // print("file: $file");
  }
}

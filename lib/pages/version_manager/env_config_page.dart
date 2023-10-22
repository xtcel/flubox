import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fvm/fvm.dart';
// ignore: implementation_imports
import 'package:fvm/src/runner.dart';

/// 环境配置页面

class EnvConfigPage extends StatefulWidget {
  const EnvConfigPage({super.key});

  @override
  _EnvConfigPageState createState() => _EnvConfigPageState();
}

class _EnvConfigPageState extends State<EnvConfigPage> {
  // PUB_HOSTED_URL
  String? pubHostedUrl;
  // FLUTTER_STORAGE_BASE_URL
  String? flutterStorageBaseUrl;
  // flutter bin
  String? flutterRoot;
  // FLUTTER_RELEASES_URL
  String? flutterReleasesUrl;
  // FVM_GIT_CACHE
  String? fvmGitCache;

  @override
  void initState() {
    flutterStorageBaseUrl = Platform.environment["FLUTTER_STORAGE_BASE_URL"];
    pubHostedUrl = Platform.environment["PUB_HOSTED_URL"];
    flutterRoot = Platform.environment["FLUTTER_ROOT"];
    flutterReleasesUrl = Platform.environment["FLUTTER_RELEASES_URL"];
    fvmGitCache = Platform.environment["FVM_GIT_CACHE"];

    getFVMSettings();

    super.initState();
  }

  void getFVMSettings() async {
    var fvmSettings = await FVMClient.readSettings();
    print("fvmSettings: $fvmSettings");

    await FvmCommandRunner().run(['--version']);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text("镜像配置"),
        Container(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              const Text(
                "PUB_HOSTED_URL:",
                style: TextStyle(fontSize: 16),
              ),
              Text(
                pubHostedUrl ?? "",
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              const Text(
                "FLUTTER_STORAGE_BASE_URL：",
                style: TextStyle(fontSize: 16),
              ),
              Text(
                flutterStorageBaseUrl ?? "",
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              const Text(
                "FLUTTER_RELEASES_URL:",
                style: TextStyle(fontSize: 16),
              ),
              Text(
                flutterReleasesUrl ?? "",
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              const Text(
                "FVM_GIT_CACHE:",
                style: TextStyle(fontSize: 16),
              ),
              Text(
                fvmGitCache ?? "",
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
        // Expanded(
        //   child: Container(
        //     padding: const EdgeInsets.all(10),
        //     child: ListView.builder(
        //       itemCount: 1,
        //       itemBuilder: (BuildContext context, int index) {
        //         return Container(
        //           padding: const EdgeInsets.all(10),
        //           child: Row(
        //             children: [
        //               const Text(
        //                 "FLUTTER_STORAGE_BASE_URL：",
        //                 style: TextStyle(fontSize: 16),
        //               ),
        //               Text(
        //                 flutterStorageBaseUrl ?? "",
        //                 style: const TextStyle(fontSize: 16),
        //               ),
        //             ],
        //           ),
        //         );
        //       },
        //     ),
        //   ),
        // ),
      ],
    );
  }
}

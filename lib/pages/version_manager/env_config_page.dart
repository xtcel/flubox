import 'dart:io';

import 'package:flubox/theme/extension_theme.dart';
import 'package:flutter/material.dart';
import 'package:fvm/fvm.dart';
// ignore: implementation_imports
import 'package:fvm/src/runner.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../generated/locales.g.dart';

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
    super.initState();

    setState(() {
      flutterStorageBaseUrl = Platform.environment["FLUTTER_STORAGE_BASE_URL"];
      pubHostedUrl = Platform.environment["PUB_HOSTED_URL"];
      flutterRoot = Platform.environment["FLUTTER_ROOT"];
      flutterReleasesUrl = Platform.environment["FLUTTER_RELEASES_URL"];
      fvmGitCache = Platform.environment["FVM_GIT_CACHE"];
    });

    getFVMSettings();
  }

  void getFVMSettings() async {
    var fvmSettings = await FVMClient.readSettings();
    print("fvmSettings: $fvmSettings");

    await FvmCommandRunner().run(['--version']);
  }

  @override
  Widget build(BuildContext context) {
    final myColors = Theme.of(context).extension<MyColors>();
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        // 表头
        Container(
          padding: const EdgeInsets.all(10),
          // 圆角
          decoration: BoxDecoration(
            color: myColors?.tableHeaderBgColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              SizedBox(
                width: 200,
                child: Text(
                  LocaleKeys.labels_variable_name.tr,
                  style: const TextStyle(fontSize: 12),
                ),
              ),
              Expanded(
                child: Text(
                  LocaleKeys.labels_variable_value.tr,
                  style: const TextStyle(fontSize: 12),
                ),
              ),
              SizedBox(
                width: 80,
                child: Text(
                  LocaleKeys.labels_status.tr,
                  style: const TextStyle(fontSize: 12),
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 60,
          padding: const EdgeInsets.all(10),
          // 底部边框
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Theme.of(context).dividerColor,
                width: 1,
              ),
            ),
          ),
          child: Row(
            children: [
              const SizedBox(
                width: 200,
                child: Text(
                  "PUB_HOSTED_URL",
                  style: TextStyle(fontSize: 12),
                ),
              ),
              Expanded(
                child: Text(
                  pubHostedUrl ?? "",
                  style: const TextStyle(fontSize: 12),
                ),
              ),
              SizedBox(
                width: 80,
                child:
                    getStatusWidget(pubHostedUrl, "https://pub.flutter-io.cn"),
              ),
            ],
          ),
        ),
        Container(
          height: 60,
          padding: const EdgeInsets.all(10),
          // 底部边框
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Theme.of(context).dividerColor,
                width: 1,
              ),
            ),
          ),
          child: Row(
            children: [
              const SizedBox(
                width: 200,
                child: Text(
                  "FLUTTER_STORAGE_BASE_URL",
                  style: TextStyle(fontSize: 12),
                ),
              ),
              Expanded(
                child: Text(
                  flutterStorageBaseUrl ?? "",
                  style: const TextStyle(fontSize: 12),
                ),
              ),
              SizedBox(
                width: 80,
                child: getStatusWidget(
                    flutterStorageBaseUrl, "https://storage.flutter-io.cn"),
              ),
            ],
          ),
        ),
        Container(
          height: 60,
          padding: const EdgeInsets.all(10),
          // 底部边框
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Theme.of(context).dividerColor,
                width: 1,
              ),
            ),
          ),
          child: Row(
            children: [
              const SizedBox(
                width: 200,
                child: Text(
                  "FLUTTER_RELEASES_URL",
                  style: TextStyle(fontSize: 12),
                ),
              ),
              Expanded(
                child: Text(
                  flutterReleasesUrl ?? "",
                  style: const TextStyle(fontSize: 12),
                ),
              ),
              SizedBox(
                width: 80,
                child: getStatusWidget(
                    flutterReleasesUrl, "https://pub.flutter-io.cn"),
              ),
            ],
          ),
        ),
        Container(
          height: 60,
          padding: const EdgeInsets.all(10),
          // 底部边框
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Theme.of(context).dividerColor,
                width: 1,
              ),
            ),
          ),
          child: Row(
            children: [
              const SizedBox(
                width: 200,
                child: Text(
                  "FVM_GIT_CACHE",
                  style: TextStyle(fontSize: 12),
                ),
              ),
              Expanded(
                child: Text(
                  fvmGitCache ?? "",
                  style: const TextStyle(fontSize: 12),
                ),
              ),
              SizedBox(
                width: 80,
                child: getStatusWidget(
                    flutterReleasesUrl, "https://pub.flutter-io.cn"),
              ),
            ],
          ),
        ),
        // How to configure ?
        Container(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {
                  // 使用默认浏览器打开链接
                  launch(
                      "https://flutter.cn/docs/development/tools/sdk/release-notes/release-notes-2.2.3");
                },
                child: Text(
                  LocaleKeys.labels_how_to_configure.tr,
                  style: const TextStyle(fontSize: 12),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget getStatusWidget(String? value, String expectValue) {
    if (value != null && value != "") {
      // 正常
      return Text(LocaleKeys.labels_configured.tr,
          style: Theme.of(Get.context!).textTheme.bodyMedium?.copyWith(
              color:
                  Theme.of(Get.context!).extension<MyColors>()?.successColor));
    } else {
      // 未设置
      return Text(
        LocaleKeys.labels_unconfigured.tr,
        style: Theme.of(Get.context!).textTheme.bodyMedium?.copyWith(
            color: Theme.of(Get.context!).extension<MyColors>()?.warningColor),
      );
    }
  }
}

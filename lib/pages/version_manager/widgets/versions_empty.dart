import 'package:flubox/generated/locales.g.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VersionsEmpty extends StatelessWidget {
  const VersionsEmpty({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      children: [
        const SizedBox(height: 100),
        const FlutterLogo(),
        const SizedBox(height: 10),
        Text(
          LocaleKeys.labels_no_versions_installed_yet.tr,
        ),
        const SizedBox(height: 20),
        Text(
          LocaleKeys.labels_no_versions_installed_yet_desc.tr,
        ),
      ],
    ));
  }
}

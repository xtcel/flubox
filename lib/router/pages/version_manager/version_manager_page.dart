import 'package:flutter/material.dart';
import 'package:fvm/fvm.dart';

/// 版本管理页面

class VersionManagerPage extends StatefulWidget {
  const VersionManagerPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _VersionManagerState();
  }
}

class _VersionManagerState extends State<VersionManagerPage> {
  String currentVersion = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getFlutterReleases();

    // currentVersion = FVMClient.getGlobalVersionSync() ?? "";
    setState(() {});
  }

  void getFlutterReleases() async {
    final globalVersion = await FVMClient.getGlobal();

    List<CacheVersion> versions = await FVMClient.getCachedVersions();
    print("cached versions :$versions");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            const Row(
              children: [
                Text('版本切换'),
                Text('版本管理'),
              ],
            ),
            Row(
              children: [Text('global Version: $currentVersion')],
            ),
          ],
        ),
      ),
    );
  }
}

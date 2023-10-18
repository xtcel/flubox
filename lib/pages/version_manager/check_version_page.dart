import 'package:flutter/material.dart';
import 'package:fvm/fvm.dart';

/// 切换版本页面
class CheckVersionPage extends StatefulWidget {
  const CheckVersionPage({super.key});

  @override
  _CheckVersionPageState createState() => _CheckVersionPageState();
}

class _CheckVersionPageState extends State<CheckVersionPage> {
  String currentVersion = "";
  List<CacheVersion> versions = [];
  @override
  void initState() {
    super.initState();
    getFlutterReleases();
  }

  void getFlutterReleases() async {
    CacheVersion? globalVersion = await FVMClient.getGlobal();
    print("global version: $globalVersion");
    currentVersion = globalVersion?.name ?? "";

    versions = await FVMClient.getCachedVersions();
    print("cached versions :$versions");

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                const Text(
                  "当前版本：",
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  currentVersion,
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(10),
              child: ListView.builder(
                itemCount: versions.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        const Text(
                          "版本：",
                          style: TextStyle(fontSize: 16),
                        ),
                        Text(
                          versions[index].name,
                          style: const TextStyle(fontSize: 16),
                        ),
                        Expanded(
                          child: Container(),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: const Text(
                            "切换",
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

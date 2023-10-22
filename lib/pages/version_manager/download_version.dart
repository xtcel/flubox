import 'package:flutter/material.dart';
import 'package:fvm/fvm.dart';

/// 版本下载组件

class DownloadVersionWidget extends StatefulWidget {
  const DownloadVersionWidget({Key? key}) : super(key: key);

  @override
  _DownloadVersionWidgetState createState() => _DownloadVersionWidgetState();
}

class _DownloadVersionWidgetState extends State<DownloadVersionWidget> {
  /// 所有版本
  List<Release> _releases = [];
  @override
  void initState() {
    getAllReleases();
    super.initState();
  }

  getAllReleases() async {
    FlutterReleases releases = await FVMClient.getFlutterReleases();
    setState(() {
      _releases = releases.releases;
    });
    print("releases: $releases");

    // FLUTTER_RELEASES_URL
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          const Text("Release versions"),
          Expanded(
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: _releases.length,
                itemBuilder: (BuildContext context, int index) {
                  return Row(
                    children: [
                      Text(_releases[index].version),
                      Text(_releases[index].channel.name),
                      // Text(_releases[index].toDart),
                      TextButton(
                          onPressed: () {
                            FVMClient.install(_releases[index].version);
                          },
                          child: const Text("install "))
                    ],
                  );
                }),
          )
        ],
      ),
    );
  }
}

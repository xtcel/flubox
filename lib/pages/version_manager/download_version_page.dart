import 'package:flubox/pages/version_manager/controller/version_controller.dart';
import 'package:flubox/theme/extension_theme.dart';
import 'package:flutter/material.dart';
import 'package:fvm/fvm.dart';
import 'package:get/get.dart';

import '../../generated/locales.g.dart';

/// 版本下载组件

class DownloadVersionPage extends StatefulWidget {
  const DownloadVersionPage({Key? key}) : super(key: key);

  @override
  _DownloadVersionWidgetState createState() => _DownloadVersionWidgetState();
}

class _DownloadVersionWidgetState extends State<DownloadVersionPage> {
  /// 所有版本
  List<Release> _allReleases = [];

  /// 刷选版本
  final List<Release> _filterReleases = [];

  /// 已安装版本
  List<CacheVersion> _installedReleases = [];

  /// channel
  Channel _selectedChannel = Channel.stable;

  @override
  void initState() {
    getInstalledReleases();
    getAllReleases();
    super.initState();
  }

  getAllReleases() async {
    FlutterReleases releases = await FVMClient.getFlutterReleases();
    setState(() {
      _allReleases = releases.releases;
      // 默认只显示稳定版
      _filterReleases.addAll(_allReleases.where((element) {
        return element.channel == _selectedChannel;
      }));
    });
    print("releases: $releases");

    // FLUTTER_RELEASES_URL
  }

  getInstalledReleases() async {
    List<CacheVersion> releases = await FVMClient.getCachedVersions();
    setState(() {
      _installedReleases = releases;
    });
    print("releases: $releases");
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.only(top: 10, bottom: 20),
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(LocaleKeys.labels_versions.tr),
              Row(
                children: [
                  PopupMenuButton<Channel>(
                      itemBuilder: (BuildContext context) {
                        return [
                          PopupMenuItem(
                            value: Channel.stable,
                            child: Text(LocaleKeys.labels_stable.tr),
                          ),
                          PopupMenuItem(
                            value: Channel.beta,
                            child: Text(LocaleKeys.labels_beta.tr),
                          ),
                          PopupMenuItem(
                            value: Channel.dev,
                            child: Text(LocaleKeys.labels_dev.tr),
                          ),
                        ];
                      },
                      onSelected: (value) {
                        print("value: ${value.name}");
                        setState(() {
                          _selectedChannel = value;
                          _filterReleases.clear();
                          _filterReleases.addAll(_allReleases.where((element) {
                            return element.channel == _selectedChannel;
                          }));
                        });
                      },
                      child: Row(
                        children: [
                          Text(
                            "labels_${_selectedChannel.name}".tr,
                            style: TextStyle(
                                color: theme.primaryColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w300),
                          ),
                          Icon(
                            Icons.keyboard_arrow_down_rounded,
                            color: theme.primaryColor,
                            size: 24,
                          ),
                        ],
                      )),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Expanded(
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: _filterReleases.length,
              itemBuilder: (BuildContext context, int index) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(_filterReleases[index].version),
                        // Container(
                        //   margin: const EdgeInsets.only(left: 10),
                        //   decoration: BoxDecoration(
                        //       color: Colors.blue,
                        //       borderRadius: BorderRadius.circular(10)),
                        //   child: Text(_filterReleases[index].channel.name),
                        // ),
                      ],
                    ),
                    getOperationWidget(_filterReleases[index])
                  ],
                );
              },
              separatorBuilder: (context, index) {
                return const Divider();
              },
            ),
          ),
          // TODO: 下载进度
          // SliverAppBar(
          //   pinned: true,
          //   backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          //   bottom: const PreferredSize(
          //     preferredSize: Size.fromHeight(1),
          //     child: Divider(height: 0),
          //   ),
          //   automaticallyImplyLeading: false,
          //   // actions: [Container()],
          //   title: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     crossAxisAlignment: CrossAxisAlignment.center,
          //     children: [
          //       Row(
          //         children: [
          //           Heading(
          //             context.i18n('modules:releases.versions'),
          //           ),
          //           const SizedBox(width: 10),
          //           Chip(label: Text(versions.length.toString())),
          //         ],
          //       ),
          //       DropdownButton<String>(
          //         value: filter.state.name,
          //         icon: const Icon(Icons.filter_list),
          //         underline: Container(),
          //         items: Filter.values.map((Filter filter) {
          //           final text = filter != Filter.all
          //               ? filter.name.capitalize()
          //               : context.i18n('modules:releases.all');

          //           return DropdownMenuItem(
          //             value: filter.name,
          //             child: Text(text),
          //           );
          //         }).toList(),
          //         onChanged: (value) {
          //           filter.state = filterFromName(value!);
          //         },
          //       ),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }

  Widget getOperationWidget(Release release) {
    final theme = Theme.of(context);
    final VersionController controller = Get.find<VersionController>();
    if (isInstalled(release)) {
      return IconButton(
        onPressed: null,
        icon: Icon(
          Icons.check_circle_outline_rounded,
          size: 24,
          color: theme.colorScheme.primary,
        ),
      );
    } else {
      return IconButton(
          onPressed: () {
            controller.install(release);
            // FVMClient.install(release.version);
          },
          icon: const Icon(
            Icons.download_rounded,
            size: 24,
          ));
    }
  }

  // 是否已经安装版本
  bool isInstalled(Release release) {
    return _installedReleases.any((element) => element.name == release.version);
  }

  int compareSemver(String version, String other) {
    final regExp = RegExp(
      r"(?<Major>0|(?:[1-9]\d*))(?:\.(?<Minor>0|(?:[1-9]\d*))(?:\.(?<Patch>0|(?:[1-9]\d*)))?(?:\-(?<PreRelease>[0-9A-Z\.-]+))?(?:\+(?<Meta>[0-9A-Z\.-]+))?)?",
    );
    try {
      if (regExp.hasMatch(version) && regExp.hasMatch(other)) {
        final versionMatches = regExp.firstMatch(version);
        final otherMatches = regExp.firstMatch(other);

        var result = 0;

        if (versionMatches == null || otherMatches == null) {
          return result;
        }

        for (var idx = 1; idx < versionMatches.groupCount; idx++) {
          final versionMatch = versionMatches.group(idx) ?? '';
          final otherMatch = otherMatches.group(idx) ?? '';
          final versionNumber = int.tryParse(versionMatch);
          final otherNumber = int.tryParse(otherMatch);
          if (versionMatch != otherMatch) {
            if (versionNumber == null || otherNumber == null) {
              result = versionMatch.compareTo(otherMatch);
            } else {
              result = versionNumber.compareTo(otherNumber);
            }
            break;
          }
        }

        return result;
      }

      return 0;
    } on Exception catch (err) {
      print(err.toString());
      return 0;
    }
  }
}

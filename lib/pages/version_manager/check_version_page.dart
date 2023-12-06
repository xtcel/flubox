import 'package:flubox/generated/locales.g.dart';
import 'package:flubox/theme/extension_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fvm/fvm.dart';
import 'package:get/get.dart';

/// 切换版本页面
class CheckVersionPage extends StatefulWidget {
  const CheckVersionPage({super.key});

  @override
  _CheckVersionPageState createState() => _CheckVersionPageState();
}

class _CheckVersionPageState extends State<CheckVersionPage> {
  String currentVersion = "";
  CacheVersion? globalVersion;
  List<CacheVersion> versions = [];
  @override
  void initState() {
    super.initState();
    getFlutterReleases();
  }

  void getFlutterReleases() async {
    globalVersion = await FVMClient.getGlobal();
    print("global version: $globalVersion");
    currentVersion = globalVersion?.name ?? "";

    versions = await FVMClient.getCachedVersions();
    print("cached versions :$versions");

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(top: 10, bottom: 20),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Theme.of(context).extension<MyColors>()?.cardBgColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Container(
              // padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.only(bottom: 15),
              child: Row(
                children: [
                  Text(
                    LocaleKeys.labels_installed_versions.tr,
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                child: ListView.separated(
                  itemCount: versions.length,
                  itemBuilder: (BuildContext context, int index) {
                    return SizedBox(
                      height: 60,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    versions[index].name,
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                  // 是否是当前版本
                                  Visibility(
                                      visible: globalVersion != null
                                          ? versions[index]
                                                  .compareTo(globalVersion!) ==
                                              0
                                          : false,
                                      child: globalVersionWidget())
                                ],
                              ),
                            ],
                          ),
                          Expanded(
                            child: Container(),
                          ),
                          PopupMenuButton(
                            itemBuilder: (BuildContext context) {
                              return <PopupMenuEntry<String>>[
                                PopupMenuItem(
                                  value: "setAsGlobal",
                                  child: Text(
                                    LocaleKeys.buttons_setAsGlobal.tr,
                                  ),
                                ),
                                PopupMenuItem(
                                  value: "remove",
                                  child: Text(
                                    LocaleKeys.buttons_remove.tr,
                                  ),
                                ),
                              ];
                            },
                            onSelected: (String value) async {
                              if (value == "setAsGlobal") {
                                // 切换版本
                                await FVMClient.setGlobalVersion(
                                    versions[index]);
                                getFlutterReleases();
                              } else if (value == "remove") {
                                EasyLoading.show(
                                    status: LocaleKeys.tips_removing.tr);
                                await FVMClient.remove(versions[index].name);
                                getFlutterReleases();
                                EasyLoading.dismiss();
                              }
                            },
                            child: const Icon(Icons.more_vert_rounded),
                          ),
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const Divider();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget globalVersionWidget() {
    return Container(
      margin: const EdgeInsets.only(left: 10),
      padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
      decoration: BoxDecoration(
        color: Theme.of(context)
            .extension<MyColors>()
            ?.successBgColor
            ?.withAlpha(25),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        LocaleKeys.labels_global.tr,
        style: Theme.of(context).textTheme.labelMedium?.copyWith(
              color: Theme.of(context).extension<MyColors>()?.successBgColor,
            ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class FlutterIconPage extends StatefulWidget {
  const FlutterIconPage({super.key});

  @override
  _FlutterIconPageState createState() => _FlutterIconPageState();
}

class _FlutterIconPageState extends State<FlutterIconPage> {
  // late List<IconData?> icons;
  List<String> allIconNames = MdiIcons.getNames();
  // 搜索
  late List<String> filteredIconNames;

  @override
  initState() {
    super.initState();

    filteredIconNames = allIconNames;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Flutter Icon Library'),
          automaticallyImplyLeading: false,
          actions: [
            // 关闭按钮
            IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: const Icon(Icons.close))
          ]),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 350,
                  height: 45,
                  child: TextField(
                    // strutStyle: const StrutStyle(
                    //   height: 45,
                    // ),
                    decoration: const InputDecoration(
                      hintText: 'Search',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      setState(() {
                        filteredIconNames = allIconNames
                            .where((iconName) => iconName
                                .toLowerCase()
                                .contains(value.toLowerCase()))
                            .toList();
                      });
                    },
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 10,
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
              ),
              itemCount: filteredIconNames.length,
              itemBuilder: (context, index) {
                var iconName = filteredIconNames.elementAt(index);
                return Column(
                  children: <Widget>[
                    IconButton(
                      icon: Icon(MdiIcons.fromString(iconName)),
                      onPressed: () {
                        Clipboard.setData(ClipboardData(text: iconName));
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text('Copied $iconName to clipboard')),
                        );
                      },
                    ),
                    Text(iconName),
                  ],
                );
              },
            ),
          ),
        ]),
      ),
      // GridView.count(
      //   crossAxisCount: 10,
      //   children: filteredIconNames
      //       .map((iconName) => TextButton(
      //             child: Column(
      //               children: [
      //                 Icon(MdiIcons.fromString(iconName)),
      //                 Text(iconName),
      //               ],
      //             ),
      //             onPressed: () {
      //               Clipboard.setData(ClipboardData(text: iconName.toString()));
      //               ScaffoldMessenger.of(context).showSnackBar(
      //                 SnackBar(
      //                     content: Text(
      //                         'Copied ${iconName.toString()} to clipboard')),
      //               );
      //             },
      //           ))
      //       .toList(),
      // ),
    );
  }
}

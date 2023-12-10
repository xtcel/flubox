import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../../../generated/locales.g.dart';

/// 时间戳页面
import 'dart:async';
import 'package:flutter/material.dart';

class UnixTimestampConverterPage extends StatefulWidget {
  const UnixTimestampConverterPage({super.key});

  @override
  _UnixTimestampConverterPageState createState() =>
      _UnixTimestampConverterPageState();
}

class _UnixTimestampConverterPageState
    extends State<UnixTimestampConverterPage> {
  String _currentTimestamp = '';
  final TextEditingController _timestampController = TextEditingController();
  String _converedTimeString = '';

  final TextEditingController _timeController = TextEditingController();

  String _convertedTimestamp = '';
  bool pauseTimeStamp = false;

  @override
  void initState() {
    super.initState();
    Timer.periodic(
        const Duration(seconds: 1), (Timer t) => _getCurrentTimestamp());
    _timestampController.value = TextEditingValue(
        text: DateTime.now().millisecondsSinceEpoch.toString());
    _timeController.value = TextEditingValue(
        text: DateTime.now().toLocal().toString().substring(0, 19));
  }

  void _getCurrentTimestamp() {
    if (pauseTimeStamp) {
      return;
    }
    setState(() {
      _currentTimestamp = DateTime.now().millisecondsSinceEpoch.toString();
    });
  }

  void _convertToUnixTimestamp() {
    String inputString = _timeController.text;
    DateTime? dateTime = DateTime.tryParse(inputString);
    setState(() {
      _convertedTimestamp = dateTime?.millisecondsSinceEpoch.toString() ?? "";
    });
  }

  void _convertTimestampToDateTime() {
    int timestamp = int.parse(_timestampController.text);
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
    setState(() {
      _converedTimeString = dateTime.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Unix Timestamp Converter'),
        automaticallyImplyLeading: false,
        actions: [
          // 关闭按钮
          IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(Icons.close))
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              children: [
                const Text('Current Timestamp: '),
                TextButton(
                    onPressed: () {
                      // 点击复制时间戳
                      Clipboard.setData(ClipboardData(text: _currentTimestamp));
                      // 设置timeStamp
                      setState(() {
                        _timestampController.value =
                            TextEditingValue(text: _currentTimestamp);
                      });

                      // 已复制
                      EasyLoading.showToast("已复制");
                    },
                    child: Text(_currentTimestamp)),
                const SizedBox(
                  width: 15,
                ),
                // 暂停/恢复按钮
                IconButton(
                    onPressed: () {
                      setState(() {
                        pauseTimeStamp = !pauseTimeStamp;
                      });
                    },
                    icon: Icon(pauseTimeStamp
                        ? Icons.play_circle_outline_rounded
                        : Icons.stop_circle_rounded))
              ],
            ),
            // 时间戳转时间
            Row(
              children: [
                SizedBox(
                  width: 200,
                  child: TextField(
                    controller: _timestampController,
                    decoration:
                        const InputDecoration(hintText: 'Enter Unix Timestamp'),
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                ElevatedButton(
                  onPressed: _convertTimestampToDateTime,
                  child: const Text('Convert ->'),
                ),
                const SizedBox(
                  width: 15,
                ),
                Text(_converedTimeString),
              ],
            ),

            // 时间转时间戳
            Row(
              children: [
                SizedBox(
                  width: 200,
                  child: TextField(
                      controller: _timeController,
                      decoration:
                          const InputDecoration(hintText: 'Unix Time ')),
                ),
                const SizedBox(
                  width: 15,
                ),
                ElevatedButton(
                  onPressed: _convertToUnixTimestamp,
                  child: const Text('Convert ->'),
                ),
                const SizedBox(
                  width: 15,
                ),
                Text(_convertedTimestamp),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// class TimestampPage extends StatefulWidget {
//   @override
//   _TimestampPageState createState() => _TimestampPageState();
// }

// class _TimestampPageState extends State<TimestampPage> {
//   TextEditingController _controller = TextEditingController();
//   String _timestamp = "";

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(LocaleKeys.labels_timestamp.tr),
//       ),
//       body: Container(
//         padding: const EdgeInsets.all(10),
//         child: Column(
//           children: [
//             TextField(
//               controller: _controller,
//               decoration: InputDecoration(
//                 hintText: LocaleKeys.labels_input_timestamp.tr,
//               ),
//             ),
//             const SizedBox(
//               height: 10,
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 String timestamp = _controller.text;
//                 if (timestamp.isEmpty) {
//                   return;
//                 }
//                 int timestampInt = int.parse(timestamp);
//                 DateTime dateTime =
//                     DateTime.fromMillisecondsSinceEpoch(timestampInt);
//                 setState(() {
//                   _timestamp = dateTime.toString();
//                 });
//               },
//               child: Text(LocaleKeys.labels_convert.tr),
//             ),
//             const SizedBox(
//               height: 10,
//             ),
//             Text(_timestamp),
//           ],
//         ),
//       ),
//     );
//   }
// }
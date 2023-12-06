import 'package:flutter/material.dart';
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
  final TextEditingController _yearController = TextEditingController();
  final TextEditingController _monthController = TextEditingController();
  final TextEditingController _dayController = TextEditingController();
  final TextEditingController _hourController = TextEditingController();
  final TextEditingController _minuteController = TextEditingController();
  final TextEditingController _secondController = TextEditingController();
  String _convertedTimestamp = '';
  bool pauseTimeStamp = false;

  @override
  void initState() {
    super.initState();
    Timer.periodic(
        const Duration(seconds: 1), (Timer t) => _getCurrentTimestamp());
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
    int year = int.parse(_yearController.text);
    int month = int.parse(_monthController.text);
    int day = int.parse(_dayController.text);
    int hour = int.parse(_hourController.text);
    int minute = int.parse(_minuteController.text);
    int second = int.parse(_secondController.text);
    DateTime dateTime = DateTime(year, month, day, hour, minute, second);
    setState(() {
      _convertedTimestamp = dateTime.millisecondsSinceEpoch.toString();
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
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              children: [
                Text('Current Timestamp: $_currentTimestamp'),
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
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 55,
                  child: TextField(
                      controller: _yearController,
                      decoration: const InputDecoration(hintText: 'Year')),
                ),
                SizedBox(
                  width: 55,
                  child: TextField(
                      controller: _monthController,
                      decoration: const InputDecoration(hintText: 'Month')),
                ),
                SizedBox(
                  width: 55,
                  child: TextField(
                      controller: _dayController,
                      decoration: const InputDecoration(hintText: 'Day')),
                ),
                SizedBox(
                  width: 55,
                  child: TextField(
                      controller: _hourController,
                      decoration: const InputDecoration(hintText: 'Hour')),
                ),
                SizedBox(
                  width: 55,
                  child: TextField(
                      controller: _minuteController,
                      decoration: const InputDecoration(hintText: 'Minute')),
                ),
                SizedBox(
                  width: 55,
                  child: TextField(
                      controller: _secondController,
                      decoration: const InputDecoration(hintText: 'Second')),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: _convertToUnixTimestamp,
              child: const Text('Convert to Unix Timestamp'),
            ),
            Text('Converted Timestamp: $_convertedTimestamp'),
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
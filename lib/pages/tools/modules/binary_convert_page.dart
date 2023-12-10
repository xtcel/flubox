import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BinaryConvertPage extends StatefulWidget {
  const BinaryConvertPage({super.key});

  @override
  _BinaryConvertPageState createState() => _BinaryConvertPageState();
}

class _BinaryConvertPageState extends State<BinaryConvertPage> {
  String _input = '';
  String _output = '';
  int _inputBase = 10;
  int _outputBase = 10;

  void _convert() {
    setState(() {
      _output = int.parse(_input, radix: _inputBase).toRadixString(_outputBase);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Binary Convert'),
          automaticallyImplyLeading: false,
          actions: [
            // 关闭按钮
            IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: const Icon(Icons.close))
          ]),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            TextField(
              onChanged: (value) {
                setState(() {
                  _input = value;
                });
              },
              decoration: const InputDecoration(
                labelText: 'Enter a number',
              ),
            ),
            DropdownButton<int>(
              value: _inputBase,
              onChanged: (int? newValue) {
                setState(() {
                  _inputBase = newValue!;
                });
              },
              items: <int>[2, 4, 8, 10, 16, 32]
                  .map<DropdownMenuItem<int>>((int value) {
                return DropdownMenuItem<int>(
                  value: value,
                  child: Text('Base $value'),
                );
              }).toList(),
            ),
            DropdownButton<int>(
              value: _outputBase,
              onChanged: (int? newValue) {
                setState(() {
                  _outputBase = newValue!;
                });
              },
              items: <int>[2, 4, 8, 10, 16, 32]
                  .map<DropdownMenuItem<int>>((int value) {
                return DropdownMenuItem<int>(
                  value: value,
                  child: Text('Base $value'),
                );
              }).toList(),
            ),
            TextButton(
              onPressed: _convert,
              child: const Text('Convert'),
            ),
            Text('Output: $_output'),
          ],
        ),
      ),
    );
  }
}

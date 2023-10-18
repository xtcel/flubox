import 'package:bruno/bruno.dart';
import 'package:flutter/material.dart';

class UnknownRoutePage extends StatelessWidget {
  const UnknownRoutePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: BrnAppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          BrnAbnormalStateWidget(
            img: Image.asset(
              'images/driver_withoutCar.png',
              scale: 3.0,
            ),
            isCenterVertical: true,
            title: "页面消失了",
          )
        ],
      ),
    );
  }
}

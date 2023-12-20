import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../router/app_routers.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({super.key});

  @override
  _SplashScreenState createState() {
    return _SplashScreenState();
  }
}

class _SplashScreenState extends State<SplashScreenPage> {
  @override
  void initState() {
    super.initState();

    // 跳转到首页
    Future.delayed(const Duration(seconds: 1), () {
      Get.toNamed(Routers.root);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Flex(
        direction: Axis.vertical,
        children: [
          Expanded(
            flex: 1,
            child: Container(),
          ),
          SizedBox(child: Image.asset("assets/images/logo.png")),
          Text("FluBox", style: Theme.of(context).textTheme.titleLarge),
          Expanded(
            flex: 1,
            child: Container(),
          ),
        ],
      ),
    );
  }
}

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
    Future.delayed(const Duration(milliseconds: 1), () {
      Get.toNamed(Routers.root);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Flex(
        direction: Axis.vertical,
        children: [
          Expanded(
            flex: 1,
            child: Container(),
          ),
          const SizedBox(
              child: Icon(Icons
                  .logo_dev_rounded)), //Image.asset("assets/images/logo.png")),
          Expanded(
            flex: 2,
            child: Container(),
          ),
        ],
      ),
    );
  }
}

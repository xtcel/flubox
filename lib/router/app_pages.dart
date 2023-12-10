import 'package:flubox/pages/projects/project_detial/apps/resource_manager/resource_manager_page.dart';
import 'package:flubox/pages/projects/project_detial/project_detail_page.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import '../pages/tools/modules/binary_convert_page.dart';
import '../pages/tools/modules/flutter_icons_page.dart';
import '../pages/tools/modules/timestamp_page.dart';
import 'app_routers.dart';
import '../pages/application/splash_screen_page.dart';
import '../pages/home/HomePage.dart';

class AppPages {
  /// 通用模块
  static final List<GetPage> commonPages = [
    /// 系统异常页面
    // GetPage(name: Routers.systemErrorPage, page: () => const SystemErrorPage()),

    /// webview页面
    // GetPage(name: Routers.webViewPage, page: () => const WebViewPage()),
    // 语言设置页面
    // GetPage(
    //     name: Routers.languageSettingPage,
    //     page: () => const LanguageSettingPage()),
  ];

  /// export
  static final List<GetPage> getPages = [
    ...commonPages,
    GetPage(name: Routers.root, page: () => const HomePage()),
    GetPage(
      name: Routers.splashScreen,
      page: () => const SplashScreenPage(),
    ),
    GetPage(
        name: Routers.projectDetailPage, page: () => const ProjectDetailPage()),
    GetPage(
        name: Routers.resourceManagerPage,
        page: () => const ResourceManagerPage()),
    // 时间戳转换工具页面
    GetPage(
      name: Routers.unixTimeConvertPage,
      page: () => const UnixTimestampConverterPage(),
      // 设置跳转动画为从下到上
      transition: Transition.upToDown,
    ),
    // 进制转换页面
    GetPage(
      name: Routers.binaryConvertPage,
      page: () => const BinaryConvertPage(),
      // 设置跳转动画为从下到上
      transition: Transition.upToDown,
    ),
    // flutter 图标库页面
    GetPage(
      name: Routers.flutterIconsPage,
      page: () => const FlutterIconPage(),
      // 设置跳转动画为从下到上
      transition: Transition.upToDown,
    ),
  ];
}

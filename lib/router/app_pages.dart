import 'package:get/get_navigation/src/routes/get_route.dart';
import 'app_routers.dart';
import 'pages/application/splash_screen_page.dart';
import 'pages/home/HomePage.dart';

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
    // GetPage(
    //     name: Routers.firstLaunchUsageAgreement,
    //     page: () => const FirstLaunchUsageAgreementPage(),
    //     binding: AppBinding()),
    // GetPage(
    //   name: Routers.loginPage,
    //   page: () => LoginPage(),
    //   // binding: TestOneBinding(),
    // ),
    // GetPage(name: Routers.testPage, page: () => const TestPage()),
    // GetPage(name: Routers.setting, page: () => const SettingPage()),
    // GetPage(name: Routers.settingProxy, page: () => const SettingProxyPage()),
  ];
}

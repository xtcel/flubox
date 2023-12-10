import 'dart:io';

import 'package:bruno/bruno.dart';
import 'package:flubox/pages/projects/projects_page.dart';
import 'package:flubox/router/app_routers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:window_manager/window_manager.dart';

import 'generated/locales.g.dart';
import 'pages/projects/project.dto.dart';
import 'pages/projects/projects.service.dart';
import 'pages/settings/settings.dto.dart';
import 'pages/settings/settings.service.dart';
import 'utils/ChineseCupertinoLocalizations.dart';
import 'router/app_pages.dart';
import 'pages/404/unknown_route_page.dart';
import 'theme/theme_config.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';

import 'utils/package_info_util.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  realRunApp();
}

void realRunApp() async {
  // 初始化get_storage
  await GetStorage.init();
  await windowManager.ensureInitialized();

  final Directory hiveDir = await getApplicationSupportDirectory();
  // List<String> paths = hiveDir.path.split('/');
  // paths.removeLast();
  // final Directory appDir = Directory('${paths.join('/')}/com.fvm.sidekick');

  // const projects_key = 'projects_service_box';

  /// copy sidekick hive db to hiveDir
  // final File sidekickHiveDb = File('${appDir.path}/$projects_key.hive');
  // if (!sidekickHiveDb.existsSync()) {
  //   sidekickHiveDb.copySync('${hiveDir.path}/$projects_key.hive');
  // }

  Hive.init(hiveDir.absolute.path);

  Hive.registerAdapter(ProjectPathAdapter());
  Hive.registerAdapter(SidekickSettingsAdapter());

  try {
    await SettingsService.init();
    await ProjectsService.init();
  } on FileSystemException {
    //print('There was an issue opening the DB');
  }

  if (!(Platform.isWindows || Platform.isLinux || Platform.isMacOS)) {
    //print('Sidekick is not supported on your platform');
    exit(0);
  }

  WindowOptions windowOptions = const WindowOptions(
    size: Size(1000, 720),
    center: true,
    backgroundColor: Colors.transparent,
    skipTaskbar: false,
    titleBarStyle: TitleBarStyle.hidden,
  );
  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });

  PackageInfoUtil.getInstance();

  if (kDebugMode) {
    // 应用内调试工具
    // PluginManager.instance // 注册插件
    //   ..register(const WidgetInfoInspector())
    //   ..register(const WidgetDetailInspector())
    //   ..register(const ColorSucker())
    //   ..register(AlignRuler())
    //   ..register(const ColorPicker()) // 新插件
    //   ..register(const TouchIndicator()) // 新插件
    //   ..register(Performance())
    //   ..register(const ShowCode())
    //   ..register(const MemoryInfoPage())
    //   ..register(CpuInfoPage())
    //   ..register(const DeviceInfoPanel())
    //   ..register(Console())
    //   ..register(DioInspector(dio: HttpManager().client)); // 传入你的 Dio 实例
    runApp(const MyApp());
  } else {
    runApp(const MyApp());
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flubox',
      debugShowCheckedModeBanner: false,
      // theme: ThemeData(
      //   // This is the theme of your application.
      //   //
      //   // TRY THIS: Try running your application with "flutter run". You'll see
      //   // the application has a blue toolbar. Then, without quitting the app,
      //   // try changing the seedColor in the colorScheme below to Colors.green
      //   // and then invoke "hot reload" (save your changes or press the "hot
      //   // reload" button in a Flutter-supported IDE, or press "r" if you used
      //   // the command line to start the app).
      //   //
      //   // Notice that the counter didn't reset back to zero; the application
      //   // state is not lost during the reload. To reset the state, use hot
      //   // restart instead.
      //   //
      //   // This works for code too, not just values: Most code changes can be
      //   // tested with just a hot reload.
      //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      //   useMaterial3: true,
      // ),
      home: MyHomePage(title: 'Flubox Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final settings = SettingsService.read();
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, widget) {
        return GetMaterialApp(
            title: 'Flubox',
            // navigatorKey: rootNavigatorKey,
            // theme: LeLeThemeConfig.defaultTheme,
            // darkTheme: LeLeThemeConfig.darkTheme,
            theme: FlexThemeData.light(scheme: FlexScheme.hippieBlue),
            // The Mandy red, dark theme.
            darkTheme: FlexThemeData.dark(scheme: FlexScheme.hippieBlue),
            themeMode: ThemeMode.system,
            // 去掉模拟器调试debug标识
            debugShowCheckedModeBanner: false,
            initialRoute: Routers.splashScreen,
            getPages: AppPages.getPages,
            unknownRoute: GetPage(
                name: '/notfound', page: () => const UnknownRoutePage()),
            translationsKeys: AppTranslation.translations,
            // 默认使用设备系统选择语言
            locale: settings.locale ?? Get.deviceLocale,
            // 失败使用中文语言
            fallbackLocale: const Locale('en', 'US'),
            localizationsDelegates: [
              ChineseCupertinoLocalizations.delegate, // 自定义的delegate
              DefaultCupertinoLocalizations.delegate, // 默认的只支持英文
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              BrnLocalizationDelegate.delegate,
              // RefreshLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('zh', 'CH'),
              Locale('en', 'US'),
            ],
            builder: EasyLoading.init(
                builder: (context, child) => Material(child: child))
            // need set root widget to material, fix "No Material widget found" bugs,
            // home: const MyHomePage(title: 'Flutter Demo Home Page'),
            );
      },
    );
  }
}

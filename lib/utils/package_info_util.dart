import 'package:package_info_plus/package_info_plus.dart';

class PackageInfoUtil {
  static late PackageInfo packageInfo;
  static Future<bool> getInstance() async {
    try {
      packageInfo = await PackageInfo.fromPlatform();
    } catch (e) {
      print(e);
    }
    return true;
  }

  static String get appName => packageInfo.appName;
  static String get packageName => packageInfo.packageName;
  static String get version => packageInfo.version;
}

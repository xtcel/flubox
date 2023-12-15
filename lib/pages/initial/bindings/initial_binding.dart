import 'package:flubox/pages/version_manager/controller/version_controller.dart';
import 'package:get/get.dart';

import '../../settings/settings_controller.dart';
import '../controllers/initial_controller.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SettingsController>(() => SettingsController());
    Get.lazyPut<InitialController>(() => InitialController());
    Get.lazyPut<VersionController>(() => VersionController());
  }
}

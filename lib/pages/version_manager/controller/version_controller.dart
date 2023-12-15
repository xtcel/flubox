import 'dart:convert';

import 'package:async/async.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fvm/fvm.dart';
import 'package:get/get.dart';

import '../../settings/settings.service.dart';
import '../state/versions_state.dart';

class VersionController extends GetxController {
  VersionsState state = VersionsState();

  @override
  void onInit() {
    // TODO: implement onInit
    // 监听 console 输出
    final fvmStdoutStream = StreamGroup.mergeBroadcast(_getConsoleStreams())
        .transform(utf8.decoder);
    fvmStdoutStream.listen((event) {
      state.lines.insert(0, event ?? '');
      if (state.lines.length > 100) {
        state.lines.removeAt(state.lines.length - 1);
      }
      update();
    });

    super.onInit();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    // fvmStdoutStream.cancel();

    super.onClose();
  }

  void toggleExpand() {
    state.expand = !state.expand;
    update();
  }

  ///  Adds install action to queue
  void install(
    Release version, {
    bool? skipSetup,
  }) async {
    FvmSettings settings = await fvmSettings();
    skipSetup ??= settings.skipSetup;
    final action =
        skipSetup ? QueueAction.install : QueueAction.installAndSetup;

    await _addToQueue(version, action: action);
  }

  Future<void> _addToQueue(
    Release version, {
    required QueueAction action,
  }) async {
    // i18next = context.i18next;
    state.queue.add(QueueItem(release: version, action: action));
    // state = state.update();
    update();

    runQueue();
  }

  /// Runs queue
  void runQueue() async {
    try {
      final queue = state.queue;
      final activeItem = state.activeItem;
      // No need to run if empty
      if (queue.isEmpty) return;
      // If currently installing a version
      if (activeItem != null) return;
      // Gets next item of the queue
      final item = state.next;

      if (item == null) return;
      // Update queue
      // state = state.update();
      update();

      // Run through actions
      switch (item.action) {
        case QueueAction.install:
          await FVMClient.install(item.release.version);

          break;
        case QueueAction.setupOnly:
          await FVMClient.setup(item.release.version);

          break;
        case QueueAction.installAndSetup:
          await FVMClient.install(item.release.version);
          await FVMClient.setup(item.release.version);

          break;
        case QueueAction.channelUpgrade:
          // await FVMClient.upgradeChannel(item.release.cache!);

          break;
        case QueueAction.remove:
          await FVMClient.remove(item.release.version);

          break;
        case QueueAction.setGlobal:
          // await FVMClient.setGlobalVersion(item.release.cache!);

          break;
        default:
          break;
      }
    } on Exception catch (e) {
      // notifyError(e.toString());
      EasyLoading.showToast(e.toString());
    }

    // Set active item to null
    state.activeItem = null;
    // Run update on cache
    // await ref.read(fvmCacheProvider.notifier).reloadState();
    // Update queue
    // state = state.update();
    update();

    // Run queue again
    runQueue();
  }

  List<Stream<List<int>>> _getConsoleStreams() {
    return [
      FVMClient.console.stdout.stream,
      FVMClient.console.stderr.stream,
      FVMClient.console.warning.stream,
      FVMClient.console.info.stream,
      FVMClient.console.fine.stream,
      FVMClient.console.error.stream,
    ];
  }

  /// Retrieve FVM Settings
  Future<FvmSettings> fvmSettings() async {
    final fvmSettings = await FVMClient.readSettings();
    return fvmSettings;
  }
}

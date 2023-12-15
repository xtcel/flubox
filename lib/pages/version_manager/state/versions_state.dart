import 'dart:collection';

import 'package:fvm/fvm.dart';

class VersionsState {
  late bool expand;

  QueueItem? activeItem;
  final Queue<QueueItem> queue = Queue();

  // console lines
  late List<String> lines;

  VersionsState() {
    expand = false;
    lines = [''];
  }

  QueueItem? get next {
    activeItem = queue.removeFirst();
    return activeItem;
  }

  // FvmQueue update() {
  //   return FvmQueue(activeItem: activeItem, queue: queue);
  // }
}

class QueueItem {
  final Release release;
  final QueueAction action;
  QueueItem({required this.release, required this.action});
}

enum QueueAction {
  setupOnly,
  install,
  installAndSetup,
  channelUpgrade,
  remove,
  setGlobal,
}

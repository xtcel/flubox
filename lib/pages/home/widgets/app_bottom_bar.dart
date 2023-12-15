import 'package:flubox/pages/home/widgets/console.dart';
import 'package:flubox/pages/version_manager/controller/version_controller.dart';
import 'package:flubox/pages/version_manager/state/versions_state.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';

class AppBottomBar extends StatelessWidget {
  const AppBottomBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final actions = ref.watch(fvmQueueProvider);
    // final expand = useState(false);

    return GetBuilder<VersionController>(builder: (controller) {
      VersionsState state = controller.state;
      final processing = state.activeItem != null;

      if (!processing) {
        return Container(height: 0);
      }
      return AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        constraints: state.expand && processing
            ? const BoxConstraints(maxHeight: 141)
            : const BoxConstraints(maxHeight: 41),
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            state.activeItem != null
                ? const LinearProgressIndicator(minHeight: 1)
                : const Divider(height: 1),
            Expanded(
              child: Console(
                expand: state.expand,
                onExpand: controller.toggleExpand,
                processing: processing,
                lines: state.lines,
              ),
            )
          ],
        ),
      );
    });
  }
}

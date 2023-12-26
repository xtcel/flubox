import 'dart:io';

import 'package:bitsdojo_window/bitsdojo_window.dart'
    hide MinimizeWindowButton, MaximizeWindowButton, RestoreWindowButton;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppNavBar extends StatelessWidget implements PreferredSizeWidget {
  /// Constructor
  const AppNavBar({key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(32);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: null,
      backgroundColor: Colors.transparent,
      centerTitle: Platform.isWindows ? false : true,
      titleSpacing: 0,
      leading: Platform.isMacOS ? const WindowButtons() : null,
      actions: [
        const SizedBox(width: 10),
        if (!Platform.isMacOS) const WindowButtons(),
      ],
      bottom: !Platform.isWindows
          ? const PreferredSize(
              preferredSize: Size.fromHeight(1),
              child: Divider(
                height: 0,
                thickness: 0.5,
              ),
            )
          : null,
      automaticallyImplyLeading: false,
      flexibleSpace: MoveWindow(),
    );
  }
}

class WindowButtons extends StatelessWidget {
  const WindowButtons({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final buttonColors = WindowButtonColors(
      iconNormal: Theme.of(context).brightness == Brightness.dark
          ? Colors.white
          : Colors.black,
      mouseOver: Theme.of(context).brightness == Brightness.dark
          ? Colors.grey.shade600
          : Colors.grey.shade300,
      mouseDown: Theme.of(context).brightness == Brightness.dark
          ? Colors.grey.shade700
          : Colors.grey.shade400,
      iconMouseOver: Theme.of(context).brightness == Brightness.dark
          ? Colors.white
          : Colors.black,
      iconMouseDown: Theme.of(context).brightness == Brightness.dark
          ? Colors.white
          : Colors.black,
      normal: Theme.of(context).colorScheme.surface,
    );

    final closeButtonColors = WindowButtonColors(
      mouseOver: const Color(0xFFD32F2F),
      mouseDown: const Color(0xFFB71C1C),
      iconNormal: Theme.of(context).brightness == Brightness.dark
          ? Colors.white
          : Colors.black,
      iconMouseOver: Colors.white,
      normal: Theme.of(context).colorScheme.surface,
    );
    return Row(
      children: [
        MinimizeWindowButton(colors: buttonColors, animate: true),
        MaximizeWindowButton(colors: buttonColors, animate: true),
        CloseWindowButton(colors: closeButtonColors, animate: true),
      ],
    );
  }
}

const sidebarColor = Color(0xFFF6A00C);

class LeftSide extends StatelessWidget {
  const LeftSide({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 200,
        child: Container(
            color: sidebarColor,
            child: Column(
              children: [
                WindowTitleBarBox(child: MoveWindow()),
                Expanded(child: Container())
              ],
            )));
  }
}

const backgroundStartColor = Color(0xFFFFD500);
const backgroundEndColor = Color(0xFFF6A00C);

class RightSide extends StatelessWidget {
  const RightSide({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [backgroundStartColor, backgroundEndColor],
                  stops: [0.0, 1.0]),
            ),
            child: Column(children: [
              WindowTitleBarBox(
                  child: Row(children: [
                Expanded(child: MoveWindow()),
                const WindowButtons()
              ])),
            ])));
  }
}

class MinimizeWindowButton extends WindowButton {
  MinimizeWindowButton(
      {Key? key,
      WindowButtonColors? colors,
      VoidCallback? onPressed,
      bool? animate})
      : super(
            key: key,
            colors: colors,
            animate: animate ?? false,
            padding: EdgeInsets.zero,
            iconBuilder: (buttonContext) =>
                MinimizeIcon(color: buttonContext.iconColor),
            onPressed: onPressed ?? () => appWindow.minimize());
}

class MaximizeWindowButton extends WindowButton {
  MaximizeWindowButton(
      {Key? key,
      WindowButtonColors? colors,
      VoidCallback? onPressed,
      bool? animate})
      : super(
            key: key,
            colors: colors,
            animate: animate ?? false,
            padding: EdgeInsets.zero,
            iconBuilder: (buttonContext) =>
                MaximizeIcon(color: buttonContext.iconColor),
            onPressed: onPressed ?? () => appWindow.maximizeOrRestore());
}

class RestoreWindowButton extends WindowButton {
  RestoreWindowButton(
      {Key? key,
      WindowButtonColors? colors,
      VoidCallback? onPressed,
      bool? animate})
      : super(
            key: key,
            colors: colors,
            animate: animate ?? false,
            padding: EdgeInsets.zero,
            iconBuilder: (buttonContext) =>
                RestoreIcon(color: buttonContext.iconColor),
            onPressed: onPressed ?? () => appWindow.maximizeOrRestore());
}

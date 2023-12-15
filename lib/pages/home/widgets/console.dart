import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'typography.dart';

class Console extends StatelessWidget {
  final bool expand;
  final bool processing;
  final Function()? onExpand;
  final List<String> lines;

  const Console({
    this.expand = false,
    this.processing = false,
    this.onExpand,
    required this.lines,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final output = useStream(fvmStdoutProvider);
    // final lines = useState<List<String>>(['']);

    // useEffect(() {
    //   lines.value.insert(0, output.data ?? '');
    //   if (lines.value.length > 100) {
    //     lines.value.removeAt(lines.value.length - 1);
    //   }
    //   return;
    // }, [output]);

    return AnimatedCrossFade(
      duration: const Duration(milliseconds: 250),
      crossFadeState:
          processing ? CrossFadeState.showSecond : CrossFadeState.showFirst,
      firstChild: Container(
        color: Theme.of(context).brightness == Brightness.dark
            ? Colors.black45
            : const Color(0xFFF5F5F5),
        height: 40,
        child: Container(),
      ),
      secondChild: GestureDetector(
        onTap: onExpand,
        child: AnimatedContainer(
          color: Theme.of(context).brightness == Brightness.dark
              ? Colors.black45
              : const Color(0xFFF5F5F5),
          height: expand ? 160 : 40,
          duration: const Duration(milliseconds: 250),
          constraints: expand
              ? const BoxConstraints(maxHeight: 160)
              : const BoxConstraints(maxHeight: 40),
          child: Stack(
            children: [
              AnimatedCrossFade(
                duration: const Duration(milliseconds: 250),
                crossFadeState: expand
                    ? CrossFadeState.showSecond
                    : CrossFadeState.showFirst,
                firstChild: Container(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                          width: MediaQuery.of(context).size.width - 100,
                          child: ConsoleText(lines.first)),
                    ],
                  ),
                ),
                secondChild: CupertinoScrollbar(
                  child: ListView.builder(
                    primary: false,
                    shrinkWrap: true,
                    reverse: true,
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                    itemBuilder: (context, index) {
                      final line = lines[index];

                      return ConsoleText(line);
                    },
                    itemCount: lines.length,
                  ),
                ),
              ),
              Positioned(
                top: 0,
                right: 0,
                child: Row(
                  children: [
                    SpinKitFadingFour(
                      color: Theme.of(context).colorScheme.secondary,
                      size: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 8),
                      child: expand
                          ? Icon(MdiIcons.chevronDown)
                          : Icon(MdiIcons.chevronUp),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

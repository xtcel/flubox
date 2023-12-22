import 'package:flubox/generated/locales.g.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class ProjectsEmpty extends StatelessWidget {
  const ProjectsEmpty({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Column(children: [
        const SizedBox(height: 100),
        Icon(
          MdiIcons.folderMultipleOutline,
        ),
        const SizedBox(height: 10),
        Text(
          LocaleKeys.labels_no_projects_yet.tr,
          style: theme.textTheme.titleLarge,
        ),
        const SizedBox(height: 20),
        Text(
          LocaleKeys.labels_no_projects_yet_desc.tr,
          style: theme.textTheme.bodyMedium,
        ),
      ]),
    );
  }
}

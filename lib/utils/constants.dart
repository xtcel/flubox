import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../generated/locales.g.dart';

/// Sidekick title
const kAppTitle = 'Sidekick';

/// Sidekick app name
const kAppName = 'sidekick';

/// Sidekick bundle id
const kAppBundleId = 'app.fvm.sidekick';

/// Collapsed width
const kNavigationWidth = 65.0;

/// Extended navigation width
const kNavigationWidthExtended = 180.0;

/// Channels without master
const kReleaseChannels = ['stable', 'beta', 'dev'];

/// Master channel
const kMasterChannel = 'master';

/// Github sidekick url
const kGithubSidekickUrl = 'https://github.com/leoafarias/sidekick';

const kSidekickLatestReleaseUrl =
    'https://api.github.com/repos/leoafarias/sidekick/releases/latest';

/// Flutter tags
const kFlutterTagsUrl = 'https://github.com/flutter/flutter/releases/tag/';

/// Description for the channels
Map<String, String> channelDescriptions(BuildContext context) => {
      'stable': LocaleKeys.labels_common_stableChannelDescription
          .tr, //  context.i18n('modules:common.stableChannelDescription'),
      'beta': LocaleKeys.labels_common_betaChannelDescription
          .tr, // context.i18n('modules:common.betaChannelDescription'),
      'dev': LocaleKeys.labels_common_devChannelDescription
          .tr, // context.i18n('modules:common.devChannelDescription'),
      'master': LocaleKeys.labels_common_masterChannelDescription
          .tr, // context.i18n('modules:common.masterChannelDescription'),
    };

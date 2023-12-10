import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:get/get.dart';

import 'color_configs.dart';
import 'extension_theme.dart';

class LeLeThemeConfig {
  /// 默认主题配置
  static ThemeData defaultTheme = ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primaryColor: LeLeThemeConfig.defaultPrimaryColor,
      fontFamily: "PingFang SC",
      cardTheme: CardTheme(
        elevation: 0,
        margin: const EdgeInsets.all(0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
        color: Colors.white,
      ),
      dividerColor: ColorConfigs.chartLine,
      cardColor: ColorConfigs.cardColor,
      textTheme: const TextTheme(
        titleLarge: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
        titleMedium: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
        titleSmall: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
        bodySmall: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w400,
        ),
      ),
      // colorScheme: const ColorScheme.highContrastLight()
      //     .copyWith(background: const Color(0xFFE5E5E5)),
      extensions: const [MyColors.light]);

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    primaryColor: LeLeThemeConfig.defaultPrimaryColor,
    fontFamily: "PingFang SC",
    cardTheme: CardTheme(
      elevation: 0,
      margin: const EdgeInsets.all(0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6),
      ),
      color: Colors.white,
    ),
    dividerColor: ColorConfigs.chartLine,
    textTheme: const TextTheme(
      titleLarge: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
      titleMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
      titleSmall: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
      bodyLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
      bodySmall: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
      ),
    ),
    extensions: const [MyColors.dark],
  );

  /// rootTheme
  static ThemeData rootTheme = Theme.of(Get.context!);

  /// 默认主题颜色
  static Color defaultPrimaryColor = ColorConfigs.parmary;

  // /// 默认下拉刷新头部
  // static ClassicalHeader defaultRefreshHeaderWidget = ClassicalHeader(
  //     refreshText: LeLeConfig.refreshString,
  //     refreshReadyText: LeLeConfig.refreshReadyString,
  //     refreshingText: LeLeConfig.refreshingString,
  //     refreshedText: LeLeConfig.refreshedString,
  //     showInfo: false);

  // /// 默认上拉加载尾部
  // static ClassicalFooter defaultRefreshFooterWidget = ClassicalFooter(
  //   showInfo: false,
  //   noMoreText: LeLeConfig.noMoreString,
  //   loadText: LeLeConfig.loadString,
  //   loadReadyText: LeLeConfig.loadReadyString,
  //   loadingText: LeLeConfig.loadingString,
  //   loadedText: LeLeConfig.loadedString,
  //   loadFailedText: LeLeConfig.loadFailedString,
  // );
}

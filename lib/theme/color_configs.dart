import 'package:flutter/material.dart';

class ColorConfigs {
  /// 主色/品牌色/强调色
  static const Color parmary = Color(0xFF367BF5);
  static const Color secondary = Color(0xFF54A0F5);

  /// 正常色
  static const Color normal = Color(0xFF2A83F3);
  static const Color normalSecondary = Color(0xFF54A0F5);
  static const Color normalBackground = Color(0xFFCAE9FF);
  static const Color normalBorder = Color(0xFF6E9FFF);

  /// 成功色调
  static const Color success = Color(0xFF05B88D);
  static const Color successSecondary = Color(0xFF0ea954);
  static const Color successBorder = Color(0xFF23C36F);
  static const Color successBackground = Color(0xFFC0F5E9);

  /// 警告色调
  static const Color warning = Color(0xFFF4AB58);
  static const Color warningSecondary = Color(0xFFFAAD1F);
  static const Color warningBorder = Color(0xFFFA9B2E);
  static const Color warningBackground = Color(0xFFFEEFDE);

  /// 错误色调
  static const Color error = Color(0xFFEE5353);
  static const Color errorSecondary = Color(0xFFFB5E5E);
  static const Color errorBorder = Color(0xFFF35959);

  /// theme colors
  static const Color strock = Color(0xFFF0F0F0);
  static const Color yellow = Color(0xFFFFA600);
  static const Color black2 = Color(0xFF141736);
  static const Color black1 = Color(0xFF161736);
  static const Color gray = Color(0xFFA5B4CB);
  static const Color gray2 = Color(0xFF7D8DA6);
  static const Color green = Color(0xFF6ED097);
  static const Color red = Color(0xFFFE6470);
  static const Color blue = Color(0xFF0177FB);
  static const Color natural = Color(0xFF333333);
  static const Color natural7 = Color(0xFFEFEFEF);
  static const Color chartLine = Color(0xFFEAEAF6);
  static const Color gray3 = Color(0x1AA5B4CB);
  static const Color cardColor = Color(0xFFFAFAFB);

  /// 文本颜色
  /// 主要文字颜色
  static const Color bodyText = Color(0xFF222222);

  /// 辅助文字颜色(说明)
  static const Color secondaryText = Color(0xFF555555);

  /// 提示文字颜色
  static const Color hintTextColor = Color(0xFF999999);

  /// 警告文字颜色
  static const Color warningTextColor = Color(0xFFF08304);

  /// 错误文字颜色
  static const Color errorText = Color(0xFFEB1C1C);

  /// 成功文字颜色
  static const Color successText = Color(0xFF13A481);

  /// 背景色
  /// 警告背景色
  static const Color warningBg = Color(0xFFFFF7E2);

  /// 错误背景色
  static const Color errorBg = Color(0xFFFFE6E6);

  /// 成功背景色
  static const Color successBg = Color(0xFF01D7DF);

  /// app背景颜色
  static const Color bg = Color(0xFFF1F3F5);

  static const Color appBarDarkBg = Color(0xFF353D4A);

  /// 按钮颜色
  static const Color btnBg = Color(0xFF095DF5);

  static const Color btnBgDisable = Color(0xFF909090);

  ///自定义色系
  static Color white = Colors.white;
  static Color darkRed = const Color(0xFFEC3C3C);
  static Color pink = const Color(0xFFFFEEE9);
  static Color btnGreyBg = const Color(0xFFBDC0C5);
  static Color switchGreyBg = const Color(0xFFEDF1F7);
  static Color orange = const Color(0xFFFF7B2B);
  static const Color dash = Color(0xFF949494);
  static const Color divider = Color(0xFFE3E7F4);

  /// 暂停接单背景色
  static const Color pauseReceiveOrderBg = Color(0xFFFFEDED);

  /// 箭头颜色
  static const Color arrowIconColor = Color(0xFFA0A0A0);

  ///透明黑色
  static const Map<int, Color> blackTransparent = {
    10: Color.fromRGBO(0, 0, 0, 0.1),
    20: Color.fromRGBO(0, 0, 0, 0.2),
    30: Color.fromRGBO(0, 0, 0, 0.3),
    40: Color.fromRGBO(0, 0, 0, 0.4),
    50: Color.fromRGBO(0, 0, 0, 0.5),
    60: Color.fromRGBO(0, 0, 0, 0.6),
    70: Color.fromRGBO(0, 0, 0, 0.7),
    80: Color.fromRGBO(0, 0, 0, 0.8),
    90: Color.fromRGBO(0, 0, 0, 0.9),
    100: Color.fromRGBO(0, 0, 0, 1),
  };

  ///透明白色
  static Map<int, Color> whiteTransparent = {
    3: const Color.fromRGBO(255, 255, 255, 0.03),
    10: const Color.fromRGBO(255, 255, 255, 0.1),
    20: const Color.fromRGBO(255, 255, 255, 0.2),
    30: const Color.fromRGBO(255, 255, 255, 0.3),
    40: const Color.fromRGBO(255, 255, 255, 0.4),
    50: const Color.fromRGBO(255, 255, 255, 0.5),
    60: const Color.fromRGBO(255, 255, 255, 0.6),
    70: const Color.fromRGBO(255, 255, 255, 0.7),
    76: const Color.fromRGBO(255, 255, 255, 0.76),
    80: const Color.fromRGBO(255, 255, 255, 0.8),
    90: const Color.fromRGBO(255, 255, 255, 0.9),
  };

  ///title颜色
  static Color title = const Color(0xFF252D3B);

  ///主色调
  static const Color main = Color.fromRGBO(37, 45, 59, 1);

  /// 主app 色调
  static Color colorMainColor = const Color.fromRGBO(37, 45, 59, 1);

  /// 副app 色调
  static Color colorSubColor = Colors.white;

  /// 副app bar title色调
  static Color colorSubAppBarTitle = const Color.fromRGBO(37, 45, 59, 1);

  ///按钮颜色
  static Color colorButton = const Color.fromRGBO(253, 210, 105, 1);

  ///副标题灰色
  static Color colorTextGrey = const Color.fromRGBO(137, 139, 140, 1);

  /// 页面背景色调
  static Color pageBackgroundColor = const Color.fromRGBO(237, 241, 247, 1);

  /// 表头字体加粗
  static FontWeight appbarTitleFontWeight = FontWeight.bold;

  /// 时间线（线）
  static const Color timelineConnectLine = Color(0xFFEDF1F7);
  static Color timelineDot = const Color(0xFF3377FF);
  static Color timeline = const Color(0xFFD8D8D8);

  ///线的颜色
  static Color color_line = const Color.fromRGBO(237, 241, 247, 1);
  static const Color color_line_221 = Color.fromRGBO(221, 221, 221, 1);
  static Color color_line_228 = const Color.fromRGBO(228, 231, 237, 1);
  static const Color color_line_dark = Color(0xFFE3E7F4);

  /// 订单列表分隔线
  static Color orderDivider = const Color(0xFFE3E7F4);

  /// 首页菜单分割线
  static Color menuDivider = const Color(0xFFE6E9F4);

  /// 首页暂停接单分割线
  static Color homeDivider = const Color(0xFFE6DFDF);

  /// notice text
  static Color noticeText = const Color(0xFFF09A00);

  /// status button bg
  static Color statusGreen = const Color(0xFF2BB16B);
  static Color statusYellow = const Color(0xFFFDD269);
  static Color statusGrey = const Color(0xFFBDC0C5);

  //tab
  static Color darkGrey = const Color(0xFF666666);

  /// 边框颜色
  static const Color border_color = Color(0xFFE6E6E6);

  /// 占位符文字颜色
  static const Color placeholder_color = Color(0xFFC4C4C4);

  //各种透明度的黑色
  static const Color color_10_black = Color.fromRGBO(0, 0, 0, 0.1);
  static const Color color_20_black = Color.fromRGBO(0, 0, 0, 0.2);
  static const Color color_30_black = Color.fromRGBO(0, 0, 0, 0.3);
  static const Color color_40_black = Color.fromRGBO(0, 0, 0, 0.4);
  static const Color color_50_black = Color.fromRGBO(0, 0, 0, 0.5);
  static const Color color_60_black = Color.fromRGBO(0, 0, 0, 0.6);
  static const Color color_70_black = Color.fromRGBO(0, 0, 0, 0.7);
  static const Color color_80_black = Color.fromRGBO(0, 0, 0, 0.8);
  static const Color color_90_black = Color.fromRGBO(0, 0, 0, 0.9);
  static const Color color_100_black = Color.fromRGBO(0, 0, 0, 1);

  /// 消息通知背景色
  static const Color color_order_message_bg = Color(0xE6252D3B);

  /// 验证码背景色
  static const Color color_verification_code_bg = Color(0x99252D3B);
  static const Color arrow = Color(0xFFD8D8D8);
}

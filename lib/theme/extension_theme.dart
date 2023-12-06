import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'color_configs.dart';

/// Theme Extensions
///

class MyColors extends ThemeExtension<MyColors> {
  static const light = MyColors(
    tableHeaderBgColor: ColorConfigs.bg,
    successBgColor: ColorConfigs.successBg,
    successColor: ColorConfigs.success,
    cardBgColor: ColorConfigs.cardColor,
    warningColor: ColorConfigs.warning,
  );

  static const dark = MyColors(
    tableHeaderBgColor: ColorConfigs.appBarDarkBg,
    successBgColor: ColorConfigs.successBg,
    successColor: ColorConfigs.success,
    cardBgColor: ColorConfigs.warning,
  );

  const MyColors({
    required this.tableHeaderBgColor,
    this.successBgColor,
    this.successColor,
    this.cardBgColor,
    this.warningColor,
  });

  final Color? tableHeaderBgColor;
  final Color? successBgColor;
  final Color? successColor;
  final Color? cardBgColor;
  final Color? warningColor;

  @override
  ThemeExtension<MyColors> copyWith({
    Color? tableHeaderBgColor,
  }) {
    return MyColors(
      tableHeaderBgColor: tableHeaderBgColor ?? this.tableHeaderBgColor,
      successBgColor: successBgColor ?? successBgColor,
      successColor: successColor ?? successColor,
      cardBgColor: cardBgColor ?? cardBgColor,
      warningColor: warningColor ?? warningColor,
    );
  }

  @override
  ThemeExtension<MyColors> lerp(
      covariant ThemeExtension<MyColors>? other, double t) {
    if (other is! MyColors) {
      return this;
    }

    return MyColors(
      tableHeaderBgColor:
          Color.lerp(tableHeaderBgColor, other.tableHeaderBgColor, t),
      successBgColor: Color.lerp(successBgColor, other.successBgColor, t),
      successColor: Color.lerp(successColor, other.successColor, t),
      cardBgColor: Color.lerp(cardBgColor, other.cardBgColor, t),
      warningColor: Color.lerp(warningColor, other.warningColor, t),
    );
  }
}

// ///用于重命名颜色属性
// extension ThemeDataColorExtension on ThemeData {
//   Color get bgColor => colorScheme.onBackground;

//   /// 渐变背景色
//   LinearGradient get bgGradient => LinearGradient(
//         begin: Alignment.topCenter,
//         end: Alignment.bottomCenter,
//         colors: [
//           colorScheme.background,
//           colorScheme.background,
//         ],
//       );
//   Color get primaryColor => colorScheme.primary;
//   Color get arrowIconColor => ColorConfigs.arrowIconColor;
//   Color get tableHeaderBgColor => ColorConfigs.gray3;
// }

// /// 用户重命名颜色集属性
// extension ThemeDataColorSchemeExtension on ThemeData {
//   ColorScheme get normalColorScheme => const ColorScheme.light(
//         primary: ColorConfigs.normal,
//         secondary: ColorConfigs.normalSecondary,
//         outline: ColorConfigs.normalBorder,
//         surface: Color.fromRGBO(37, 45, 59, 1),
//         background: ColorConfigs.normalBackground,
//         error: Color.fromRGBO(37, 45, 59, 1),
//         brightness: Brightness.light,
//       );
//   ColorScheme get successColorScheme => const ColorScheme.light(
//         primary: ColorConfigs.success,
//         outline: ColorConfigs.successBorder,
//         secondary: ColorConfigs.successSecondary,
//         surface: Color.fromRGBO(37, 45, 59, 1),
//         background: ColorConfigs.successBackground,
//         error: Color.fromRGBO(37, 45, 59, 1),
//         brightness: Brightness.light,
//       );
//   ColorScheme get warningColorScheme => const ColorScheme.light(
//         primary: ColorConfigs.warning,
//         secondary: ColorConfigs.warningSecondary,
//         outline: ColorConfigs.warningBorder,
//         surface: Color.fromRGBO(37, 45, 59, 1),
//         background: ColorConfigs.warningBackground,
//         onError: Color.fromRGBO(37, 45, 59, 1),
//         brightness: Brightness.light,
//       );
//   ColorScheme get errorColorScheme => const ColorScheme.light(
//         primary: ColorConfigs.error,
//         secondary: ColorConfigs.errorSecondary,
//         outline: ColorConfigs.errorBorder,
//         surface: Color.fromRGBO(37, 45, 59, 1),
//         background: Color.fromRGBO(37, 45, 59, 1),
//         brightness: Brightness.light,
//       );
// }

// ///用于重命名字体样式属性
// extension TextThemeExtension on TextTheme {
//   TextStyle get titleSLarge => const TextStyle(
//         fontSize: 20,
//         fontWeight: FontWeight.w700,
//         color: ColorConfigs.bodyText,
//       );

//   TextStyle get hitText => TextStyle(
//         color: ColorConfigs.hintTextColor,
//         fontSize: 14.sp,
//         fontWeight: FontWeight.w400,
//       );

//   /// 大号数字(30)
//   TextStyle get numberLarge => TextStyle(
//         color: ColorConfigs.bodyText,
//         fontSize: 30.sp,
//         fontFamily: "DIN",
//         fontWeight: FontWeight.w600,
//       );

//   /// 中号数字(20)
//   TextStyle get numberMedium => TextStyle(
//         color: ColorConfigs.bodyText,
//         fontSize: 20.sp,
//         fontFamily: "DIN",
//         fontWeight: FontWeight.w600,
//       );

//   /// 小号数字(16)
//   TextStyle get numberSmall => TextStyle(
//         color: ColorConfigs.bodyText,
//         fontSize: 16.sp,
//         fontFamily: "DIN",
//         fontWeight: FontWeight.w500,
//       );
// }

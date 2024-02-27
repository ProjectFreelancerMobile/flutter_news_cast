import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/storage/my_storage.dart';
import '../../res/colors.dart';
import 'app_theme.dart';

class ThemeService {
  static const LIGHT_THEME = 0;
  static const DARK_THEME = 1;
  final store = Get.find<MyStorage>();
  ThemeData? _themeData;

  ThemeData? get themeData {
    if (_themeData == null) {
      _themeData = appThemeData[AppTheme.LIGHT];
    }
    return _themeData;
  }

  init() async {
    loadTheme();
  }

  Future<void> loadTheme() async {
    final theme = await store.getTheme();
    currentAppTheme = getAppTheme(theme);
    _themeData = appThemeData[currentAppTheme];
  }

  updateTheme(int theme) async {
    currentAppTheme = getAppTheme(theme);
    _themeData = appThemeData[theme];
    store.setTheme(theme);
  }

  AppTheme getAppTheme(int theme) {
    switch (theme) {
      case LIGHT_THEME:
        return AppTheme.LIGHT;
      case DARK_THEME:
        return AppTheme.DARK;
      default:
        return AppTheme.LIGHT;
    }
  }
}

AppTheme currentAppTheme = AppTheme.LIGHT;

ColorScheme getColor() => Get.find<ThemeService>().themeData!.colorScheme;

extension MyColorScheme on ColorScheme {
  Color getColorTheme(Color colorThemeWhite, Color colorThemeDark) {
    switch (currentAppTheme) {
      case AppTheme.LIGHT:
        return colorThemeWhite;
      case AppTheme.DARK:
        return colorThemeDark;
      default:
        return colorThemeWhite;
    }
  }

  //***************************START TEXT COLOR*****************************************
  //Màu của chữ trong toàn bộ ứng dụng
  Color get textColorBlue => getColorTheme(colorTextBlue, colorTextBlue);

  Color get textColorMainDark => getColorTheme(colorMainDark, colorMainDark);

  Color get textColorMainDarkBlack => getColorTheme(colorMainDarkBlack, colorMainDarkBlack);

  Color get textColorMainMedium => getColorTheme(colorTextMain, colorTextMain);

  Color get textColorMainLight => getColorTheme(colorTextMain2, colorTextMain2);

  Color get textColorTextGrey => getColorTheme(colorTextGrey, colorTextGrey);

  Color get textColorTextGreyLight => getColorTheme(colorTextGreyLight, colorTextGreyLight);

  Color get textColorBlack => getColorTheme(colorBlack, colorBlack);

  Color get textColorPrimary => getColorTheme(colorPrimary, colorPrimary);

  Color get textColorWhite => getColorTheme(colorWhite, colorWhite);

  //***************************COMPONENT COLOR*****************************************
  //Màu của các button,checkbox.....

  Color get themeColorBackground => getColorTheme(colorBackground, colorBackground);

  Color get themeColorPrimary => getColorTheme(colorPrimary, colorPrimary);

  Color get themeColorWhite => getColorTheme(colorWhite, colorWhite);

  Color get themeColorBlack => getColorTheme(colorBlack, colorBlack);

  Color get themeColorGrey => getColorTheme(colorBgGrey, colorBgGrey);

  Color get themeColorPrimaryOpacity10 => getColorTheme(colorPrimary.withOpacity(0.1), colorPrimary.withOpacity(0.1));

  Color get themeColorPrimaryOpacity30 => getColorTheme(colorPrimary.withOpacity(0.3), colorPrimary.withOpacity(0.3));
//***************************BACKGROUND COLOR*****************************************
  //Màu của các background

  Color get bgThemeColorWhite => getColorTheme(colorWhite, colorWhite);

// Color get bgThemeColor0060E0 => getColorTheme(color0060E0, color0060E0);
}

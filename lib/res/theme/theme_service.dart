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

  Color get textColor141414 => getColorTheme(color141414, color141414);

  Color get textColor777777 => getColorTheme(color777777, color777777);

  Color get textColorB2B2B2 => getColorTheme(colorB2B2B2, colorB2B2B2);

  Color get textColorF20606 => getColorTheme(colorF20606, colorF20606);

  Color get textColorFF6F15 => getColorTheme(colorFF6F15, colorFF6F15);

  Color get textColor00AC44 => getColorTheme(color00AC44, color00AC44);

  Color get textColor0083ED => getColorTheme(color0083ED, color0083ED);

  Color get textColorPrimary => getColorTheme(colorPrimary, colorPrimary);

  Color get textColorWhite => getColorTheme(colorWhite, colorWhite);

  Color get textColor929394 => getColorTheme(color929394, color929394);

  Color get textColorD67402 => getColorTheme(colorD67402, colorD67402);

  Color get textColor0E66AC => getColorTheme(color0E66AC, color0E66AC);

  Color get textColorB90D18 => getColorTheme(colorB90D18, colorB90D18);

  Color get textColorD3D3D4 => getColorTheme(colorD3D3D4, colorD3D3D4);

  //***************************COMPONENT COLOR*****************************************
  //Màu của các button,checkbox.....

  Color get themeColorPrimary => getColorTheme(colorPrimary, colorPrimary);

  Color get themeColorB2B2B2 => getColorTheme(colorB2B2B2, colorB2B2B2);

  Color get themeColor00AC44 => getColorTheme(color00AC44, color00AC44);

  Color get themeColorF5F6F8 => getColorTheme(colorF5F6F8, colorF5F6F8);

  Color get themeColorWhite => getColorTheme(colorWhite, colorWhite);

  Color get themeColor0060E0 => getColorTheme(color0060E0, color0060E0);

  Color get themeColor00DDD4 => getColorTheme(color00DDD4, color00DDD4);

  Color get themeColorF2F9FE => getColorTheme(colorF2F9FE, colorF2F9FE);

  Color get themeColor141414 => getColorTheme(color141414, color141414);

  Color get themeColor929394 => getColorTheme(color929394, color929394);

  Color get themeColorE5F2FF => getColorTheme(colorE5F2FF, colorE5F2FF);

  Color get themeColorD3D3D4 => getColorTheme(colorD3D3D4, colorD3D3D4);

  Color get themeColorBBDEFA => getColorTheme(colorBBDEFA, colorBBDEFA);

  Color get themeColorEBEBEC => getColorTheme(colorEBEBEC, colorEBEBEC);

  Color get themeColor0EAC71 => getColorTheme(color0EAC71, color0EAC71);

  Color get themeColorD67402 => getColorTheme(colorD67402, colorD67402);

  Color get themeColorB90D18 => getColorTheme(colorB90D18, colorB90D18);

  Color get themeColor0E66AC => getColorTheme(color0E66AC, color0E66AC);

  Color get themeColor00B2FD => getColorTheme(color00B2FD, color00B2FD);

  Color get themeColorFFEFE5 => getColorTheme(colorFFEFE5, colorFFEFE5);

  Color get themeColor009CDF => getColorTheme(color009CDF, color009CDF);

  Color get themeColor00CCDD => getColorTheme(color00CCDD, color00CCDD);

  Color get themeColorPrimaryOpacity10 => getColorTheme(colorPrimary.withOpacity(0.1), colorPrimary.withOpacity(0.1));

  Color get themeColorPrimaryOpacity30 => getColorTheme(colorPrimary.withOpacity(0.3), colorPrimary.withOpacity(0.3));

  Color get themeColor00AC44Opacity10 => getColorTheme(color00AC44.withOpacity(0.1), color00AC44.withOpacity(0.1));

  Color get themeColor00AC44Opacity30 => getColorTheme(color00AC44.withOpacity(0.3), color00AC44.withOpacity(0.3));

  Color get themeColorFF6F15 => getColorTheme(colorFF6F15, colorFF6F15);

  Color get themeColorFF6F15Opacity10 => getColorTheme(colorFF6F15.withOpacity(0.1), colorFF6F15.withOpacity(0.1));

  Color get themeColorFF6F15Opacity30 => getColorTheme(colorFF6F15.withOpacity(0.3), colorFF6F15.withOpacity(0.3));

//***************************BACKGROUND COLOR*****************************************
  //Màu của các background

  Color get bgThemeColorF5F6F8 => getColorTheme(colorF5F6F8, colorF5F6F8);

  Color get bgThemeColorWhite => getColorTheme(colorWhite, colorWhite);

  Color get bgThemeColor0060E0 => getColorTheme(color0060E0, color0060E0);

  Color get bgThemeColor00DDD4 => getColorTheme(color00DDD4, color00DDD4);

  Color get bgThemeColorF2F9FE => getColorTheme(colorF2F9FE, colorF2F9FE);

// Color get bgThemeColor0060E0 => getColorTheme(color0060E0, color0060E0);
}

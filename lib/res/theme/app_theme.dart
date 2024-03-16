import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../gen/fonts.gen.dart';
import '../style.dart';

enum AppTheme { LIGHT, DARK }

final appThemeData = {
  AppTheme.LIGHT: ThemeData(
    brightness: Brightness.light,
    primaryColor: colorPrimary,
    primaryColorDark: colorPrimary,
    primaryColorLight: colorPrimary,
    dividerColor: color929394,
    scaffoldBackgroundColor: colorBackground,
    highlightColor: Colors.transparent,
    splashColor: Colors.transparent,
    textTheme: createTextTheme(),
    fontFamily: FontFamily.roboto,
    useMaterial3: true,
    appBarTheme: AppBarTheme(
      color: colorBackground,
      scrolledUnderElevation: 0,
      systemOverlayStyle: SystemUiOverlayStyle.dark,
    ),
    colorScheme: ColorScheme.fromSwatch().copyWith(
      secondary: colorPrimary,
      background: colorBackground,
      brightness: Brightness.light,
    ),
    bottomAppBarTheme: BottomAppBarTheme(
      color: colorBackground,
    ),
    dialogBackgroundColor: Colors.white,
  ),
  AppTheme.DARK: ThemeData(
    brightness: Brightness.dark,
    primaryColor: color141414,
    scaffoldBackgroundColor: color141414,
    highlightColor: Colors.transparent,
    splashColor: Colors.transparent,
    dividerColor: color929394,
    textTheme: createTextTheme(),
    fontFamily: FontFamily.roboto,
    useMaterial3: true,
    appBarTheme: AppBarTheme(
      color: color141414,
      scrolledUnderElevation: 0,
      systemOverlayStyle: SystemUiOverlayStyle.light,
    ),
    colorScheme: ColorScheme.fromSwatch().copyWith(
      secondary: colorPrimary,
      background: color141414,
      brightness: Brightness.dark,
    ),
    bottomAppBarTheme: BottomAppBarTheme(
      color: color141414,
    ),
    dialogBackgroundColor: Colors.white,
  ),
};

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
  ),
  AppTheme.DARK: ThemeData(
    brightness: Brightness.dark,
    primaryColor: colorPrimary,
    scaffoldBackgroundColor: colorBackground,
    highlightColor: Colors.transparent,
    splashColor: Colors.transparent,
    dividerColor: color929394,
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
      brightness: Brightness.dark,
    ),
    bottomAppBarTheme: BottomAppBarTheme(
      color: colorBackground,
    ),
  ),
};

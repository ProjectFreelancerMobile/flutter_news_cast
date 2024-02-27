import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_news_cast/res/style.dart';

import '../gen/fonts.gen.dart';
import 'theme_service.dart';

const fontApp = TextStyle(
  fontFamily: FontFamily.muli,
  fontWeight: FontWeight.w400,
);

TextStyle get text8 => fontApp.copyWith(fontSize: 8.ts);

TextStyle get text10 => fontApp.copyWith(fontSize: 10.ts);

TextStyle get text11 => fontApp.copyWith(fontSize: 11.ts);

TextStyle get text12 => fontApp.copyWith(fontSize: 12.ts);

TextStyle get text13 => fontApp.copyWith(fontSize: 13.ts);

TextStyle get text14 => fontApp.copyWith(fontSize: 14.ts);

TextStyle get text15 => fontApp.copyWith(fontSize: 15.ts);

TextStyle get text16 => fontApp.copyWith(fontSize: 16.ts);

TextStyle get text17 => fontApp.copyWith(fontSize: 17.ts);

TextStyle get text18 => fontApp.copyWith(fontSize: 18.ts);

TextStyle get text20 => fontApp.copyWith(fontSize: 20.ts);

TextStyle get text22 => fontApp.copyWith(fontSize: 22.ts);

TextStyle get text24 => fontApp.copyWith(fontSize: 24.ts);

TextStyle get text26 => fontApp.copyWith(fontSize: 26.ts);

TextStyle get text28 => fontApp.copyWith(fontSize: 28.ts);

TextStyle get text30 => fontApp.copyWith(fontSize: 30.ts);

TextStyle get text34 => fontApp.copyWith(fontSize: 34.ts);

extension TextStyleExt on TextStyle {
  //Weight style
  TextStyle get light => this.copyWith(fontWeight: FontWeight.w300);

  TextStyle get normal => this.copyWith(fontWeight: FontWeight.w400);

  TextStyle get medium => this.copyWith(fontWeight: FontWeight.w500);

  TextStyle get semiBold => this.copyWith(fontWeight: FontWeight.w700);

  TextStyle get bold => this.copyWith(fontWeight: FontWeight.w800);

  TextStyle get extraBold => this.copyWith(fontWeight: FontWeight.w900);

  TextStyle get normalItalic => this.copyWith(fontWeight: FontWeight.w400, fontStyle: FontStyle.italic);

  TextStyle get normalLineThrough => this.copyWith(fontWeight: FontWeight.w400, decoration: TextDecoration.lineThrough);

  TextStyle get textNoti => this.copyWith(fontWeight: FontWeight.w600);

  //height style
  TextStyle get height12Per => this.copyWith(height: 1.2);

  TextStyle get height14Per => this.copyWith(height: 1.4);

  TextStyle get height15Per => this.copyWith(height: 1.5);

  TextStyle get height16Per => this.copyWith(height: 1.6);

  TextStyle get height17Per => this.copyWith(height: 1.7);

  TextStyle get height18Per => this.copyWith(height: 1.8);

  TextStyle get height19Per => this.copyWith(height: 1.9);

  TextStyle get height20Per => this.copyWith(height: 2.0);

  TextStyle get height21Per => this.copyWith(height: 2.1);

  TextStyle get height22Per => this.copyWith(height: 2.2);

  TextStyle get height30Per => this.copyWith(height: 3.0);

  //Color style
  TextStyle get textColorBlue => this.copyWith(color: getColor().textColorBlue);

  TextStyle get textColorPrimary => this.copyWith(color: getColor().textColorPrimary);

  TextStyle get textColorMainDark => this.copyWith(color: getColor().textColorMainDark);

  TextStyle get textColorMainDarkBlack => this.copyWith(color: getColor().textColorMainDarkBlack);

  TextStyle get textColorMainMedium => this.copyWith(color: getColor().textColorMainMedium);

  TextStyle get textColorMainLight => this.copyWith(color: getColor().textColorMainLight);

  TextStyle get textColorTextGrey => this.copyWith(color: getColor().textColorTextGrey);

  TextStyle get textColorTextGreyLight => this.copyWith(color: getColor().textColorTextGreyLight);

  TextStyle get textColorBlack => this.copyWith(color: getColor().textColorBlack);

  TextStyle get textColorWhite => this.copyWith(color: getColor().textColorWhite);

  TextStyle get textErrorColor => this.copyWith(color: getColor().error);
}

TextTheme createTextTheme() => TextTheme(
    titleMedium: TextStyle(
      fontWeight: FontWeight.normal,
      fontSize: 14.ts,
    ),
    titleSmall: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 14.ts,
    ),
    bodySmall: TextStyle(
      fontWeight: FontWeight.normal,
      fontSize: 12.ts,
    ),
    bodyLarge: TextStyle(
      fontWeight: FontWeight.normal,
      fontSize: 16.ts,
    ),
    headlineMedium: TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 16.ts,
    ),
    displaySmall: TextStyle(fontWeight: FontWeight.w500, fontSize: 20.ts),
    displayMedium: TextStyle(fontWeight: FontWeight.w500, fontSize: 24.ts),
    displayLarge: TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 28.ts,
    ));

String textLocalization(String keyText) {
  return keyText.tr;
}

import 'package:flutter/material.dart';
import 'package:flutter_news_cast/res/gen/fonts.gen.dart';
import 'package:flutter_news_cast/res/style.dart';
import 'package:get/get.dart';

import 'theme_service.dart';

const fontApp = TextStyle(
  fontFamily: FontFamily.roboto,
  fontWeight: FontWeight.w400,
);

TextStyle get text10 => fontApp.copyWith(fontSize: 10.ts);

TextStyle get text11 => fontApp.copyWith(fontSize: 11.ts);

TextStyle get text12 => fontApp.copyWith(fontSize: 12.ts);

TextStyle get text13 => fontApp.copyWith(fontSize: 13.ts);

TextStyle get text14 => fontApp.copyWith(fontSize: 14.ts);

TextStyle get text16 => fontApp.copyWith(fontSize: 16.ts);

TextStyle get text18 => fontApp.copyWith(fontSize: 18.ts);

TextStyle get text20 => fontApp.copyWith(fontSize: 20.ts);

TextStyle get text22 => fontApp.copyWith(fontSize: 22.ts);

TextStyle get text24 => fontApp.copyWith(fontSize: 24.ts);

TextStyle get text26 => fontApp.copyWith(fontSize: 26.ts);

TextStyle get text28 => fontApp.copyWith(fontSize: 28.ts);

TextStyle get text34 => fontApp.copyWith(fontSize: 34.ts);

extension TextStyleExt on TextStyle {
  //Weight style
  TextStyle get light => this.copyWith(fontWeight: FontWeight.w300);

  TextStyle get normal => this.copyWith(fontWeight: FontWeight.w400);

  TextStyle get medium => this.copyWith(fontWeight: FontWeight.w500);

  //TextStyle get semibold => this.copyWith(fontWeight: FontWeight.w600);

  TextStyle get bold => this.copyWith(fontWeight: FontWeight.w700);

  TextStyle get normalItanic => this.copyWith(fontWeight: FontWeight.w400, fontStyle: FontStyle.italic);

  TextStyle get normalLineThrough => this.copyWith(fontWeight: FontWeight.w400, decoration: TextDecoration.lineThrough);

  //height style
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

  TextStyle get textColor141414 => this.copyWith(color: getColor().textColor141414);

  TextStyle get textColorB90D18 => this.copyWith(color: getColor().textColorB90D18);

  TextStyle get textColor777777 => this.copyWith(color: getColor().textColor777777);

  TextStyle get textColorB2B2B2 => this.copyWith(color: getColor().textColorB2B2B2);

  TextStyle get textColor0083ED => this.copyWith(color: getColor().textColor0083ED);

  TextStyle get textColorPrimary => this.copyWith(color: getColor().textColorPrimary);

  TextStyle get textColorF20606 => this.copyWith(color: getColor().textColorF20606);

  TextStyle get textColorFF6F15 => this.copyWith(color: getColor().textColorFF6F15);

  TextStyle get textColor00AC44 => this.copyWith(color: getColor().textColor00AC44);

  TextStyle get textColorWhite => this.copyWith(color: getColor().textColorWhite);

  TextStyle get textColor929394 => this.copyWith(color: getColor().textColor929394);

  TextStyle get textColorD67402 => this.copyWith(color: getColor().textColorD67402);

  TextStyle get textColor0E66AC => this.copyWith(color: getColor().textColor0E66AC);

  TextStyle get textColorD3D3D4 => this.copyWith(color: getColor().textColorD3D3D4);

  TextStyle get textErrorColor => this.copyWith(color: getColor().error);
}

TextTheme createTextTheme() => TextTheme(
    subtitle1: TextStyle(
      fontFamily: FontFamily.roboto,
      fontWeight: FontWeight.normal,
      fontSize: 14.ts,
    ),
    subtitle2: TextStyle(
      fontFamily: FontFamily.roboto,
      fontWeight: FontWeight.bold,
      fontSize: 14.ts,
    ),
    caption: TextStyle(
      fontFamily: FontFamily.roboto,
      fontWeight: FontWeight.normal,
      fontSize: 12.ts,
    ),
    bodyText1: TextStyle(
      fontFamily: FontFamily.roboto,
      fontWeight: FontWeight.normal,
      fontSize: 16.ts,
    ),
    headline4: TextStyle(
      fontFamily: FontFamily.roboto,
      fontWeight: FontWeight.w500,
      fontSize: 16.ts,
    ),
    headline3: TextStyle(fontFamily: FontFamily.roboto, fontWeight: FontWeight.w500, fontSize: 20.ts),
    headline2: TextStyle(fontFamily: FontFamily.roboto, fontWeight: FontWeight.w500, fontSize: 24.ts),
    headline1: TextStyle(
      fontFamily: FontFamily.roboto,
      fontWeight: FontWeight.w500,
      fontSize: 28.ts,
    ));

String textLocalization(String keyText) {
  return keyText.tr;
}

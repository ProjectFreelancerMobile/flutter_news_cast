import 'dart:math';

import 'package:flutter/cupertino.dart';

// Default guideline sizes are based on standard ~5" screen mobile device
const guidelineBaseWidth = 428.0;
const guidelineBaseHeight = 926.0;

double scaleWidth = guidelineBaseWidth;
double scaleHeight = guidelineBaseWidth;
double scaleText = guidelineBaseWidth;

void initScreen(BuildContext context) {
  scaleWidth = MediaQuery.of(context).size.width / guidelineBaseWidth;

  scaleHeight = MediaQuery.of(context).size.height / guidelineBaseHeight;

  scaleText = min(scaleWidth, scaleHeight);
}

extension ScreenExtension on num {
  double get ws => this * scaleWidth; // Width Scale
  double get hs => this * scaleHeight; // Height Scale
  double get ts => this * scaleText; // Text Scale
  double get rs => this * scaleText; // Radius Scale
}

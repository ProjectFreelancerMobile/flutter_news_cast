import 'dart:math';

import 'package:get/get.dart';

// Default guideline sizes are based on standard ~5" screen mobile device
// const guidelineBaseWidth = 390;
// const guidelineBaseHeight = 844;
const guidelineBaseWidth = 360;
const guidelineBaseHeight = 780;

double get scaleWidth => Get.width / guidelineBaseWidth;

double get scaleHeight => Get.height / guidelineBaseHeight;

double get scaleText => min(scaleWidth, scaleHeight);

extension ScreenExtension on num {
  double get ws => this * scaleWidth; // Width Scale
  double get hs => this * scaleHeight; // Height Scale
  double get ts => this * scaleText; // Text Scale
  double get rs => this * scaleText; // Radius Scale
}

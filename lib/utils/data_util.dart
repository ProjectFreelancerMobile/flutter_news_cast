import 'dart:ui';

import 'package:intl/intl.dart';

String formatCurrency(int number) {
  final oCcy = NumberFormat.currency(locale: 'vi', customPattern: '#,### \u00a4', symbol: 'đ', decimalDigits: 0);
  return oCcy.format(number);
}

extension ColorExtension on String {
  toColor() {
    var hexColor = this.replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    if (hexColor.length == 8) {
      return Color(int.parse("0x$hexColor"));
    }
  }
}

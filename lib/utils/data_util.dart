import 'dart:ui';

import 'package:intl/intl.dart';
import 'package:spelling_number/spelling_number.dart';

bool getDataType(dynamic item) => item.startsWith('TYPE:ADD_');

String getDataUserName(dynamic item) => item.contains('.USER:') && item.contains('.BANK_NAME:') ? (item.substring(item.indexOf('.USER:') + 6, item.indexOf('.BANK_NAME:'))) : '';

String getDataMoney(dynamic item) => (item.contains('.MONEY:') && item.contains('.SODU:') ? (item.substring(item.indexOf('.MONEY:') + 7, item.indexOf('.SODU:'))) : '');

String getDataSoDu(dynamic item) => item.contains('.SODU:') && item.contains('.NOTE:') ? (item.substring(item.indexOf('.SODU:') + 6, item.indexOf('.NOTE:'))) : '';

String getDataNote(dynamic item) => item.contains('.NOTE:') && item.contains('.DATE:') ? item.substring(item.indexOf('.NOTE:') + 6, item.indexOf('.DATE:')) : '';

String getDataDate(dynamic item) => item.contains('.DATE:') && item.contains('.CODE:') ? item.substring(item.indexOf('.DATE:') + 6, item.indexOf('.CODE:')) : '';

String getDataMaGD(dynamic item) => 'FT${item.contains('.CODE:') ? item.substring(item.indexOf('.CODE:') + 6) : ''}/\BNK';

String getDataSTK(dynamic item) => item.contains('.STK:') && item.contains('.USER:') ? item.substring(item.indexOf('.STK:') + 5, item.indexOf('.USER:')) : '';

String getDataBank(dynamic item) => item.contains('.BANK_NAME:') && item.contains('.MONEY:') ? item.substring(item.indexOf('.BANK_NAME:') + 11, item.indexOf('.MONEY:')) : '';

String formatCurrency(num number) {
  final oCcy = NumberFormat.currency(locale: 'vi', customPattern: '#,### \u00a4', symbol: 'VND', decimalDigits: 0);
  return oCcy.format(number).replaceAll('.', ',');
}

String formatCurrencyRaw(num number) {
  final oCcy = NumberFormat("#,###");
  return oCcy.format(number);
}

String formatMoney(String money) {
  //print('formatMoney::' + money);
  if (money.length > 0) {
    var tien = int.parse(money.replaceAll(",", ""));
    var numberToWord = SpellingNumber(lang: 'vi').convert(tien);
    numberToWord = numberToWord.replaceAll("ngàn", "nghìn").replaceAll("và", "");
    return numberToWord = "${numberToWord[0].toUpperCase()}${numberToWord.substring(1).toLowerCase()} Đồng";
  } else {
    return '0 Đồng';
  }
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

import 'dart:ui';

import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

String formatCurrency(int number) {
  final oCcy = NumberFormat.currency(locale: 'vi', customPattern: '#,### \u00a4', symbol: 'đ', decimalDigits: 0);
  return oCcy.format(number);
}

Future<void> launchOpenUrl(Uri _url) async {
  if (await canLaunchUrl(_url)) {
    await launchUrl(_url, webViewConfiguration: WebViewConfiguration(enableJavaScript: true));
  } else {
    throw 'Could not launch $_url';
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

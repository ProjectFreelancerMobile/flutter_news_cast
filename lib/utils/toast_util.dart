import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../res/style.dart';

FToast fToast = FToast();

void initToast(BuildContext context) {
  fToast.init(context);
}

void showMessage(String message, {bool isForeShow = true, int second = 3}) {
  if (!isForeShow) return;
  Widget toast = Container(
    padding: const EdgeInsets.symmetric(horizontal: 22.0, vertical: 30.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10.0),
      color: Colors.black.withOpacity(0.75),
    ),
    child: Text(message, style: text14.textColorWhite, textAlign: TextAlign.start),
  );
  return fToast.showToast(
    child: toast,
    gravity: ToastGravity.CENTER,
    toastDuration: Duration(seconds: second),
  );
}

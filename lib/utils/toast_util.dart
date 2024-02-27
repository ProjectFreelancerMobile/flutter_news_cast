import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

late FToast fToast;

void initToast(BuildContext context) {
  fToast = FToast();
  fToast.init(context);
}

void showMessage(String message, {bool isForeShow = true, int second = 3, bool isError = true}) {
  if (!isForeShow) return;
  // Widget toast = Container(
  //   padding: const EdgeInsets.symmetric(horizontal: 22.0, vertical: 30.0),
  //   decoration: BoxDecoration(
  //     borderRadius: BorderRadius.circular(10.0),
  //     color: Colors.black.withOpacity(0.75),
  //   ),
  //   child: Text(message, style: text14.textColorWhite, textAlign: TextAlign.start),
  // );
  Get.snackbar(isError == true ? 'Lỗi' : 'Thông báo', message, snackPosition: SnackPosition.BOTTOM);
  return;
}

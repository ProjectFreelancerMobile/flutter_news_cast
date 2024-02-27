import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_news_cast/data/api/models/response/api_response.dart';
import 'package:flutter_news_cast/res/style.dart';

import '../../data/api/exceptions/api_exception.dart';
import '../../res/theme/theme_service.dart';
import '../../ui/widgets/button/custom_button.dart';
import 'base_page.dart';

abstract class BaseSuperController<C> extends SuperController {
  /* Hiển thị các loại thông báo
    1. Hiển thị thông báo full màn hình
    2. Hiển thị thông báo dạng popup
    3.Hiển thị thông báo dạng Snackbar
    */
  int get typeViewNoti => 1;

  @override
  void onInit() async {
    super.onInit();
    viewState = initState.obs;
  }

  late Rx<ViewState> viewState;
  String? errorMessage;

  ViewState get initState => ViewState.loaded;

  showErrors(Object exception) {
    if (exception is ApiException) {
      errorMessage = exception.message;
    } else if (exception is DioException) {
      errorMessage = exception.message;
    } else if (exception is ApiResponse) {
      errorMessage = exception.message;
    } else {
      errorMessage = exception.toString();
    }
    switch (typeViewNoti) {
      case 1:
        viewState.value = ViewState.error;
        break;
      case 2:
        viewState.value = ViewState.loaded;
        openNotiDialog(errorMessage ?? textLocalization('data.error'));
        break;
      case 3:
        viewState.value = ViewState.loaded;
        Get.snackbar(textLocalization('noti.title'), errorMessage ?? textLocalization('data.error'), backgroundColor: getColor().themeColorPrimaryOpacity10);
        break;
    }
  }

  getErrors(Object exception) {
    if (exception is ApiException) {
      errorMessage = exception.message;
    } else if (exception is DioException) {
      errorMessage = exception.message;
    } else if (exception is ApiResponse) {
      errorMessage = exception.message;
    } else {
      errorMessage = exception.toString();
    }
    return errorMessage;
  }

  showLoading() {
    viewState.value = ViewState.loading;
  }

  hideLoading() {
    viewState.value = ViewState.loaded;
  }

  void onReloadData() {}

  void openNotiDialog(String content) {
    Get.dialog(Material(
      color: Colors.transparent,
      child: Center(
        child: Container(
          padding: EdgeInsets.all(20.ws),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10.ws)),
            color: getColor().bgThemeColorWhite,
          ),
          width: 280.ws,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                textLocalization('noti.title'),
                style: text18.bold.textColorBlack,
              ),
              SizedBox(
                height: 20.hs,
              ),
              Text(
                content,
                style: text14.textColorBlack,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 20.hs,
              ),
              CustomButton(
                text: "Đóng",
                textStyle: text14.bold.textColorWhite,
                onPressed: () => Get.back(),
                width: 100.ws,
                height: 30.ws,
                radius: 5.rs,
                isEnable: true,
              )
            ],
          ),
        ),
      ),
    ));
  }
}

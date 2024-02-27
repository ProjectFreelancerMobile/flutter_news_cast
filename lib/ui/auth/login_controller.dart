import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/app_pages.dart';
import '../../../data/api/repositories/user_repository.dart';
import '../../app/app_controller.dart';
import '../base/base_controller.dart';
import '../base/base_page.dart';

class LoginController extends BaseController {
  final _userRepository = Get.find<UserRepository>();
  final _appController = Get.find<AppController>();

  ViewState get initState => ViewState.loaded;
  final formKey = GlobalKey<FormState>();
  TextEditingController textUserNameCl = TextEditingController();//..text = 'admin123';
  TextEditingController textPasswordCl = TextEditingController();//..text = '123123';
  RxBool buttonUserEnable = false.obs;

  @override
  int get typeViewNoti => 3;

  bool get validateUserName => GetUtils.isLengthGreaterOrEqual(textUserNameCl.text, 3);

  bool get validatePassword => GetUtils.isLengthGreaterOrEqual(textPasswordCl.text, 6);

  bool get checkLogin => _appController.user != null && _appController.user!.userName.isNotEmpty;

  ImageProvider<Object> themeMain() => _appController.themeMain();

  @override
  void onInit() {
    super.onInit();
    textUserNameCl.addListener(_userControllerListener);
    textPasswordCl.addListener(_userControllerListener);
  }

  void _userControllerListener() {
    formKey.currentState?.validate();
    buttonUserEnable.value = validateUserName && validatePassword;
  }

  String? validatorEmail() {
    return GetUtils.isNullOrBlank(textUserNameCl.text) == true ? 'Tài khoản không được rỗng!' : null;
  }

  String? passwordValidator() {
    return requiredField(textUserNameCl.text) ?? minimum6Characters();
  }

  String? minimum6Characters() => textUserNameCl.text.length < 6 ? 'Tối thiểu 6 chữ số' : null;

  String? requiredField(String? value) {
    return value == null || value.isEmpty ? 'Không được để trống mật khẩu!' : null;
  }

  Future<String?> _getID() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      // import 'dart:io'
      var iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo.identifierForVendor; // unique ID on iOS
    } else if (Platform.isAndroid) {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      return androidDeviceInfo.id; // unique ID on Android
    }
    return null;
  }

  loginUser(Function(String) errorMessage) async {
    if (validatorEmail() != null) {
      errorMessage(validatorEmail() ?? '');
      return;
    }
    if (passwordValidator() != null) {
      errorMessage(passwordValidator() ?? '');
      return;
    }
    showLoading();
    try {
      var deviceID = await _getID() ?? "Device ${textUserNameCl.text}";
      final userInfo = await _userRepository.loginByEmail(textUserNameCl.text, textPasswordCl.text, deviceID);
      if (userInfo != null) {
        await Get.find<AppController>().initAuth();
      }
      hideLoading();
      Get.offAllNamed(AppRoutes.MAIN, arguments: [textUserNameCl.text, '']);
    } catch (e) {
      hideLoading();
      errorMessage(getErrors(e));
    }
  }

  @override
  void dispose() {
    textUserNameCl.removeListener(_userControllerListener);
    textUserNameCl.dispose();
    textPasswordCl.removeListener(_userControllerListener);
    textPasswordCl.dispose();
    formKey.currentState?.dispose();
    super.dispose();
  }
}

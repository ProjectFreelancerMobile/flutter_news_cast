import 'package:flutter/material.dart';
import 'package:flutter_cupertino_datetime_picker/flutter_cupertino_datetime_picker.dart';
import 'package:flutter_news_cast/data/api/models/TUser.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../../app/app_controller.dart';
import '../../../data/storage/key_constant.dart';
import '../../../data/storage/my_storage.dart';
import '../../../res/theme/app_theme.dart';
import '../../../res/theme/theme_service.dart';
import '../../base/base_controller.dart';

class SettingsController extends BaseController {
  final appController = Get.find<AppController>();
  final storage = Get.find<MyStorage>();
  final themeManager = Get.find<ThemeService>();
  final txtNameController = TextEditingController();
  final txtPhoneController = TextEditingController();
  var _user = TUser().obs;
  var appVersion = ''.obs;

  var switchBlockAds = true.obs;
  var switchDarkMode = false.obs;
  var switchNotification = false.obs;

  TUser get user => _user.value;
  DateTimePickerLocale? locale = DateTimePickerLocale.en_us;
  DateTime? dateTime;

  @override
  void onInit() async {
    super.onInit();
    // try {
    //   await _useRepository.getUserInfo();
    // } catch (e) {}
    // _user.value = appController.user ?? TUser(name: '', gender: SEX_TYPE.MEN.name, phone: '');
    // if (user.gender == null) {
    //   _user.update((_user) {
    //     user.updateUser(gender: SEX_TYPE.MEN.name);
    //   });
    // }
    // dateTime = user.birthday ?? DateTime.parse(INIT_DATETIME);
    // sexType.value = user.gender == 1 ? SEX_TYPE.MEN : (user.gender == 0 ? SEX_TYPE.WOMAN : SEX_TYPE.OTHER);
    // txtNameController.text = user.name ?? '';
    // txtPhoneController.text = user.phone ?? '';
    switchDarkMode.value = themeManager.getAppTheme(await storage.getTheme()) == AppTheme.DARK;
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    appVersion.value = packageInfo.version;
  }

  void updateStateSwitch(SWITCH_TYPE switch_type, bool value) {
    switch (switch_type) {
      case SWITCH_TYPE.BLOCK_ADS:
        switchBlockAds.value = value;
        break;
      case SWITCH_TYPE.PLUGIN:
        switchDarkMode.value = value;
        themeManager.updateTheme(value ? AppTheme.DARK.index : AppTheme.LIGHT.index);
        break;
      case SWITCH_TYPE.NOTI:
        switchNotification.value = value;
        break;
      default:
        break;
    }
  }

  bool getStateSwitch(SWITCH_TYPE switch_type) {
    switch (switch_type) {
      case SWITCH_TYPE.BLOCK_ADS:
        return switchBlockAds.value;
      case SWITCH_TYPE.PLUGIN:
        return switchDarkMode.value;
      case SWITCH_TYPE.NOTI:
        return switchNotification.value;
      default:
        return false;
    }
  }

  void updateProfile(Function(String) errorMessage, {String? userName, DateTime? birthday, SEX_TYPE? sexType, String? phone}) async {
    // showLoading();
    // try {
    //   if (userName != null) {
    //     try {
    //       await _useRepository.updateProfile(name: userName);
    //       _user.update((_user) {
    //         user.updateUser(name: userName);
    //       });
    //       txtNameController.text = userName;
    //     } catch (e) {
    //       txtNameController.text = user.name ?? '';
    //       errorMessage(getErrors(e));
    //     }
    //   }
    //   if (birthday != null) {
    //     try {
    //       await _useRepository.updateProfile(birthday: birthday);
    //       dateTime = birthday;
    //       _user.update((_user) {
    //         user.updateUser(birthday: birthday);
    //       });
    //     } catch (e) {
    //       dateTime = user.birthday ?? DateTime.parse(INIT_DATETIME);
    //       errorMessage(getErrors(e));
    //     }
    //   }
    //   if (sexType != null) {
    //     try {
    //       Get.back();
    //       var gender = SEX_TYPE.MEN.name;
    //       switch (sexType) {
    //         case SEX_TYPE.MEN:
    //           gender = SEX_TYPE.MEN.name;
    //         case SEX_TYPE.WOMAN:
    //           gender = SEX_TYPE.WOMAN.name;
    //         case SEX_TYPE.OTHER:
    //           gender = SEX_TYPE.OTHER.name;
    //       }
    //       await _useRepository.updateProfile(gender: gender);
    //       this.sexType.value = sexType;
    //       _user.update((_user) {
    //         user.updateUser(gender: gender);
    //       });
    //     } catch (e) {
    //       this.sexType.value = user.gender == 1 ? SEX_TYPE.MEN : (user.gender == 0 ? SEX_TYPE.WOMAN : SEX_TYPE.OTHER);
    //       errorMessage(getErrors(e));
    //     }
    //   }
    //   if (phone != null) {
    //     try {
    //       await _useRepository.updateProfile(phone: phone);
    //       _user.update((_user) {
    //         user.updateUser(phone: phone);
    //       });
    //       txtPhoneController.text = phone;
    //     } catch (e) {
    //       txtPhoneController.text = user.phone ?? '';
    //       errorMessage(getErrors(e));
    //     }
    //   }
    //   print('_user:::${txtNameController.text}');
    //   storage.saveUserInfo(user);
    //   hideLoading();
    // } catch (e) {
    //   print("errorMessage::" + getErrors(e));
    //   hideLoading();
    //   errorMessage(getErrors(e));
    // }
  }

  onGotoNotificationsPage() {
    //Get.toNamed(AppRoutes.LIST_NOTIFICATION);
  }

  onGotoSecurityPage() {
    //Get.toNamed(AppRoutes.SECURITY);
  }

  onGotoNotificationsSettingPage() {
    //Get.toNamed(AppRoutes.SETTING_NOTIFICATION);
  }
}

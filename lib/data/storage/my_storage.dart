import 'dart:convert';

import 'package:flutter_news_cast/data/api/models/token_model.dart';
import 'package:get_storage/get_storage.dart';

import '../../res/languages/localization_service.dart';
import '../../res/theme/theme_service.dart';
import '../api/models/TUser.dart';

class MyStorage {
  late GetStorage box;
  static const STORAGE_NAME = "my_storage";
  static const APP_USER_INFO = "telemed_user_info";
  static const APP_NEW_INSTALL = "app_new_install";
  static const APP_THEME = "app_theme";
  static const APP_LANGUAGE = "app_language";
  static const DEVICE_TOKEN = "device_token";

  init() async {
    await GetStorage.init(STORAGE_NAME);
    box = GetStorage(STORAGE_NAME);
  }

  Future<void> saveDeviceToken(TokenModel tokenModel) async {
    String json = jsonEncode(tokenModel.toJson());
    box.write(DEVICE_TOKEN, json);
  }

  Future<TokenModel?> getDeviceToken() async {
    final tokenJson = await box.read(DEVICE_TOKEN);
    return tokenJson != null ? TokenModel.fromJson(json.decode(tokenJson)) : null;
  }

  Future<void> saveUserInfo(TUser user) async {
    String json = jsonEncode(user.toJson());
    box.write(APP_USER_INFO, json);
  }

  Future<TUser?> getUserInfo() async {
    final userJson = await box.read(APP_USER_INFO);
    return userJson != null ? TUser.fromJson(json.decode(userJson)) : null;
  }

  Future<void> saveInstall(bool isInstall) async {
    box.write(APP_NEW_INSTALL, isInstall);
  }

  Future<bool> isInstall() async {
    final isInstall = await box.read(APP_NEW_INSTALL) ?? false;
    return isInstall;
  }

  Future<void> setTheme(int theme) async {
    box.write(APP_THEME, theme);
  }

  Future<int> getTheme() async {
    final theme = await box.read(APP_THEME) ?? ThemeService.LIGHT_THEME;
    return theme;
  }

  Future<void> setLanguage(String language) async {
    box.write(APP_LANGUAGE, language);
  }

  Future<String> getLanguage() async {
    final theme = await box.read(APP_LANGUAGE) ?? LocalizationService.VI_VN;
    return theme;
  }

  Future<void> logout() async {
    if (box.hasData(APP_LANGUAGE)) await box.remove(APP_LANGUAGE);
    if (box.hasData(APP_THEME)) await box.remove(APP_THEME);
    if (box.hasData(APP_USER_INFO)) await box.remove(APP_USER_INFO);
    if (box.hasData(DEVICE_TOKEN)) await box.remove(DEVICE_TOKEN);
  }
}

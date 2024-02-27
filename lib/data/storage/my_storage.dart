import 'dart:convert';

import 'package:get_storage/get_storage.dart';

import '../../res/languages/localization_service.dart';
import '../../res/theme/theme_service.dart';
import '../api/models/TUser.dart';

class MyStorage {
  late GetStorage box;
  static const STORAGE_NAME = "my_storage";
  static const APP_USER_INFO = "app_user_info";
  static const APP_THEME = "app_theme";
  static const APP_LANGUAGE = "app_language";
  static const APP_KEY = "app_key";
  static const APP_MAIN_THEME = "app_main_theme";

  init() async {
    await GetStorage.init(STORAGE_NAME);
    box = GetStorage(STORAGE_NAME);
  }

  Future<void> saveUserInfo(TUser user) async {
    String json = jsonEncode(user.toJson());
    box.write(APP_USER_INFO, json);
  }

  Future<TUser?> getUserInfo() async {
    final userJson = await box.read(APP_USER_INFO);
    return userJson != null ? TUser.fromJson(json.decode(userJson)) : null;
  }

  /* Future<void> saveListUserInfo(List<String> listUser) async {
    box.write(APP_LIST_USER, jsonEncode(listUser));
  }

  Future<List<String>?> getListUserInfo() async {
    final dataList = await box.read(APP_LIST_USER);
    if (dataList != null) {
      var listUserJson = (jsonDecode(dataList) as List<dynamic>).cast<String>();
      return listUserJson;
    } else {
      return [];
    }
  }*/

  Future<void> setTheme(int theme) async {
    box.write(APP_THEME, theme);
  }

  Future<int> getTheme() async {
    final theme = await box.read(APP_THEME) ?? ThemeService.LIGHT_THEME;
    return theme;
  }

  Future<void> setAppTheme(int theme) async {
    box.write(APP_MAIN_THEME, theme);
  }

  Future<int> getAppTheme() async {
    final theme = await box.read(APP_MAIN_THEME) ?? 0;
    return theme;
  }

  Future<void> setLanguage(String language) async {
    box.write(APP_LANGUAGE, language);
  }

  Future<String> getLanguage() async {
    final theme = await box.read(APP_LANGUAGE) ?? LocalizationService.VI_VN;
    return theme;
  }

  Future<void> setKey(String key) async {
    box.write(APP_KEY, key);
  }

  Future<String> getKey() async {
    final key = await box.read(APP_KEY) ?? '';
    return key;
  }

  Future<void> logout() async {
    if (box.hasData(APP_LANGUAGE)) await box.remove(APP_LANGUAGE);
    if (box.hasData(APP_THEME)) await box.remove(APP_THEME);
    if (box.hasData(APP_USER_INFO)) await box.remove(APP_USER_INFO);
    if (box.hasData(APP_KEY)) await box.remove(APP_KEY);
    //if (box.hasData(APP_LIST_USER)) await box.remove(APP_LIST_USER);
  }
}

import 'package:get/get.dart';
import 'package:flutter_news_cast/data/api/models/TUser.dart';

import '../../storage/my_storage.dart';
import '../services/user_service.dart';
import 'base_repository.dart';

class UserRepository extends BaseRepository {
  final _userService = Get.find<UserService>();
  final _storage = Get.find<MyStorage>();

  Future<TUser?> loginByEmail(String userName, String password, String deviceID) async {
    final response = await _userService.loginByEmail(userName, password, deviceID);
    final user = response.data['user'];
    final userInfo = TUser.fromJson(user);
    if (password.isNotEmpty) {
      await _storage.setKey(password);
    }
    if (userInfo.userName.isNotEmpty) {
      await _storage.saveUserInfo(userInfo);
      return userInfo;
    }
    if (userInfo.userName.isNotEmpty) {
      await _storage.saveUserInfo(userInfo);
      return userInfo;
    }
    return null;
  }
}

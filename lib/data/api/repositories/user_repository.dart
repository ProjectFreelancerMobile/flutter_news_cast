import 'package:flutter_news_cast/data/api/models/response/api_response.dart';
import 'package:flutter_news_cast/data/api/models/token_model.dart';
import 'package:flutter_news_cast/utils/date_time_utils.dart';
import 'package:get/get.dart';

import '../../../app/app_controller.dart';
import '../../storage/my_storage.dart';
import '../api_constants.dart';
import '../models/TUser.dart';
import '../services/user_service.dart';
import 'base_repository.dart';

class UserRepository extends BaseRepository {
  final _userService = Get.find<UserService>();
  final _storage = Get.find<MyStorage>();

  Future<ApiResponse> loginByEmail(String email) async {
    final response = await _userService.loginByEmail(email);
    return response;
  }

  Future<ApiResponse> loginBySocial(
    String email,
    String type, {
    String? token,
    String? accessToken,
    String? socialId,
    String? serverAuthCode,
    String? fullName,
    String? displayName,
    String? avatar,
  }) async {
    final response = await _userService.loginBySocial(
      email,
      type,
      token: token,
      accessToken: accessToken,
      socialId: socialId,
      serverAuthCode: serverAuthCode,
      fullName: fullName,
      displayName: displayName,
      avatar: avatar,
    );
    final tokenModel = TokenModel.fromJson(response.data);
    final userInfo = await _userService.getUserInfo(tokenModel.uk);
    await _storage.saveDeviceToken(tokenModel);
    await _storage.saveUserInfo(userInfo);
    return response;
  }

  Future<ApiResponse> register(String user, String email) async {
    final response = await _userService.register(user, email);
    return response;
  }

  Future<ApiResponse> requestOtp(String email) async {
    final response = await _userService.requestOtp(email);
    return response;
  }

  Future<ApiResponse> confirmOtp(String email, String otp) async {
    final response = await _userService.confirmOtp(email, otp);
    final tokenModel = TokenModel.fromJson(response.data);
    final userInfo = await _userService.getUserInfo(tokenModel.uk);
    await _storage.saveDeviceToken(tokenModel);
    await _storage.saveUserInfo(userInfo);
    print("tokenModel:::" + tokenModel.toString() + "userInfo::" + userInfo.toString());
    return response;
  }

  Future<TUser> getUserInfo() async {
    final _storage = Get.find<MyStorage>();
    final tokenModel = await _storage.getDeviceToken();
    final userInfo = await _userService.getUserInfo(tokenModel?.uk);
    print("tokenModel:::" + tokenModel.toString() + "userInfo::" + userInfo.toString());
    await _storage.saveUserInfo(userInfo);
    return userInfo;
  }

  Future<TUser> updateProfile({String? name, DateTime? birthday, String? phone, num? gender}) async {
    final _storage = Get.find<MyStorage>();
    final tokenModel = await _storage.getDeviceToken();
    final user = await _userService.updateProfile(tokenModel?.uk, name: name, birthday: formatDate(birthday, DATE_FORMAT3), gender: gender, phone: phone);
    _storage.saveUserInfo(user);
    await Get.find<AppController>().updateOnlyUserInfo(user);
    return user;
  }

  updateFirebaseToken({required String token, required String deviceId, String? verName, String? verCode}) async {
    await _userService.updateFirebaseToken(token: token, deviceId: deviceId, verCode: verCode, verName: verName);
  }
}

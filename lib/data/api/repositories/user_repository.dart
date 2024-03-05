import 'package:get/get.dart';

import '../../storage/my_storage.dart';
import '../models/TUser.dart';
import '../services/bookmark_service.dart';
import 'base_repository.dart';

class BookmarkRepository extends BaseRepository {
  final _bookmarkService = Get.find<BookmarkService>();
  final _storage = Get.find<MyStorage>();

  // Future<ApiResponse> loginBySocial(
  //   String email,
  //   String type, {
  //   String? token,
  //   String? accessToken,
  //   String? socialId,
  //   String? serverAuthCode,
  //   String? fullName,
  //   String? displayName,
  //   String? avatar,
  // }) async {
  //   final response = await _userService.loginBySocial(
  //     email,
  //     type,
  //     token: token,
  //     accessToken: accessToken,
  //     socialId: socialId,
  //     serverAuthCode: serverAuthCode,
  //     fullName: fullName,
  //     displayName: displayName,
  //     avatar: avatar,
  //   );
  //   final tokenModel = TokenModel.fromJson(response.data);
  //   final userInfo = await _userService.getUserInfo(tokenModel.uk);
  //   await _storage.saveDeviceToken(tokenModel);
  //   await _storage.saveUserInfo(userInfo);
  //   return response;
  // }
  //
  // Future<ApiResponse> register(String user, String email) async {
  //   final response = await _userService.register(user, email);
  //   return response;
  // }
  //
  // Future<ApiResponse> requestOtp(String email) async {
  //   final response = await _userService.requestOtp(email);
  //   return response;
  // }
  //
  // Future<ApiResponse> confirmOtp(String email, String otp) async {
  //   final response = await _userService.confirmOtp(email, otp);
  //   final tokenModel = TokenModel.fromJson(response.data);
  //   final userInfo = await _userService.getUserInfo(tokenModel.uk);
  //   await _storage.saveDeviceToken(tokenModel);
  //   await _storage.saveUserInfo(userInfo);
  //   print("tokenModel:::" + tokenModel.toString() + "userInfo::" + userInfo.toString());
  //   return response;
  // }
  //
  Future<TUser> getUserInfo() async {
    // final _storage = Get.find<MyStorage>();
    // final tokenModel = await _storage.getDeviceToken();
    // final userInfo = await _userService.getUserInfo(tokenModel?.uk);
    // print("tokenModel:::" + tokenModel.toString() + "userInfo::" + userInfo.toString());
    // await _storage.saveUserInfo(userInfo);
    // return userInfo;
    return TUser();
  }

  Future<TUser> updateProfile({String? name, DateTime? birthday, String? phone, num? gender}) async {
    // final _storage = Get.find<MyStorage>();
    // final tokenModel = await _storage.getDeviceToken();
    // final user = await _userService.updateProfile(tokenModel?.uk, name: name, birthday: formatDate(birthday, DATE_FORMAT3), gender: gender, phone: phone);
    // _storage.saveUserInfo(user);
    // await Get.find<AppController>().updateOnlyUserInfo(user);
    // return user;
    return TUser();
  }
}

import 'base_service.dart';

class BookmarkService extends BaseService {
 /* Future<ApiResponse> loginByEmail(String email) async {
    final params = {"email": email};
    return await post(LOGIN_BY_EMAIL, data: params);
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
    if (type == SOCIAL_TYPE.GOOGLE.name) {
      var params = {
        "email": email,
        "social_name": type,
        "display_name": displayName,
        "avatar": avatar,
        "social_id": socialId,
        "server_auth_code": serverAuthCode,
        "phone_number": "",
        "access_token": "",
        "refresh_token": "",
      };
      params.removeWhere((dynamic key, dynamic value) => key == null || value == null || value == '');
      return await post(LOGIN_BY_SOCIAL, data: params);
    } else {
      var params = {
        "email": email,
        "social_id": socialId,
        "social_name": type,
        "fullname": fullName,
        "display_name": displayName,
        "avatar": avatar,
        "token": token,
        "access_token": accessToken,
        "refresh_token": "",
      };
      params.removeWhere((dynamic key, dynamic value) => key == null || value == null || value == '');
      return await post(LOGIN_BY_SOCIAL, data: params);
    }
  }

  Future<ApiResponse> register(String user, String email) async {
    final params = {"name": user, "email": email};
    return await post(REGISTER, data: params);
  }

  Future<ApiResponse> requestOtp(String email) async {
    final params = {"email": email};
    return await post(REQUEST_OTP, data: params);
  }

  Future<ApiResponse> confirmOtp(String email, String code) async {
    final params = {"email": email, "code": code};
    final response = await post(VERIFY_OTP, data: params);
    return response;
  }

  Future<TUser> getUserInfo(String? uk) async {
    final params = {"uk": uk};
    final response = await post(GET_PROFILE, data: params);
    if (response.data != null) {
      return TUser.fromJson(response.data);
    } else {
      return TUser();
    }
  }

  Future<TUser> updateProfile(String? uk, {String? name, String? birthday, num? gender, String? phone}) async {
    final params = {"uk": uk, "name": name, "birthday": birthday, "gender": gender, "phone": phone};
    params.removeWhere((dynamic key, dynamic value) => key == null || value == null || value == '');
    final response = await post(UPDATE_PROFILE, data: params);
    if (response.data != null) {
      return TUser.fromJson(response.data);
    } else {
      return TUser();
    }
  }

  updateFirebaseToken({required String token, required String deviceId, String? verName, String? verCode}) async {
    final url = sprintf(PUSH_DEVICE_TOKEN, [deviceId]);
    await post(url, data: {"token": token, "os": Platform.isAndroid ? "android" : "ios", "verName": verName, "verCode": verCode});
  }*/
}

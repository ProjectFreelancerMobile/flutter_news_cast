import 'package:get/get.dart';

import '../../storage/my_storage.dart';
import 'base_service.dart';

class RSSService extends BaseService {
  final _storage = Get.find<MyStorage>();

  // Future<TokenModel?> tokenModel() async => await _storage.getDeviceToken();
  //
  // Future<String> getNameFarm(List<FarmItem>? listFarm) async {
  //   final token = await tokenModel();
  //   final farm = listFarm?.firstWhere((element) => element.fkey == token?.fk);
  //   return Future.value(farm?.name ?? textLocalization('service.manager.my'));
  // }
  //
  // Future<FarmItem?> getFarmDetail(String? fk) async {
  //   final token = await tokenModel();
  //   final params = {"uk": token?.uk, "fk": fk ?? token?.fk};
  //   final response = await post(GET_FARM, data: params);
  //   if (response.data != null) {
  //     return FarmItem.fromJson(response.data);
  //   } else {
  //     return null;
  //   }
  // }
  //
  // Future<List<FarmItem>?> getListFarm() async {
  //   final token = await tokenModel();
  //   final params = {"uk": token?.uk};
  //   final response = await post(GET_ALL_FARM, data: params);
  //   if (response.data != null) {
  //     return List<FarmItem>.from(response.data.map((item) => FarmItem.fromJson(item)));
  //   } else {
  //     return null;
  //   }
  // }
  //
  // Future<ApiResponse> createFarm({required String name, required String acreage, required String unit, required String address}) async {
  //   final token = await tokenModel();
  //   final params = {"uk": token?.uk, "name": name, "acreage": acreage, "unit": unit, "address": address};
  //   return await post(CREATE_FARM, data: params);
  // }
  //
  // Future<ApiResponse> updateFarm({required String fk, required String name, required String acreage, required String unit, required String address}) async {
  //   final token = await tokenModel();
  //   final params = {"uk": token?.uk, "fk": fk, "name": name, "acreage": acreage, "unit": unit, "address": address};
  //   return await post(UPDATE_FARM, data: params);
  // }
  //
  // Future<List<ProvinceItem>?> getListProvince() async {
  //   final token = await tokenModel();
  //   final params = {"uk": token?.uk, "fk": token?.fk};
  //   final response = await post(REGION_PROVINCE, data: params);
  //   if (response.data != null) {
  //     return List<ProvinceItem>.from(response.data.map((item) => ProvinceItem.fromJson(item)));
  //   } else {
  //     return null;
  //   }
  // }
  //
  // Future<List<ProvinceItem>?> getListDistrict(String code) async {
  //   final token = await tokenModel();
  //   final params = {"uk": token?.uk, "fk": token?.fk, "code": code};
  //   final response = await post(REGION_DISTRICT, data: params);
  //   if (response.data != null) {
  //     return List<ProvinceItem>.from(response.data.map((item) => ProvinceItem.fromJson(item)));
  //   } else {
  //     return null;
  //   }
  // }
  //
  // Future<List<ProvinceItem>?> getListWard(String code) async {
  //   final token = await tokenModel();
  //   final params = {"uk": token?.uk, "fk": token?.fk, "code": code};
  //   final response = await post(REGION_WARD, data: params);
  //   if (response.data != null) {
  //     return List<ProvinceItem>.from(response.data.map((item) => ProvinceItem.fromJson(item)));
  //   } else {
  //     return null;
  //   }
  // }
}

import 'package:get/get.dart';

import '../models/rss/feed_model.dart';
import '../services/rss_service.dart';
import 'base_repository.dart';

class RssRepository extends BaseRepository {
  final _rssService = Get.find<RSSService>();

  Future<List<FeedModel?>> getInitRss() async {
    final listFeed = await _rssService.getInitRss();
    return listFeed;
  }

  Future<FeedModel?> getFeed(String url) async {
    final feed = await _rssService.parseRss(url);
    return feed;
  }

  // Future<String> getNameFarm(List<FarmItem>? listFarm) async => _farmService.getNameFarm(listFarm);
  //
  // Future<List<FarmItem>?> getListFarm() async => _farmService.getListFarm();
  //
  // Future<ApiResponse> updateFarm({required String fk, required String name, required String acreage, required String unit, required String address}) async {
  //   return await _farmService.updateFarm(fk: fk, name: name, acreage: acreage, unit: unit, address: address);
  // }
  //
  // Future<ApiResponse> createFarm({required String name, required String acreage, required String unit, required String address}) async {
  //   return await _farmService.createFarm(name: name, acreage: acreage, unit: unit, address: address);
  // }
  //
  // Future<List<ProvinceItem>?> getListProvince() async => await _farmService.getListProvince();
  //
  // Future<List<ProvinceItem>?> getListDistrict(String code) async => await _farmService.getListDistrict(code);
  //
  // Future<List<ProvinceItem>?> getListWard(String code) async => await _farmService.getListWard(code);
}

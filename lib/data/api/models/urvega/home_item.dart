import 'package:flutter_news_cast/data/storage/key_constant.dart';

class HomeItem {
  String? icon;
  String? name;
  bool? isSize;
  String? size;
  String? address;
  DEVICE_TYPE type = DEVICE_TYPE.CONTROL;

  @override
  String toString() {
    return 'HomeItem{icon: $icon, name: $name, isSize: $isSize, size: $size, address: $address, type: $type}';
  }

  HomeItem(this.icon, this.name, this.isSize, this.size, this.address, this.type);
}

import 'package:flutter_news_cast/data/storage/key_constant.dart';
import 'package:flutter_news_cast/res/gen/assets.gen.dart';

/// device_type_name : "Cảm biến mực\nnước"
/// data : "-"
/// device_type_id : 1
/// name : "Ruộng Kênh\n9"
/// icon : "https://st.urvega.com/app/muc-nuoc.png"
/// connecting : false
/// serial_no : "SDSDUNB-128G-GN6IN"

class DeviceItem {
  DeviceItem({
    String? deviceTypeName,
    String? data,
    num? deviceTypeId,
    String? name,
    String? icon,
    bool? connecting,
    String? serialNo,
  }) {
    _deviceTypeName = deviceTypeName;
    _data = data;
    _deviceTypeId = deviceTypeId;
    _name = name;
    _icon = icon;
    _connecting = connecting;
    _serialNo = serialNo;
  }

  @override
  String toString() {
    return 'DeviceItem{_deviceTypeName: $_deviceTypeName, _data: $_data, _deviceTypeId: $_deviceTypeId, _name: $_name, _icon: $_icon, _connecting: $_connecting, _serialNo: $_serialNo}';
  }

  DeviceItem.fromJson(dynamic json) {
    _deviceTypeName = json['device_type_name'];
    _data = json['data'];
    _deviceTypeId = json['device_type_id'];
    _name = json['name'];
    _icon = json['icon'];
    _connecting = json['connecting'];
    _serialNo = json['serial_no'];
  }

  String? _deviceTypeName;
  String? _data;
  num? _deviceTypeId;
  String? _name;
  String? _icon;
  bool? _connecting;
  String? _serialNo;

  String? get deviceTypeName => _deviceTypeName;

  String? get data => _data;

  num? get deviceTypeId => _deviceTypeId;

  String? get name => _name;

  String? get icon => _icon;

  bool? get connecting => _connecting;

  String? get serialNo => _serialNo;

  bool? get isOn => data == CONTROL_TYPE.ON.name;

  bool? get isOff => data == CONTROL_TYPE.OFF.name;

  bool? get isControl => isOn == true || isOff == true;

  String? get getIcon => isOn == true ? Assets.icons.icButtonOnL.path : Assets.icons.icButtonOffL.path;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['device_type_name'] = _deviceTypeName;
    map['data'] = _data;
    map['device_type_id'] = _deviceTypeId;
    map['name'] = _name;
    map['icon'] = _icon;
    map['connecting'] = _connecting;
    map['serial_no'] = _serialNo;
    return map;
  }

  DeviceItem copyWith({
    String? deviceTypeName,
    String? data,
    num? deviceTypeId,
    String? name,
    String? icon,
    bool? connecting,
    String? serialNo,
  }) {
    return DeviceItem(
      deviceTypeName: deviceTypeName ?? this.deviceTypeName,
      data: data ?? this.data,
      deviceTypeId: deviceTypeId ?? this.deviceTypeId,
      name: name ?? this.name,
      icon: icon ?? this.icon,
      connecting: connecting ?? this.connecting,
      serialNo: serialNo ?? this.serialNo,
    );
  }
}

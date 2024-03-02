class DeviceDetailItem {
  DeviceDetailItem({
    this.dataList,
    this.deviceTypeName,
    this.deviceTypeId,
    this.name,
    this.icon,
    this.connecting,
    this.serialNo,
  });

  @override
  String toString() {
    return 'DeviceDetailItem{dataList: $dataList, deviceTypeName: $deviceTypeName, deviceTypeId: $deviceTypeId, name: $name, icon: $icon, connecting: $connecting, serialNo: $serialNo}';
  }

  DeviceDetailItem.fromJson(dynamic json) {
    dataList = json['data'] != null ? DeviceDetailData.fromJson(json['data']) : null;
    deviceTypeName = json['device_type_name'];
    deviceTypeId = json['device_type_id'];
    name = json['name'];
    icon = json['icon'];
    connecting = json['connecting'];
    serialNo = json['serial_no'];
  }

  DeviceDetailData? dataList;
  String? deviceTypeName;
  num? deviceTypeId;
  String? name;
  String? icon;
  bool? connecting;
  String? serialNo;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['data'] = dataList;
    map['device_type_name'] = deviceTypeName;
    map['device_type_id'] = deviceTypeId;
    map['name'] = name;
    map['icon'] = icon;
    map['connecting'] = connecting;
    map['serial_no'] = serialNo;
    map.removeWhere((dynamic key, dynamic value) => key == null || value == null || value == '');
    return map;
  }
}

class DeviceDetailData {
  DeviceDetailData({
    //Air
    this.light,
    this.temperature,
    this.humidity,
    this.highestTemperature,
    this.lowestTemperature,
    this.heatindex,
    //Water
    this.waterLevelValue,
    this.comparisonValue,
    this.waterLevelText,
    this.comparisonText,
  });

  @override
  String toString() {
    return 'DeviceDetailData{light: $light, temperature: $temperature, humidity: $humidity, highestTemperature: $highestTemperature, lowestTemperature: $lowestTemperature, heatindex: $heatindex, waterLevelValue: $waterLevelValue, comparisonValue: $comparisonValue, waterLevelText: $waterLevelText, comparisonText: $comparisonText}';
  }

  DeviceDetailData.fromJson(dynamic json) {
    try {
      //Air
      light = json['light'];
      temperature = json['temperature'];
      humidity = json['humidity'];
      highestTemperature = json['highest_temperature'];
      lowestTemperature = json['lowest_temperature'];
      heatindex = json['heatindex'];
      //Water
      waterLevelValue = json['water_level_value'];
      comparisonValue = json['comparison_value'];
      waterLevelText = json['water_level_text'];
      comparisonText = json['comparison_text'];
    } catch (e) {
      print(e);
    }
  }

  //Air
  String? light;
  String? temperature;
  String? humidity;
  String? highestTemperature;
  String? lowestTemperature;
  String? heatindex;

  //Water
  num? waterLevelValue;
  String? comparisonValue;
  String? waterLevelText;
  String? comparisonText;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    //Air
    map['light'] = light;
    map['temperature'] = temperature;
    map['humidity'] = humidity;
    map['highest_temperature'] = highestTemperature;
    map['lowest_temperature'] = lowestTemperature;
    map['heatindex'] = heatindex;
    //Water
    map['water_level_value'] = waterLevelValue;
    map['comparison_value'] = comparisonValue;
    map['water_level_text'] = waterLevelText;
    map['comparison_text'] = comparisonText;
    map.removeWhere((dynamic key, dynamic value) => key == null || value == null || value == '');
    return map;
  }
}

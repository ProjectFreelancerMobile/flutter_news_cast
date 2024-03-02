class ChartDevice {
  ChartDevice({
    this.unit,
    this.color,
    this.axisYType,
    this.name,
    this.dataPoints,
  });

  ChartDevice.fromJson(dynamic json) {
    unit = json['unit'];
    color = json['color'];
    axisYType = json['axisYType'];
    name = json['name'];
    if (json['dataPoints'] != null) {
      dataPoints = [];
      json['dataPoints'].forEach((v) {
        dataPoints?.add(DataPoints.fromJson(v));
      });
    }
  }

  String? unit;
  String? color;
  String? axisYType;
  String? name;
  List<DataPoints>? dataPoints;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['unit'] = unit;
    map['color'] = color;
    map['axisYType'] = axisYType;
    map['name'] = name;
    if (dataPoints != null) {
      map['dataPoints'] = dataPoints?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class DataPoints {
  DataPoints({
    this.date,
    this.value,
  });

  DataPoints.fromJson(dynamic json) {
    date = json['date'];
    value = json['value'];
  }

  int? date;
  double? value;

  @override
  String toString() {
    return 'DataPoints{date: $date, value: $value}';
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['date'] = date;
    map['value'] = value;
    return map;
  }
}

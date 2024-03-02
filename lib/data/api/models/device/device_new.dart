class DeviceItemNew {
  DeviceItemNew({
    this.code,
    this.sn,
  });

  @override
  String toString() {
    return 'DeviceItemNew{code: $code, sn: $sn}';
  }

  DeviceItemNew.fromJson(dynamic json) {
    code = json['code'];
    sn = json['sn'];
  }

  String? code;
  String? sn;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = code;
    map['sn'] = sn;
    return map;
  }
}

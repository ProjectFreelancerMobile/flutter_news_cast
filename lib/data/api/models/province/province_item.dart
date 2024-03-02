/// code : "01"
/// name : "Hà Nội"
class ProvinceItem {
  ProvinceItem({
    String? code,
    String? name,
  }) {
    _code = code;
    _name = name;
  }

  @override
  String toString() {
    return 'ProvinceItem{_code: $_code, _name: $_name}';
  }

  ProvinceItem.fromJson(dynamic json) {
    _code = json['code'];
    _name = json['name'];
  }

  String? _code;
  String? _name;

  String? get code => _code;

  String? get name => _name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = _code;
    map['name'] = _name;
    return map;
  }
}

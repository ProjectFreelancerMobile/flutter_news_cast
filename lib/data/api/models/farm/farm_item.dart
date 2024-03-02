class FarmItem {
  FarmItem({
    this.unit,
    this.address,
    this.fkey,
    this.name,
    this.countryName,
    this.acreage,
  });

  @override
  String toString() {
    return 'FarmItem{unit: $unit, address: $address, fkey: $fkey, name: $name, countryName: $countryName, acreage: $acreage}';
  }

  FarmItem.fromJson(dynamic json) {
    unit = json['unit'];
    address = json['address'];
    fkey = json['fkey'];
    name = json['name'];
    countryName = json['country_name'];
    acreage = json['acreage'];
  }

  String? unit;
  String? address;
  String? fkey;
  String? name;
  String? countryName;
  double? acreage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['unit'] = unit;
    map['address'] = address;
    map['fkey'] = fkey;
    map['name'] = name;
    map['country_name'] = countryName;
    map['acreage'] = acreage;
    return map;
  }
}

class ManagerItem {
  String? name;
  String? size;
  String? unit;
  String? address;
  String? ward;
  String? district;

  @override
  String toString() {
    return 'ManagerItem{name: $name, size: $size, unit: $unit, address: $address, ward: $ward, district: $district, province: $province}';
  }

  String? province;

  String? get getLocationAddress => address?.isNotEmpty == true ? "$address, " : "";

  String? get getLocationWard => ward?.isNotEmpty == true ? "$ward, " : "";

  String? get getLocationDistrict => district?.isNotEmpty == true ? "$district, " : "";

  String? get getLocationProvince => province?.isNotEmpty == true ? "$province" : "";

  String? get addressLite => "$getLocationWard$getLocationDistrict$getLocationProvince";

  String? get addressFull => "$getLocationAddress$getLocationWard$getLocationDistrict$getLocationProvince";

  ManagerItem({this.name, this.size, this.unit, this.address, this.ward, this.district, this.province});
}

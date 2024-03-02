import '../converters/date_time_converter.dart';

/// birthday : "1980-01-01"
/// gender : 1
/// phone : ""
/// name : "Chương"

class TUser {
  TUser({
    DateTime? birthday,
    num? gender,
    String? phone,
    String? name,
  }) {
    _birthday = birthday;
    _gender = gender;
    _phone = phone;
    _name = name;
  }

  @override
  String toString() {
    return 'TUser{_birthday: $_birthday, _gender: $_gender, _phone: $_phone, _name: $_name}';
  }

  final dateTime = DateTimeConverter();

  TUser.fromJson(dynamic json) {
    _birthday = dateTime.fromJson(json['birthday']);
    _gender = json['gender'];
    _phone = json['phone'];
    _name = json['name'];
  }

  DateTime? _birthday;
  num? _gender;
  String? _phone;
  String? _name;

  DateTime? get birthday => _birthday;

  num? get gender => _gender;

  String? get phone => _phone;

  String? get name => _name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['birthday'] = dateTime.toJson(_birthday ?? DateTime.now());
    map['gender'] = _gender;
    map['phone'] = _phone;
    map['name'] = _name;
    return map;
  }

  TUser copyWith() {
    return TUser(
      birthday: _birthday,
      gender: _gender,
      name: _name,
      phone: _phone,
    );
  }

  updateUser({DateTime? birthday, num? gender, String? phone, String? name}) {
    this._birthday = birthday ?? this._birthday;
    this._gender = gender ?? this._gender;
    this._phone = phone ?? this._phone;
    this._name = name ?? this._name;
  }
}

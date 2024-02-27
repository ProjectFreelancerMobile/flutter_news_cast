import '../../../utils/data_util.dart';

class TUser {
  TUser({
    String? userName,
    String? displayName,
    num? balance,
    String? soDienThoai,
    String? soTaiKhoan,
    bool? sdSTKDeKiemTra,
    List<dynamic>? bienDong,
    List<dynamic>? taiKhoanChuyenTien,
  }) {
    _userName = userName;
    _displayName = displayName;
    _balance = balance;
    _soDienThoai = soDienThoai;
    _soTaiKhoan = soTaiKhoan;
    _sdSTKDeKiemTra = sdSTKDeKiemTra;
    _bienDong = bienDong;
    _taiKhoanChuyenTien = taiKhoanChuyenTien;
  }

  @override
  String toString() {
    return 'TUser{_userName: $_userName, _displayName: $_displayName, _balance: $_balance, _soDienThoai: $_soDienThoai, _soTaiKhoan: $_soTaiKhoan, _sdSTKDeKiemTra: $_sdSTKDeKiemTra, _bienDong: $_bienDong, _taiKhoanChuyenTien: $_taiKhoanChuyenTien}';
  }

  String? _userName;
  String? _displayName;
  num? _balance;
  String? _soDienThoai;
  String? _soTaiKhoan;
  bool? _sdSTKDeKiemTra;
  List<dynamic>? _bienDong;
  List<dynamic>? _taiKhoanChuyenTien;

  String get userName => _userName ?? _displayName ?? '';

  String? get displayName => _displayName;

  num get balance => _balance ?? 0;

  String get getTotalMoney => formatCurrencyRaw(balance);

  String? get soDienThoai => _soDienThoai;

  String get soTaiKhoan => _soTaiKhoan ?? '';

  bool get sdSTKDeKiemTra => _sdSTKDeKiemTra ?? false;

  List<dynamic> get bienDong => _bienDong ?? List.empty();

  List<dynamic> get taiKhoanChuyenTien => _taiKhoanChuyenTien ?? List.empty();

  bool get userExist => userName.isNotEmpty && soTaiKhoan.isNotEmpty;

  Map<String, dynamic> toJson() {
    return {
      'userName': _userName,
      'displayName': _displayName,
      'balance': _balance,
      'soDienThoai': _soDienThoai,
      'soTaiKhoan': _soTaiKhoan,
      'bienDong': _bienDong,
      'taiKhoanChuyenTien': _taiKhoanChuyenTien,
      'sdSTKDeKiemTra': _sdSTKDeKiemTra,
    };
  }

  TUser.fromJson(Map<String, dynamic> json)
      : _userName = json['userName'],
        _displayName = json['displayName'],
        _balance = json['balance'],
        _soDienThoai = json['soDienThoai'],
        _soTaiKhoan = json['soTaiKhoan'],
        _bienDong = json['bienDong'] ?? [],
        _taiKhoanChuyenTien = json['taiKhoanChuyenTien'] ?? [],
        _sdSTKDeKiemTra = json['sdSTKDeKiemTra'];

  updateUser({num? balance}) {
    this._balance = balance ?? this._balance;
  }
}

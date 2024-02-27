/// success : 1
/// results : {"account":"0934233135","bank":"970422","ownerName":"NGUYEN TAN THANH","message":"Account inquiry\nsuccessful !","responseCode":"00","systemTrace":"739701"}

class PaymentInfoItem {
  PaymentInfoItem({
    num? success,
    Results? results,
  }) {
    _success = success;
    _results = results;
  }

  PaymentInfoItem.fromJson(dynamic json) {
    _success = json['success'];
    _results = json['results'] != null ? Results.fromJson(json['results']) : null;
  }

  num? _success;
  Results? _results;

  @override
  String toString() {
    return 'PaymentInfoItem{_success: $_success, _results: $_results}';
  }

  PaymentInfoItem copyWith({
    num? success,
    Results? results,
  }) =>
      PaymentInfoItem(
        success: success ?? _success,
        results: results ?? _results,
      );

  num? get success => _success;

  Results? get results => _results;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = _success;
    if (_results != null) {
      map['results'] = _results?.toJson();
    }
    return map;
  }
}

/// account : "0934233135"
/// bank : "970422"
/// ownerName : "NGUYEN TAN THANH"
/// message : "Account inquiry\nsuccessful !"
/// responseCode : "00"
/// systemTrace : "739701"

class Results {
  Results({
    String? account,
    String? bank,
    String? ownerName,
    String? message,
    String? responseCode,
    String? systemTrace,
  }) {
    _account = account;
    _bank = bank;
    _ownerName = ownerName;
    _message = message;
    _responseCode = responseCode;
    _systemTrace = systemTrace;
  }

  Results.fromJson(dynamic json) {
    _account = json['account'];
    _bank = json['bank'];
    _ownerName = json['ownerName'];
    _message = json['message'];
    _responseCode = json['responseCode'];
    _systemTrace = json['systemTrace'];
  }

  String? _account;
  String? _bank;
  String? _ownerName;
  String? _message;
  String? _responseCode;
  String? _systemTrace;

  Results copyWith({
    String? account,
    String? bank,
    String? ownerName,
    String? message,
    String? responseCode,
    String? systemTrace,
  }) =>
      Results(
        account: account ?? _account,
        bank: bank ?? _bank,
        ownerName: ownerName ?? _ownerName,
        message: message ?? _message,
        responseCode: responseCode ?? _responseCode,
        systemTrace: systemTrace ?? _systemTrace,
      );

  String? get account => _account;

  String? get bank => _bank;

  String? get ownerName => _ownerName;

  String? get message => _message;

  String? get responseCode => _responseCode;

  String? get systemTrace => _systemTrace;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['account'] = _account;
    map['bank'] = _bank;
    map['ownerName'] = _ownerName;
    map['message'] = _message;
    map['responseCode'] = _responseCode;
    map['systemTrace'] = _systemTrace;
    return map;
  }
}

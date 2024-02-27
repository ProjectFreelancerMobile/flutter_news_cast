class List_Bank {
  String? code;
  String? desc;
  List<BankDetail>? data;

  List_Bank({this.code, this.desc, this.data});

  List_Bank.fromJson(Map<String, dynamic> json) {
    print('List_Bank::' + json.toString());
    code = json['code'];
    desc = json['desc'];
    if (json['data'] != null) {
      data = <BankDetail>[];
      json['data'].forEach((v) {
        data!.add(BankDetail.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['desc'] = this.desc;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BankDetail {
  int? id;
  String? name;
  String? nameBill;
  String? code;
  String? bin;
  String? shortName;
  String? logo;
  int? transferSupported;
  int? lookupSupported;
  int? support;
  int? isTransfer;

  @override
  String toString() {
    return 'BankDetail{name: $name, bin: $bin}';
  }

  String? swiftCode;

  BankDetail(
      {this.id,
      this.name,
      this.nameBill,
      this.code,
      this.bin,
      this.shortName,
      this.logo,
      this.transferSupported,
      this.lookupSupported,
      this.support,
      this.isTransfer,
      this.swiftCode});

  BankDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    nameBill = json['nameBill'];
    code = json['code'];
    bin = json['bin'];
    shortName = json['shortName'];
    logo = json['logo'];
    transferSupported = json['transferSupported'];
    lookupSupported = json['lookupSupported'];
    support = json['support'];
    isTransfer = json['isTransfer'];
    swiftCode = json['swift_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['nameBill'] = this.nameBill;
    data['code'] = this.code;
    data['bin'] = this.bin;
    data['shortName'] = this.shortName;
    data['logo'] = this.logo;
    data['transferSupported'] = this.transferSupported;
    data['lookupSupported'] = this.lookupSupported;
    data['support'] = this.support;
    data['isTransfer'] = this.isTransfer;
    data['swift_code'] = this.swiftCode;
    return data;
  }
}

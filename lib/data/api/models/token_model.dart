class TokenModel {
  String? uk;
  String? fk;

  TokenModel(this.uk, this.fk);

  TokenModel.fromJson(Map<String, dynamic> json) {
    uk = json['uk'];
    fk = json['fk'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['uk'] = this.uk;
    data['fk'] = this.fk;
    return data;
  }

  @override
  String toString() {
    return 'TUser{uk: $uk, fk: $fk}';
  }
}

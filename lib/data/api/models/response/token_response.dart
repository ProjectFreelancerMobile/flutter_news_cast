class TokenResponse {
  String? id;
  String? accessToken;
  String? tokenType;
  int? expiresIn;
  String? scope;

  TokenResponse({this.id, this.accessToken, this.tokenType, this.expiresIn, this.scope});

  TokenResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    accessToken = json['access_token'];
    tokenType = json['token_type'];
    expiresIn = json['expires_in'];
    scope = json['scope'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['access_token'] = this.accessToken;
    data['token_type'] = this.tokenType;
    data['expires_in'] = this.expiresIn;
    data['scope'] = this.scope;
    return data;
  }
}

class ConfigCDN {
  String? cdnUrl;

  ConfigCDN({this.cdnUrl});

  ConfigCDN.fromJson(Map<String, dynamic> json) {
    cdnUrl = json['cdnUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cdnUrl'] = this.cdnUrl;
    return data;
  }
}

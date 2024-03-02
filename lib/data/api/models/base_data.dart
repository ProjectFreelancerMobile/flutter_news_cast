class BaseData {
  String? id;
  String? name;

  BaseData({this.id, this.name});

  factory BaseData.fromJson(Map<String, dynamic> json) => BaseData(
        id: json["id"],
        name: json["name"] ?? "",
      );

  Map<String, dynamic> toJson() => {"id": id, "name": name};
}

class ApiResponse {
  ApiResponse({this.code, this.status, this.total, this.message, this.data});

  int? code = 0;
  int? total;
  String? message;
  String? status;
  dynamic data;

  @override
  String toString() {
    return 'ApiResponse{code: $code, total: $total, message: $message, status: $status, data: $data}';
  }

  factory ApiResponse.fromJson(Map<String, dynamic> json) => ApiResponse(
        code: json["code"],
        status: json["status"],
        total: json.containsKey("total") ? json["total"] : 0,
        message: json["msg"],
        data: json["data"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "status": status,
        "total": total,
        "msg": message,
        "data": data,
      };
}

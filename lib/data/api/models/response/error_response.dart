class ErrorResponse {
  String? message;
  int? code;

  ErrorResponse({this.code = 200, this.message});

  factory ErrorResponse.fromJson(Map<String, dynamic> json) => ErrorResponse(
        code: json["code"],
        message: json["msg"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "msg": message,
      };
}

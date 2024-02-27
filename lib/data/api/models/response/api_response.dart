class ApiResponse {
  ApiResponse({this.message, this.data, this.success});

  String? message;
  bool? success;
  dynamic data;

  @override
  String toString() {
    return 'ApiResponse{message: $message, success: $success, data: $data}';
  }

  factory ApiResponse.fromJson(Map<String, dynamic> json) => ApiResponse(
        success: json["success"],
        message: json["message"],
        data: json["data"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data,
      };
}

part of 'api_response.dart';

extension ApiResponseExt on ApiResponse {
  ApiResponse copyWith({
    bool? success,
    int? statusCode,
    String? message,
    dynamic data,
  }) {
    return ApiResponse()
      ..success = success ?? this.success
      ..statusCode = statusCode ?? this.statusCode
      ..message = message ?? this.message
      ..data = data ?? this.data;
  }

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {
        _Json.success: success,
        _Json.statusCode: statusCode,
        _Json.message: message,
        _Json.data: data,
      };
}

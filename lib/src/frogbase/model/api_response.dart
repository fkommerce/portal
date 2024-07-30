import 'dart:convert';

part 'api_response_ext.dart';

class ApiResponse {
  ApiResponse();

  bool success = false;
  int statusCode = 0;
  String message = '';
  int page = 1;
  int limit = 20;
  String? filter;
  dynamic data;

  factory ApiResponse.fromRawJson(String source) =>
      ApiResponse.fromJson(json.decode(source));

  factory ApiResponse.fromJson(Map<String, dynamic> map) => ApiResponse()
    ..success = map[_Json.success] ?? false
    ..statusCode = map[_Json.statusCode] ?? 0
    ..message = map[_Json.message] ?? 'No Message'
    ..page = map[_Json.page] ?? 1
    ..limit = map[_Json.limit] ?? 20
    ..filter = map[_Json.filter]
    ..data = map[_Json.data];

  @override
  String toString() =>
      'ApiResponse(success: $success, statusCode: $statusCode, message: $message, data: $data)';
}

class _Json {
  static const String success = 'success';
  static const String statusCode = 'statusCode';
  static const String message = 'message';
  static const String page = 'page';
  static const String limit = 'limit';
  static const String filter = 'filter';
  static const String data = 'data';
}

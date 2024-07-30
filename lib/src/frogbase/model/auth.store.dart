import 'dart:convert' show base64, base64Decode, json, jsonDecode, utf8;

import '../../db/hive.dart';
import '../../utils/extensions/extensions.dart';
import 'package:hive/hive.dart';

import '../../config/constants.dart';

part 'auth.store.ext.dart';
part 'auth.store.g.dart';

@HiveType(typeId: HiveTypes.authStore)
class AuthStore extends HiveObject {
  @HiveField(0)
  String storeId;
  @HiveField(1)
  String managementId;
  @HiveField(2)
  String accessToken;
  @HiveField(3)
  String refreshToken;

  AuthStore({
    required this.storeId,
    required this.managementId,
    required this.accessToken,
    required this.refreshToken,
  });

  factory AuthStore.fromJson(Map<String, dynamic> json) => AuthStore(
        storeId: json[_Json.storeId] as String,
        managementId: json[_Json.managementId] as String,
        accessToken: json[_Json.accessToken] as String,
        refreshToken: json[_Json.refreshToken] as String,
      );

  factory AuthStore.fromRawJson(String source) =>
      AuthStore.fromJson(json.decode(source));

  // to json
  Map<String, dynamic> toJson() => {
        _Json.storeId: storeId,
        _Json.managementId: managementId,
        _Json.accessToken: accessToken,
        _Json.refreshToken: refreshToken,
      };

  String toRawJson() => json.encode(toJson());

  @override
  String toString() =>
      'AuthStore(storeId: $storeId, managementId: $managementId, accessToken: $accessToken, refreshToken: $refreshToken)';

  bool get isAccessTokenValid => _isValid(accessToken);
  bool get isRefreshTokenValid => _isValid(refreshToken);

  bool _isValid(String token) {
    final parts = token.split('.');
    if (parts.length != 3) return false;

    final tokenPart = base64.normalize(parts[1]);
    final data = jsonDecode(utf8.decode(base64Decode(tokenPart)))
        as Map<String, dynamic>;

    final exp = data['exp'] is int
        ? data['exp'] as int
        : (int.tryParse(data['exp'].toString()) ?? 0);

    return exp > (DateTime.now().millisecondsSinceEpoch / 1000);
  }
}

class _Json {
  static const storeId = 'store_id';
  static const managementId = 'management_id';
  static const accessToken = 'access_token';
  static const refreshToken = 'refresh_token';
}

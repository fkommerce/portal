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
  String managementId;
  @HiveField(1)
  String accessToken;
  @HiveField(2)
  String refreshToken;
  @HiveField(3)
  List<String> storeIds;
  @HiveField(4)
  String selectedStoreId;
  @HiveField(5)
  String? selectedBranchId;

  AuthStore({
    required this.managementId,
    required this.accessToken,
    required this.refreshToken,
    required this.storeIds,
    required this.selectedStoreId,
    this.selectedBranchId,
  });

  factory AuthStore.fromJson(Map<String, dynamic> json) => AuthStore(
        managementId: json[_Json.managementId] as String,
        accessToken: json[_Json.accessToken] as String,
        refreshToken: json[_Json.refreshToken] as String,
        storeIds: (json[_Json.storeIds] as List).map((e) => e as String).toList(),
        selectedStoreId: json[_Json.selectedStoreId] as String,
        selectedBranchId: json[_Json.selectedBranchId] as String?,
      );

  factory AuthStore.fromRawJson(String source) =>
      AuthStore.fromJson(json.decode(source));

  // to json
  Map<String, dynamic> toJson() => {
        _Json.managementId: managementId,
        _Json.accessToken: accessToken,
        _Json.refreshToken: refreshToken,
        _Json.storeIds: storeIds,
        _Json.selectedStoreId: selectedStoreId,
        _Json.selectedBranchId: selectedBranchId,
      };

  String toRawJson() => json.encode(toJson());

  @override
  String toString() =>
      'AuthStore(managementId: $managementId, accessToken: $accessToken, refreshToken: $refreshToken, storeIds: $storeIds, selectedStoreId: $selectedStoreId, selectedBranchId: $selectedBranchId)';

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
  static const managementId = 'management_id';
  static const accessToken = 'access_token';
  static const refreshToken = 'refresh_token';
  static const storeIds = 'store_ids';
  static const selectedStoreId = 'selected_store_id';
  static const selectedBranchId = 'selected_branch_id';
}

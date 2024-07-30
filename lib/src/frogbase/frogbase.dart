import 'dart:convert';

import 'package:beamer/beamer.dart';
import 'model/api_response.dart';
import 'model/auth.store.dart';
import 'utils/helpers.dart';
import '../utils/extensions/extensions.dart';
import 'package:http/http.dart' as http;

import '../config/constants.dart';
import '../db/hive.dart';
import '../utils/logger/logger_helper.dart';

late BeamerDelegate globalBeamDelegate;

class Frogbase {
  late AuthStore? authStore;

  Future<void> init() async {
    authStore = Boxes.authStores.get(appName.toCamelWord);
    log.f('AuthStore: $authStore');
    log.f('AuthStore: ${authStore?.isAccessTokenValid}');
    if (authStore != null && !authStore!.isRefreshTokenValid) {
      await signout();
      log.e('Automatically signed out due to invalid refresh token.');
    } else if (authStore != null && !authStore!.isAccessTokenValid) {
      log.i('Automatically refreshing access token.');
      await _refreshToken();
    }
    listenForAuthStore();
  }

  void listenForAuthStore() {
    Boxes.authStores
        .watch(key: appName.toCamelWord)
        .listen((_) => authStore = Boxes.authStores.get(appName.toCamelWord));
  }

  Future<void> signup({required Map<String, dynamic> data}) async {
    final response = await apiRequest(
      'POST',
      'store',
      data: data,
      isAuthRequired: false,
    );
    final apiModel = ApiResponse.fromRawJson(response);
    if (!apiModel.success) throw apiModel.message;
    authStore = AuthStore(
      storeId: apiModel.data['store']['id'],
      managementId: apiModel.data['management']['data']['id'],
      accessToken: apiModel.data['management']['tokens']['access-token'],
      refreshToken: apiModel.data['management']['tokens']['refresh-token'],
    );
    await authStore!.saveData();
  }

  Future<void> signin(String email, String password) async {
    final response = await apiRequest(
      'POST',
      'management/signin',
      data: {
        'email': email,
        'password': password,
      },
      isAuthRequired: false,
    );
    final apiModel = ApiResponse.fromRawJson(response);
    if (!apiModel.success) throw apiModel.message;
    authStore = AuthStore(
      storeId: apiModel.data['store']['id'],
      managementId: apiModel.data['management']['data']['id'],
      accessToken: apiModel.data['management']['tokens']['access-token'],
      refreshToken: apiModel.data['management']['tokens']['refresh-token'],
    );
    await authStore!.saveData();
  }

  Future<void> signout() async {
    try {
      await authStore?.deleteData();
      authStore = null;
    } catch (e) {
      rethrow;
    }
  }

  Future<String?> get _token async {
    if (authStore == null) return null;
    if (authStore!.isAccessTokenValid) return authStore!.accessToken;
    return await _refreshToken();
  }

  Future<String?> _refreshToken() async {
    if (authStore == null) return null;
    if (!authStore!.isRefreshTokenValid) {
      await signout();
      globalBeamDelegate.update();
      return null;
    }
    final response = await apiRequest(
      'POST',
      'management/regenerate-tokens',
      data: {'refresh-token': authStore!.refreshToken},
      isAuthRequired: false,
    );
    final apiModel = ApiResponse.fromRawJson(response);
    if (!apiModel.success) throw apiModel.message;
    authStore!.accessToken = apiModel.data['access-token'];
    authStore!.refreshToken = apiModel.data['refresh-token'];
    log.i('New access tokens: ${apiModel.data}');
    await authStore!.save();
    return authStore!.accessToken;
  }

  Future<String> apiRequest(
    String method,
    String endPoint, {
    Map<String, dynamic>? data,
    bool isAuthRequired = true,
  }) async {
    final token = await _token;
    if (isAuthRequired && token == null) throw 'Session expired. Please sign in again.';
    final headers = {
      'Content-Type': 'application/json',
      if (isAuthRequired) 'Authorization': 'Bearer $token',
    };
    var request = http.Request(method, Uri.parse('$apiBaseUrl/$endPoint'));
    if (data != null) request.body = json.encode(data);
    request.headers.addAll(headers);

    final response = await request.send();
    final body = await response.stream.bytesToString();
    log.i('Response of $endPoint by $method: $body');
    return body;
  }

  Future<http.StreamedResponse> storeFile(List<String> paths) async {
    final headers = {'Authorization': 'Bearer $_token'};
    final request =
        http.MultipartRequest('POST', Uri.parse('$apiBaseUrl/file'));
    for (final path in paths) {
      request.files.add(await http.MultipartFile.fromPath('files', path));
    }
    request.headers.addAll(headers);

    return await request.send();
  }
}

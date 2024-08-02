import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../model/management.dart';

import '../../../frogbase/model/api_response.dart';
import '../../../frogbase/utils/helpers.dart';

typedef CurrentManagementNotifier
    = AsyncNotifierProvider<CurrentManagementProvider, Management>;

final currentManagementProvider =
    CurrentManagementNotifier(CurrentManagementProvider.new);

class CurrentManagementProvider extends AsyncNotifier<Management> {
  late Management _management;
  @override
  FutureOr<Management> build() async {
    final body = await fb.apiRequest(
      'GET',
      'management/${fb.authStore?.managementId}',
    );
    final apiModel = ApiResponse.fromRawJson(body);
    _management = Management.fromJson(apiModel.data);
    return _management;
  }

  Management get management => _management;

  Future<void> refresh() async {
    final body = await fb.apiRequest(
      'GET',
      'management/${fb.authStore?.managementId}',
    );
    final apiModel = ApiResponse.fromRawJson(body);
    _management = Management.fromJson(apiModel.data);
    ref.notifyListeners();
  }
}
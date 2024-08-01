import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../frogbase/model/api_response.dart';
import '../../../frogbase/utils/helpers.dart';
import '../model/store.dart';

typedef StoreNotifier = AsyncNotifierProvider<StoreProvider, Store>;

final storeProvider = StoreNotifier(StoreProvider.new);

class StoreProvider extends AsyncNotifier<Store> {
  late Store _store;

  @override
  FutureOr<Store> build() async {
    final body =
        await fb.apiRequest('GET', 'store/${fb.authStore?.selectedStoreId}');
    final ApiResponse apiModel = ApiResponse.fromRawJson(body);
    _store = Store.fromJson(apiModel.data);
    return _store;
  }

  Store get store => _store;

  Future<void> refresh() async {
    final body =
        await fb.apiRequest('GET', 'store/${fb.authStore?.selectedStoreId}');
    final ApiResponse apiModel = ApiResponse.fromRawJson(body);
    _store = Store.fromJson(apiModel.data);
    ref.notifyListeners();
  }
}

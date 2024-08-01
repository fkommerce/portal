import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../frogbase/model/auth.store.dart';

import '../../../frogbase/model/api_response.dart';
import '../../../frogbase/utils/helpers.dart';
import '../model/branch.dart';

typedef BranchesNotifier
    = AsyncNotifierProvider<BranchesProvider, List<Branch>>;

final branchesProvider = BranchesNotifier(BranchesProvider.new);

class BranchesProvider extends AsyncNotifier<List<Branch>> {
  late List<Branch> _branches;
  @override
  FutureOr<List<Branch>> build() async {
    _branches = [];
    final body = await fb.apiRequest(
        'GET', 'branch/store/${fb.authStore?.selectedStoreId}');
    final ApiResponse apiModel = ApiResponse.fromRawJson(body);
    _branches = Branch.listFromJson(apiModel.data);
    return _branches;
  }

  List<Branch> get branches => _branches;

  Future<void> refresh() async {
    final body = await fb.apiRequest(
        'GET', 'branch/store/${fb.authStore?.selectedStoreId}');
    final ApiResponse apiModel = ApiResponse.fromRawJson(body);
    _branches = Branch.listFromJson(apiModel.data);
    ref.notifyListeners();
  }
}

typedef SelectedBranchNotifier
    = AsyncNotifierProvider<SelectedBranchProvider, Branch>;

final selectedBranchProvider = SelectedBranchNotifier(SelectedBranchProvider.new);

class SelectedBranchProvider extends AsyncNotifier<Branch> {
  late Branch _branch;
  @override
  FutureOr<Branch> build() async {
    final branches = await ref.watch(branchesProvider.future);
    if (fb.authStore?.selectedBranchId == null) {
      _branch = branches.first;
      fb.authStore?.selectedBranchId = _branch.id;
      await fb.authStore?.saveData();
    } else {
      _branch =
          branches.firstWhere((e) => e.id == fb.authStore?.selectedBranchId);
    }
    return _branch;
  }

  Branch get branch => _branch;

  Future<void> refresh() async {
    final branches = await ref.watch(branchesProvider.future);
    if (fb.authStore?.selectedBranchId == null) {
      _branch = branches.first;
      fb.authStore?.selectedBranchId = _branch.id;
      await fb.authStore?.saveData();
    } else {
      _branch =
          branches.firstWhere((e) => e.id == fb.authStore?.selectedBranchId);
    }
    ref.notifyListeners();
  }
}

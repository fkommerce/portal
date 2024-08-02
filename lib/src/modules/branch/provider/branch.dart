import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../model/contributor.dart';

import '../../../frogbase/model/api_response.dart';
import '../../../frogbase/model/auth.store.dart';
import '../../../frogbase/utils/helpers.dart';
import '../model/branch.dart';

typedef BranchNotifier = AsyncNotifierProvider<BranchProvider, Branch>;

final branchProvider = BranchNotifier(BranchProvider.new);

class BranchProvider extends AsyncNotifier<Branch> {
  late List<Branch> _branches;
  late Branch _selectedBranch;
  late Contributor _contributor;

  @override
  FutureOr<Branch> build() async {
    _branches = [];
    final branchBody = await fb.apiRequest(
      'GET',
      'branch/store/${fb.authStore?.selectedStoreId}',
    );
    final branchApiModel = ApiResponse.fromRawJson(branchBody);
    _branches = Branch.listFromJson(branchApiModel.data);
    //
    if (fb.authStore?.selectedBranchId == null) {
      _selectedBranch = branches.first;
      fb.authStore?.selectedBranchId = _selectedBranch.id;
      await fb.authStore?.saveData();
    } else {
      _selectedBranch =
          branches.firstWhere((e) => e.id == fb.authStore?.selectedBranchId);
    }
    //
    final contributorBody = await fb.apiRequest(
      'GET',
      'contributor/store/${fb.authStore?.selectedStoreId}/branch/${_selectedBranch.id}/management/${fb.authStore?.managementId}',
    );
    final contributorApiModel = ApiResponse.fromRawJson(contributorBody);
    _contributor = Contributor.fromJson(contributorApiModel.data);
    //
    return _selectedBranch;
  }

  List<Branch> get branches => _branches;

  Branch get selectedBranch => _selectedBranch;

  Contributor get contributor => _contributor;

  Future<void> refresh() async {
    final brancBbody = await fb.apiRequest(
      'GET',
      'branch/store/${fb.authStore?.selectedStoreId}',
    );
    final branchApiModel = ApiResponse.fromRawJson(brancBbody);
    _branches = Branch.listFromJson(branchApiModel.data);
    //
    if (fb.authStore?.selectedBranchId == null) {
      _selectedBranch = branches.first;
      fb.authStore?.selectedBranchId = _selectedBranch.id;
      await fb.authStore?.saveData();
    } else {
      _selectedBranch =
          branches.firstWhere((e) => e.id == fb.authStore?.selectedBranchId);
    }
    //
    final contributorBody = await fb.apiRequest(
      'GET',
      'contributor/store/${fb.authStore?.selectedStoreId}/branch/${_selectedBranch.id}/management/${fb.authStore?.managementId}',
    );
    final contributorApiModel = ApiResponse.fromRawJson(contributorBody);
    _contributor = Contributor.fromJson(contributorApiModel.data);
    //
    ref.notifyListeners();
  }
}

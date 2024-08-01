import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'branch.dart';

import '../../../frogbase/model/api_response.dart';
import '../../../frogbase/utils/helpers.dart';
import '../model/contributor.dart';

typedef ContributorsNotifier
    = AsyncNotifierProvider<ContributorsProvider, List<Contributor>>;

final contributorsProvider = ContributorsNotifier(ContributorsProvider.new);

class ContributorsProvider extends AsyncNotifier<List<Contributor>> {
  late List<Contributor> _contributors;
  @override
  FutureOr<List<Contributor>> build() async {
    _contributors = [];
    final body = await fb.apiRequest('GET',
        'contributor/store/${fb.authStore?.selectedStoreId}/management/${fb.authStore?.managementId}');
    final ApiResponse apiModel = ApiResponse.fromRawJson(body);
    _contributors = Contributor.listFromJson(apiModel.data);
    return _contributors;
  }

  List<Contributor> get contributors => _contributors;

  Future<void> refresh() async {
    final body = await fb.apiRequest('GET',
        'contributor/store/${fb.authStore?.selectedStoreId}/management/${fb.authStore?.managementId}');
    final ApiResponse apiModel = ApiResponse.fromRawJson(body);
    _contributors = Contributor.listFromJson(apiModel.data);
    ref.notifyListeners();
  }
}

typedef SelectedContributorNotifier
    = AsyncNotifierProvider<SelectedContributorProvider, Contributor>;

final selectedContributorProvider =
    SelectedContributorNotifier(SelectedContributorProvider.new);

class SelectedContributorProvider extends AsyncNotifier<Contributor> {
  late Contributor _contributor;
  @override
  FutureOr<Contributor> build() async {
    final selectedBranch = await ref.watch(selectedBranchProvider.future);
    final contributors = await ref.watch(contributorsProvider.future);
    _contributor =
        contributors.firstWhere((e) => e.branch == selectedBranch.id);
    return _contributor;
  }

  Contributor get contributor => _contributor;

  Future<void> selectContributor(String id) async {
    final selectedBranch = await ref.watch(selectedBranchProvider.future);
    final contributors = await ref.watch(contributorsProvider.future);
    _contributor =
        contributors.firstWhere((e) => e.branch == selectedBranch.id);
    ref.notifyListeners();
  }
}

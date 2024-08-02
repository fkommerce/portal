// import 'dart:async';

// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'branch.dart';

// import '../../../frogbase/model/api_response.dart';
// import '../../../frogbase/utils/helpers.dart';
// import '../model/contributor.dart';

// typedef ContributorNotifier
//     = AsyncNotifierProvider<ContributorProvider, Contributor>;

// final contributorProvider = ContributorNotifier(ContributorProvider.new);

// class ContributorProvider extends AsyncNotifier<Contributor> {
//   late List<Contributor> _contributors;
//   late Contributor _selectedContributor;
//   @override
//   FutureOr<Contributor> build() async {
//     _contributors = [];
//     final body = await fb.apiRequest(
//       'GET',
//       'contributor/store/${fb.authStore?.selectedStoreId}/management/${fb.authStore?.managementId}',
//     );
//     final ApiResponse apiModel = ApiResponse.fromRawJson(body);
//     _contributors = Contributor.listFromJson(apiModel.data);
//     //
//     final branch = await ref.watch(branchProvider.future);
//     _selectedContributor =
//         _contributors.firstWhere((e) => e.branch == branch.id);
//     //
//     return _selectedContributor;
//   }

//   List<Contributor> get contributors => _contributors;

//   Contributor get selectedContributor => _selectedContributor;

//   Future<void> refresh() async {
//     final body = await fb.apiRequest('GET',
//         'contributor/store/${fb.authStore?.selectedStoreId}/management/${fb.authStore?.managementId}');
//     final ApiResponse apiModel = ApiResponse.fromRawJson(body);
//     _contributors = Contributor.listFromJson(apiModel.data);
//     //
//     final branch = await ref.watch(branchProvider.future);
//     _selectedContributor =
//         _contributors.firstWhere((e) => e.branch == branch.id);
//     //
//     ref.notifyListeners();
//   }
// }
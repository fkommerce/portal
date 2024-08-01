import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../shared/ksnackbar/ksnackbar.dart';
import '../branch/provider/branch.dart';
import '../branch/provider/contributor.dart';
import '../../shared/riverpod/helper.dart';

import '../../config/constants.dart';
import '../../config/size.dart';
import '../../frogbase/utils/helpers.dart';
import '../../shared/internet/view/internet.dart';
import '../../utils/extensions/extensions.dart';
import '../settings/view/basic/signout_tile.dart';
import '../store/provider/store.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InternetWidget(
      child: SelectionArea(
        child: Scaffold(
          body: ref.watch(storeProvider).when(
              loading: riverpodLoading,
              error: riverpodError,
              data: (_) {
                final outterNotifier = ref.read(storeProvider.notifier);
                return ref.watch(selectedBranchProvider).when(
                    loading: riverpodLoading,
                    error: riverpodError,
                    data: (_) {
                      final middleNotifier =
                          ref.read(selectedBranchProvider.notifier);
                      return ref.watch(selectedContributorProvider).when(
                          loading: riverpodLoading,
                          error: riverpodError,
                          data: (_) {
                            final innerNotifier =
                                ref.read(selectedContributorProvider.notifier);
                            return Center(
                              child: Padding(
                                padding: const EdgeInsets.all(defaultPadding),
                                child: SingleChildScrollView(
                                  child: Column(
                                    mainAxisAlignment: mainCenter,
                                    children: [
                                      Text(
                                        'Welcome to $appName',
                                        style: context.text.bodyLarge,
                                      ),
                                      const SizedBox(height: defaultPadding),
                                      Text(
                                        'Management ID: ${fb.authStore?.managementId}',
                                        style: context.text.bodyMedium,
                                      ),
                                      const SizedBox(height: defaultPadding),
                                      Text(
                                        'Management Access Token: ${fb.authStore?.accessToken}',
                                        style: context.text.bodyMedium,
                                      ),
                                      const SizedBox(height: defaultPadding),
                                      Text(
                                        'Management Refresh Token: ${fb.authStore?.refreshToken}',
                                        style: context.text.bodyMedium,
                                      ),
                                      const SizedBox(height: defaultPadding),
                                      Text(
                                        'Store IDs: ${fb.authStore?.storeIds}',
                                        style: context.text.bodyMedium,
                                      ),
                                      const SizedBox(height: defaultPadding),
                                      Text(
                                        'Selected Store ID: ${fb.authStore?.selectedStoreId}',
                                        style: context.text.bodyMedium,
                                      ),
                                      const SizedBox(height: defaultPadding),
                                      Text(
                                        'Selected Branch ID: ${fb.authStore?.selectedBranchId}',
                                        style: context.text.bodyMedium,
                                      ),
                                      const SizedBox(
                                          height: defaultPadding * 2),
                                      Text(
                                        'Store: ${outterNotifier.store}',
                                        style: context.text.bodyMedium,
                                      ),
                                      const SizedBox(
                                          height: defaultPadding * 2),
                                      Text(
                                        'Selected Branch: ${middleNotifier.branch}',
                                        style: context.text.bodyMedium,
                                      ),
                                      const SizedBox(
                                          height: defaultPadding * 2),
                                      Text(
                                        'Contributor: ${innerNotifier.contributor}',
                                        style: context.text.bodyMedium,
                                      ),
                                      const SizedBox(
                                          height: defaultPadding * 3),
                                      ElevatedButton.icon(
                                        onPressed: () async => await showDialog(
                                          context: context,
                                          barrierDismissible: false,
                                          builder: (_) => const SignoutPopup(),
                                        ),
                                        icon: const Icon(Icons.logout),
                                        label: const Text('Sign out'),
                                      ),
                                      const SizedBox(height: defaultPadding),
                                      ElevatedButton.icon(
                                        onPressed: () async =>
                                            await KSnackbar.show(
                                          context,
                                          'This is a test message',
                                        ),
                                        icon: const Icon(Icons.show_chart),
                                        label: const Text('Show SnackBar'),
                                      ),
                                      const SizedBox(height: defaultPadding),
                                      ElevatedButton.icon(
                                        onPressed: () async =>
                                            await KSnackbar.show(
                                          context,
                                          'This is a test error message',
                                          isError: true,
                                        ),
                                        icon: const Icon(Icons.error_outline),
                                        label:
                                            const Text('Show Error SnackBar'),
                                      ),
                                      const SizedBox(
                                          height: defaultPadding * 5),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          });
                    });
              }),
        ),
      ),
    );
  }
}

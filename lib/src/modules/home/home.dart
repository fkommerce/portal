import 'package:flutter/material.dart';
import '../../frogbase/utils/helpers.dart';

import '../../config/constants.dart';
import '../../config/size.dart';
import '../../shared/internet/view/internet.dart';
import '../../utils/extensions/extensions.dart';
import '../settings/view/basic/signout_tile.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return InternetWidget(
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(defaultPadding),
            child: Column(
              mainAxisAlignment: mainCenter,
              children: [
                Text(
                  'Welcome to $appName',
                  style: context.text.bodyLarge,
                ),
                const SizedBox(height: defaultPadding),
                Text(
                  'Store ID: ${fb.authStore?.storeId}',
                  style: context.text.bodyMedium,
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}

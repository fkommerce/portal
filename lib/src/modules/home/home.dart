import 'package:flutter/material.dart';
import 'package:portal/src/config/size.dart';
import 'package:portal/src/shared/ksnackbar/ksnackbar.dart';
import '../../config/constants.dart';

import '../../shared/internet/view/internet.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return InternetWidget(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: mainCenter,
            children: [
              ElevatedButton(
                onPressed: () =>
                    KSnackbar.showSnackBar(context, 'Hello, $appName!'),
                child: const Text('Show'),
              ),
              const SizedBox(height: defaultPadding),
            ],
          ),
        ),
      ),
    );
  }
}

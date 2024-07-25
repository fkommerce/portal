import 'package:flutter/material.dart';

import '../../config/constants.dart';
import '../../config/size.dart';
import '../../shared/internet/view/internet.dart';
import '../../shared/ksnackbar/ksnackbar.dart';

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

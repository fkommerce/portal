import 'package:flutter/material.dart';
import '../../config/constants.dart';

import '../../shared/internet/view/internet.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const InternetWidget(
      child: Scaffold(
        body: Center(
          child: Text(appName),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../../shared/internet/view/internet.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const InternetWidget(
      child: Scaffold(
        body: Center(
          child: Text('Register Screen'),
        ),
      ),
    );
  }
}

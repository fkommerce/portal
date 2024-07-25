import 'dart:math';

import 'package:flutter/material.dart';

import '../../../../app.routes.dart';
import '../../../config/size.dart';
import '../../../shared/internet/view/internet.dart';
import '../../../utils/extensions/extensions.dart';
import 'components/auth_part.dart';
import 'components/intro_part.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return InternetWidget(
      child: Scaffold(
        floatingActionButton: FloatingActionButton.small(
          onPressed: () => context.beamPush(AppRoutes.settingsRoute),
          child: const Icon(Icons.settings_outlined),
        ),
        body: SafeArea(
          child: Center(
            child: Container(
              width: min(context.width, 1024),
              padding: const EdgeInsets.all(defaultPadding),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(defaultPadding),
                  child: Row(
                    children: [
                      if (context.isScreenDesktop)
                        const Expanded(child: IntroPart()),
                      if (context.isScreenDesktop)
                        const SizedBox(width: defaultPadding),
                      const Expanded(child: AuthPart()),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

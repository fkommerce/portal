import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../app.routes.dart';
import '../../config/constants.dart';
import '../../config/size.dart';
import '../../shared/internet/view/internet.dart';
import '../../utils/extensions/extensions.dart';
import '../../utils/themes/themes.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return InternetWidget(
      child: Scaffold(
        floatingActionButton: FloatingActionButton.small(
          onPressed: () => context.beamPush(AppRoutes.settingsRoute),
          child: const Icon(Icons.settings_outlined),
        ),
        body: Center(
          child: Container(
            width: min(context.width, 600),
            padding: const EdgeInsets.all(defaultPadding),
            child: Column(
              mainAxisAlignment: mainCenter,
              children: [
                Image.asset(
                  'assets/icons/banner.png',
                  width: 250,
                ),
                const SizedBox(height: defaultPadding * 2),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(defaultPadding * 1.5),
                    child: Column(
                      children: [
                        Text(
                          'Welcome back! Let\'s continue growing your business with Fkommerce.',
                          style: context.text.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w600,
                            fontSize: context.text.titleLarge?.fontSize,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: defaultPadding * 2),
                        const TextField(
                          decoration: InputDecoration(
                            labelText: 'Username',
                            hintText: 'Enter your username',
                          ),
                        ),
                        const SizedBox(height: defaultPadding),
                        const TextField(
                          decoration: InputDecoration(
                            labelText: 'Password',
                            hintText: 'Enter your password',
                          ),
                        ),
                        const SizedBox(height: defaultPadding),
                        Row(
                          children: [
                            const Expanded(
                              flex: 2,
                              child: SizedBox.shrink(),
                            ),
                            Expanded(
                              flex: 3,
                              child: ElevatedButton(
                                onPressed: () {},
                                child: const Text('Login'),
                              ),
                            ),
                            const Expanded(
                              flex: 2,
                              child: SizedBox.shrink(),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: defaultPadding * 2),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text:
                        'Haven\'t started your journey with us yet? Sign up with Fkommerce and take your business to new heights! ',
                    style: context.text.bodyMedium?.copyWith(
                      color: context.theme.primaryColor,
                      fontWeight: FontWeight.w500,
                    ),
                    children: [
                      TextSpan(
                        text: 'Click here to sign up.',
                        style: context.text.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          shadows: [
                            const Shadow(
                              color: kSecondaryColor,
                              offset: Offset(0, -1.0),
                            ),
                          ],
                          color: Colors.transparent,
                          decoration: TextDecoration.underline,
                          decorationColor: kSecondaryColor,
                          decorationThickness: 2.5,
                          decorationStyle: TextDecorationStyle.solid,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap =
                              () => context.beamPush(AppRoutes.registerRoute),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

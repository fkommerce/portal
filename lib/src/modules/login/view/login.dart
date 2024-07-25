import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../provider/login.dart';

import '../../../../app.routes.dart';
import '../../../config/constants.dart';
import '../../../config/size.dart';
import '../../../shared/internet/view/internet.dart';
import '../../../shared/keyboard_hide/keyboard_hide.dart';
import '../../../utils/extensions/extensions.dart';
import '../../../utils/themes/themes.dart';
import 'forget_password_popup.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(loginProvider);
    final notifier = ref.watch(loginProvider.notifier);
    return InternetWidget(
      child: Scaffold(
        floatingActionButton: FloatingActionButton.small(
          onPressed: () => context.beamPush(AppRoutes.settingsRoute),
          child: const Icon(Icons.settings_outlined),
        ),
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Container(
                width: min(context.width, 600),
                padding: const EdgeInsets.all(defaultPadding),
                child: Column(
                  mainAxisAlignment: mainCenter,
                  mainAxisSize: mainMin,
                  children: [
                    Image.asset(
                      'assets/icons/banner.png',
                      width: 250,
                    ),
                    const SizedBox(height: defaultPadding * 2),
                    Card(
                      child: Form(
                        key: notifier.formKey,
                        child: Padding(
                          padding: const EdgeInsets.all(defaultPadding),
                          child: Column(
                            crossAxisAlignment: crossStart,
                            mainAxisSize: mainMin,
                            children: [
                              Text(
                                'Welcome back! Let\'s continue growing your business with Fkommerce.',
                                style: context.text.titleLarge?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  top: defaultPadding * 1.5,
                                  bottom: defaultPadding / 2,
                                ),
                                child: Text(
                                  'Email Address',
                                  style: context.text.bodyLarge,
                                ),
                              ),
                              TextFormField(
                                controller: notifier.emailCntrlr,
                                decoration: const InputDecoration(
                                  hintText: 'Enter your email address',
                                ),
                                keyboardType: TextInputType.emailAddress,
                                textInputAction: TextInputAction.next,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                onFieldSubmitted: (_) async =>
                                    await notifier.submit(context),
                                validator: (v) => v == null || v.isEmpty
                                    ? 'Email is required'
                                    : !v.isEmail
                                        ? 'Valid Email is required'
                                        : null,
                                onTapOutside: (_) => hideKeyboard(context),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  top: defaultPadding,
                                  bottom: defaultPadding / 2,
                                ),
                                child: Text(
                                  'Password',
                                  style: context.text.bodyLarge,
                                ),
                              ),
                              TextFormField(
                                controller: notifier.pwdCntrlr,
                                obscureText: notifier.pwdObscure,
                                decoration: InputDecoration(
                                  hintText: 'Enter your password',
                                  suffixIcon: IconButton(
                                    icon: Icon(notifier.pwdObscure
                                        ? Icons.visibility
                                        : Icons.visibility_off),
                                    onPressed: notifier.togglePwdObscure,
                                  ),
                                ),
                                keyboardType: TextInputType.visiblePassword,
                                textInputAction: TextInputAction.next,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                onFieldSubmitted: (_) async =>
                                    await notifier.submit(context),
                                validator: (v) => v == null || v.isEmpty
                                    ? 'Password is required'
                                    : null,
                                onTapOutside: (_) => hideKeyboard(context),
                              ),
                              Container(
                                alignment: Alignment.topRight,
                                padding: const EdgeInsets.only(
                                    top: defaultPadding / 4),
                                child: TextButton(
                                  onPressed: () async => await showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (context) =>
                                        const ForgetPasswordPopup(),
                                  ),
                                  style: TextButton.styleFrom(
                                      foregroundColor: Colors.red),
                                  child: const Text('Forgot Password'),
                                ),
                              ),
                              const SizedBox(height: defaultPadding),
                              Row(
                                children: [
                                  const Expanded(child: SizedBox.shrink()),
                                  Expanded(
                                    flex: 3,
                                    child: ElevatedButton(
                                      onPressed: notifier.isSignInProcess
                                          ? null
                                          : () async =>
                                              await notifier.submit(context),
                                      child: notifier.isSignInProcess
                                          ? SpinKitThreeBounce(
                                              color: context.theme.primaryColor,
                                              size: 19.0,
                                            )
                                          : const Text('Login'),
                                    ),
                                  ),
                                  const Expanded(child: SizedBox.shrink()),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: defaultPadding),
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
                              ..onTap = () =>
                                  context.beamPush(AppRoutes.registerRoute),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

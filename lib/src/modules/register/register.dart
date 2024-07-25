import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import '../../../app.routes.dart';
import '../../config/constants.dart';
import '../../config/size.dart';
import '../../utils/extensions/extensions.dart';
import '../../utils/themes/themes.dart';

import '../../shared/internet/view/internet.dart';

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
        body: Center(
          child: Container(
            width: min(context.width, 1024),
            padding: const EdgeInsets.all(defaultPadding),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(defaultPadding),
                child: Row(
                  children: [
                    if (context.isScreenDesktop)
                      Expanded(
                        child: Column(
                          mainAxisSize: mainMin,
                          crossAxisAlignment: crossStart,
                          mainAxisAlignment: mainStart,
                          children: [
                            Image.asset(
                              'assets/icons/app-icon-1024x1024.png',
                              height: 80,
                              width: 80,
                            ),
                            const SizedBox(height: defaultPadding / 2),
                            RichText(
                              text: TextSpan(
                                text: 'Fkommerce ',
                                style: context.text.headlineSmall?.copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: context.theme.primaryColor,
                                ),
                                children: [
                                  TextSpan(
                                    text: 'Portal',
                                    style: context.text.headlineSmall?.copyWith(
                                      fontWeight: FontWeight.w500,
                                      color: kSecondaryColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: defaultPadding / 2),
                            Text(
                              'Welcome to Fkommerce! Join us today and revolutionize your business operations. Our comprehensive platform empowers you to manage product sourcing, inventory, customer relations, accounting, and more—all in one convenient place. Unlock your business potential and achieve success with Fkommerce!',
                              textAlign: TextAlign.justify,
                              style: context.text.bodyMedium?.copyWith(
                                letterSpacing: 1.0,
                              ),
                            ),
                            const SizedBox(height: defaultPadding * 2),
                            Text(
                              '- Powered & developed by Algoramming. An inhouse product of Algoramming. ©2024 All rights reserved.',
                              style: context.text.bodyMedium?.copyWith(
                                letterSpacing: 1.0,
                                fontWeight: FontWeight.w500,
                                color: context.theme.dividerColor,
                              ),
                            ),
                            const SizedBox(height: defaultPadding * 2),
                            RichText(
                              text: TextSpan(
                                text:
                                    'For any queries or assistance, contact us at ',
                                style: context.text.bodyMedium?.copyWith(
                                  color: context.theme.primaryColor,
                                  fontWeight: FontWeight.w500,
                                ),
                                children: [
                                  TextSpan(
                                    text: 'contact@algoramming.com',
                                    style: context.text.bodyMedium?.copyWith(
                                      fontWeight: FontWeight.w600,
                                      shadows: [
                                        const Shadow(
                                          color: kSecondaryColor,
                                          offset: Offset(0, -2.5),
                                        ),
                                      ],
                                      color: Colors.transparent,
                                      decoration: TextDecoration.underline,
                                      decorationColor: kSecondaryColor,
                                      decorationThickness: 2.5,
                                      decorationStyle:
                                          TextDecorationStyle.solid,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () => context
                                          .beamPush(AppRoutes.registerRoute),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: defaultPadding * 2),
                          ],
                        ),
                      ),
                    const SizedBox(width: defaultPadding * 2),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: mainMin,
                          crossAxisAlignment: crossStart,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(defaultPadding),
                              child: Row(
                                mainAxisAlignment: mainSpaceBetween,
                                children: [
                                  const SizedBox(width: 24),
                                  Text(
                                    'Register your Store',
                                    style: context.text.titleLarge?.copyWith(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  InkWell(
                                    borderRadius: borderRadius25,
                                    onTap: () =>
                                        context.beamPush(AppRoutes.loginRoute),
                                    child: const Icon(Icons.close),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                top: defaultPadding / 4,
                                bottom: defaultPadding / 2,
                              ),
                              child: Text(
                                'Store Name',
                                style: context.text.titleMedium?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            TextFormField(
                              decoration: const InputDecoration(
                                hintText: 'Enter Store Name',
                              ),
                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.next,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (v) => v == null || v.isEmpty
                                  ? 'Name name is required'
                                  : v.length < 2
                                      ? 'Name is too short'
                                      : null,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                top: defaultPadding,
                                bottom: defaultPadding / 2,
                              ),
                              child: Text(
                                'Owner Name',
                                style: context.text.titleMedium?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            TextFormField(
                              decoration: const InputDecoration(
                                hintText: 'Enter Owner Name name',
                              ),
                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.next,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (v) => v == null || v.isEmpty
                                  ? 'Name name is required'
                                  : v.length < 2
                                      ? 'Name is too short'
                                      : null,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                top: defaultPadding,
                                bottom: defaultPadding / 2,
                              ),
                              child: Text(
                                'Email Address',
                                style: context.text.titleMedium?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            TextFormField(
                              decoration: const InputDecoration(
                                hintText: 'Enter your email address',
                              ),
                              keyboardType: TextInputType.emailAddress,
                              textInputAction: TextInputAction.next,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (v) => v == null || v.isEmpty
                                  ? 'Email is required'
                                  : !v.isEmail
                                      ? 'Valid Email is required'
                                      : null,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                top: defaultPadding,
                                bottom: defaultPadding / 2,
                              ),
                              child: Text(
                                'Phone Number',
                                style: context.text.titleMedium?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            IntlPhoneField(
                              flagsButtonPadding:
                                  const EdgeInsets.only(left: 10),
                              // initialCountryCode: notifier.initialCode,
                              // onChanged: notifier.setPhone,
                              // onCountryChanged: notifier.setCountry,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              decoration: const InputDecoration(
                                hintText: 'Enter your phone number',
                              ),
                              validator: (v) {
                                debugPrint('phone number $v');
                                return (v?.number.isNullOrEmpty ?? true)
                                    ? 'Phone number is required'
                                    : null;
                              },
                              dropdownIconPosition: IconPosition.trailing,
                              pickerDialogStyle: PickerDialogStyle(
                                backgroundColor:
                                    context.theme.scaffoldBackgroundColor,
                                width: 500,
                                searchFieldPadding: const EdgeInsets.only(
                                    top: defaultPadding / 2),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                bottom: defaultPadding / 2,
                              ),
                              child: Text(
                                'Create Password',
                                style: context.text.titleMedium?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            TextFormField(
                              decoration: const InputDecoration(
                                hintText: 'Enter your password',
                                // suffixIcon: IconButton(
                                //   icon: Icon(notifier.pwdObscure
                                //       ? Icons.visibility
                                //       : Icons.visibility_off),
                                //   onPressed: notifier.togglePwdObscure,
                                // ),
                              ),
                              keyboardType: TextInputType.visiblePassword,
                              textInputAction: TextInputAction.next,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (v) => v == null || v.isEmpty
                                  ? 'Password is required'
                                  : v.trim().length < 6
                                      ? 'Password must be at least 6 characters'
                                      : null,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                top: defaultPadding,
                                bottom: defaultPadding / 2,
                              ),
                              child: Text(
                                'Confirm Password',
                                style: context.text.titleMedium?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            TextFormField(
                              // controller: notifier.pwdConfirmCntrlr,
                              // obscureText: notifier.pwdConfirmObscure,
                              decoration: const InputDecoration(
                                hintText: 'Re-enter your password',
                                // suffixIcon: IconButton(
                                //   icon: Icon(notifier.pwdConfirmObscure
                                //       ? Icons.visibility
                                //       : Icons.visibility_off),
                                //   onPressed: notifier.toggleConfirmPwdObscure,
                                // ),
                              ),
                              keyboardType: TextInputType.visiblePassword,
                              textInputAction: TextInputAction.next,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              // validator: (v) => v == null || v.isEmpty
                              //     ? 'Password is required'
                              //     : v != notifier.pwdCntrlr.text
                              //         ? 'Password does not match'
                              //         : null,
                            ),
                            const SizedBox(height: defaultPadding),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                width: double.infinity,
                                height: 50,
                                child: ElevatedButton(
                                  onPressed: () {},
                                  child: const Text('Proceed'),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(15),
                              child: Text(
                                'By click Proceed, you are indicating that you have read and agree to the Terms of Use and Privacy Policy.',
                                style: context.text.labelLarge?.copyWith(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
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

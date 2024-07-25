import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../../../../../app.routes.dart';
import '../../../../config/constants.dart';
import '../../../../config/size.dart';
import '../../../../shared/keyboard_hide/keyboard_hide.dart';
import '../../../../utils/extensions/extensions.dart';
import '../../provider/register.dart';

class AuthPart extends ConsumerWidget {
  const AuthPart({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(registerProvider);
    final notifier = ref.watch(registerProvider.notifier);
    // Locale locale = Localizations.localeOf(context);
    // final format = NumberFormat.simpleCurrency(locale: locale.toString());
    // NumberFormat.localeExists(locale.toString());
    // Localizations.maybeLocaleOf(context);
    // print("CURRENCY SYMBOL ${format.currencySymbol}"); // $
    // print("CURRENCY NAME ${format.currencyName}");
    return SingleChildScrollView(
      child: Form(
        key: notifier.formKey,
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
                    onTap: () => context.beamPush(AppRoutes.loginRoute),
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
              controller: notifier.storeNameCntrlr,
              decoration: const InputDecoration(
                hintText: 'Enter store name',
              ),
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (v) => v == null || v.isEmpty
                  ? 'Store name is required'
                  : v.length < 4
                      ? 'Store name is too short'
                      : null,
              onTapOutside: (_) => hideKeyboard(context),
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
              controller: notifier.ownerNameCntrlr,
              decoration: const InputDecoration(
                hintText: 'Enter owner name',
              ),
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (v) => v == null || v.isEmpty
                  ? 'Owner name is required'
                  : v.length < 2
                      ? 'Owner name is too short'
                      : null,
              onTapOutside: (_) => hideKeyboard(context),
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
              controller: notifier.emailCntrlr,
              decoration: const InputDecoration(
                hintText: 'Enter your email address',
              ),
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (v) => v == null || v.isEmpty
                  ? 'Email is required'
                  : !v.isEmail
                      ? 'Valid email is required'
                      : null,
              onTapOutside: (_) => hideKeyboard(context),
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
              flagsButtonPadding: const EdgeInsets.only(left: 10),
              initialCountryCode: notifier.initialCode,
              onChanged: notifier.setPhone,
              onCountryChanged: notifier.setCountry,
              decoration: const InputDecoration(
                hintText: 'Enter your phone number',
              ),
              keyboardType: TextInputType.phone,
              textInputAction: TextInputAction.next,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (v) {
                debugPrint('phone number $v');
                return (v?.number.isNullOrEmpty ?? true)
                    ? 'Phone number is required'
                    : null;
              },
              onTapOutside: (_) => hideKeyboard(context),
              dropdownIconPosition: IconPosition.trailing,
              pickerDialogStyle: PickerDialogStyle(
                backgroundColor: context.theme.scaffoldBackgroundColor,
                width: 500,
                searchFieldPadding:
                    const EdgeInsets.only(top: defaultPadding / 2),
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
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (v) => v == null || v.isEmpty
                  ? 'Password is required'
                  : v.trim().length < 6
                      ? 'Password must be at least 6 characters'
                      : null,
              onTapOutside: (_) => hideKeyboard(context),
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
              controller: notifier.pwdConfirmCntrlr,
              obscureText: notifier.pwdConfirmObscure,
              decoration: InputDecoration(
                hintText: 'Re-enter your password',
                suffixIcon: IconButton(
                  icon: Icon(notifier.pwdConfirmObscure
                      ? Icons.visibility
                      : Icons.visibility_off),
                  onPressed: notifier.toggleConfirmPwdObscure,
                ),
              ),
              keyboardType: TextInputType.visiblePassword,
              textInputAction: TextInputAction.next,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (v) => v == null || v.isEmpty
                  ? 'Password is required'
                  : v != notifier.pwdCntrlr.text
                      ? 'Password does not match'
                      : null,
              onTapOutside: (_) => hideKeyboard(context),
            ),
            const SizedBox(height: defaultPadding),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: notifier.isInProcess
                      ? null
                      : () async => await notifier.submit(context),
                  child: notifier.isInProcess
                      ? SpinKitThreeBounce(
                          color: context.theme.primaryColor,
                          size: 19.0,
                        )
                      : const Text('Proceed'),
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
    );
  }
}

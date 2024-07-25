import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/phone_number.dart';
import '../../../shared/ksnackbar/ksnackbar.dart';
import '../../../utils/extensions/extensions.dart';

import '../../../shared/show_toast/awsome_snackbar/awesome_snackbar.dart';
import '../../../shared/show_toast/awsome_snackbar/show_awesome_snackbar.dart';
import '../../../utils/logger/logger_helper.dart';
import '../../settings/provider/currency.provider.dart';

typedef RegisterNotifier
    = AutoDisposeAsyncNotifierProvider<RegisterProvider, void>;

final registerProvider = RegisterNotifier(RegisterProvider.new);

class RegisterProvider extends AutoDisposeAsyncNotifier<void> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final storeNameCntrlr = TextEditingController();
  final ownerNameCntrlr = TextEditingController();
  final emailCntrlr = TextEditingController();

  // CountryCode? countryCode;
  // final phoneCntrlr = TextEditingController();

  PhoneNumber? phoneNumber;
  Country? country;
  String? initialCode;

  final pwdCntrlr = TextEditingController();
  final pwdConfirmCntrlr = TextEditingController();
  bool pwdConfirmObscure = true;
  bool pwdObscure = true;

  bool isInProcess = false;

  @override
  FutureOr<void> build() async {
    // initialCode = WidgetsBinding.instance.platformDispatcher.locale.countryCode;
    initialCode = 'BD';
    country = countries.firstWhere((c) => c.code == initialCode);
  }

  void setPhone(PhoneNumber? pn) {
    phoneNumber = pn;
    ref.notifyListeners();
  }

  void setCountry(Country? c) {
    country = c;
    ref.notifyListeners();
  }

  void togglePwdObscure() {
    pwdObscure = !pwdObscure;
    ref.notifyListeners();
  }

  void toggleConfirmPwdObscure() {
    pwdConfirmObscure = !pwdConfirmObscure;
    ref.notifyListeners();
  }

  void clear() {
    formKey = GlobalKey<FormState>();
    storeNameCntrlr.clear();
    ownerNameCntrlr.clear();
    emailCntrlr.clear();
    pwdCntrlr.clear();
    pwdConfirmCntrlr.clear();
    pwdConfirmObscure = true;
    pwdObscure = true;
    ref.notifyListeners();
  }

  Future<void> submit(BuildContext context) async {
    if (!formKey.currentState!.validate()) return;
    if (country?.dialCode == null) {
      KSnackbar.showSnackBar(context, 'Country Code is required');
      return;
    }
    if (phoneNumber == null || (phoneNumber?.number.isNullOrEmpty ?? true)) {
      KSnackbar.showSnackBar(context, 'Phone number is required');
      return;
    }
    isInProcess = true;
    ref.notifyListeners();
    try {
      //
      final currencies = ref.read(currencyProvider.notifier).currencies;
      final currency = currencies.any((e) =>
              e.name == country?.name || e.name.contains(country?.name ?? ''))
          ? currencies.firstWhere((e) =>
              e.name == country?.name || e.name.contains(country?.name ?? ''))
          : null;
      if (currency == null) {
        isInProcess = false;
        ref.notifyListeners();
        if (!context.mounted) return;
        KSnackbar.showSnackBar(context, 'Currency not found');
        return;
      }
      //
      log.i('Store Name: ${storeNameCntrlr.text.trim()}');
      log.i('Owner Name: ${ownerNameCntrlr.text.trim()}');
      log.i('Email: ${emailCntrlr.text.trim()}');
      log.i('Phone Number: ${phoneNumber?.number}');
      log.i('Password: ${pwdCntrlr.text.trim()}');
      log.i('Country: ${country?.name}');
      log.i('Dialing Code: ${country?.dialCode}');
      log.i('Phone Number Length: ${country?.maxLength}');
      log.i('Currency Name: ${currency.shortForm}');
      log.i('Currency Symbol: ${currency.symbol}');

      await Future.delayed(const Duration(seconds: 5));
      //
      isInProcess = false;
      ref.notifyListeners();
      if (!context.mounted) return;
      context.beamUpdate();
      // clear();
    } catch (e) {
      isInProcess = false;
      ref.notifyListeners();
      if (!context.mounted) return;
      showAwesomeSnackbar(context, 'Error', e.toString(), MessageType.failure);
      return;
    }
  }
}

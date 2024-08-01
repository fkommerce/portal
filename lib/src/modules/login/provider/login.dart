import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../main.dart';
import '../../../frogbase/utils/helpers.dart';
import '../../../shared/ksnackbar/ksnackbar.dart';
import '../../../utils/extensions/extensions.dart';
import '../../../utils/logger/logger_helper.dart';
import '../api/login.dart';

typedef LoginNotifier = AutoDisposeNotifierProvider<LoginProvider, void>;

final loginProvider = LoginNotifier(LoginProvider.new);

class LoginProvider extends AutoDisposeNotifier<void> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final emailCntrlr = TextEditingController();
  final pwdCntrlr = TextEditingController();
  bool pwdObscure = true;

  bool isInProcess = false;

  @override
  void build() async {
    if (!isProduction) {
      emailCntrlr.text = 'fkommerce@algoramming.com';
      pwdCntrlr.text = '@Rahat123';
    }
  }

  void togglePwdObscure() {
    pwdObscure = !pwdObscure;
    ref.notifyListeners();
  }

  void clear() {
    formKey = GlobalKey<FormState>();
    emailCntrlr.clear();
    pwdCntrlr.clear();
    pwdObscure = true;
    ref.notifyListeners();
  }

  Future<void> submit(BuildContext context) async {
    if (!formKey.currentState!.validate()) return;
    isInProcess = true;
    ref.notifyListeners();
    //
    log.i('Email: ${emailCntrlr.text.trim()}');
    log.i('Password: ${pwdCntrlr.text.trim()}');
    //
    final res = await loginApi(context, this);
    if (!res) {
      isInProcess = false;
      ref.notifyListeners();
      return;
    }
    //
    isInProcess = false;
    ref.notifyListeners();
    if (!context.mounted) return;
    context.beamUpdate();
    clear();
  }
}

Future<void> signoutFunction(BuildContext context) async {
  try {
    await fb.signout();
    log.i('Local Storage Cleared: ${fb.authStore}');
    if (!context.mounted) return;
    context.beamUpdate();
  } catch (e) {
    debugPrint('Error: $e');
    if (!context.mounted) return;
    KSnackbar.show(context, e.toString());
  }
}

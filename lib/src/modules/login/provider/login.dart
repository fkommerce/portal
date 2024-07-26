import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../db/init.dart';
import '../../settings/model/settings_model.dart';
import '../../../shared/ksnackbar/ksnackbar.dart';

import '../../../utils/extensions/extensions.dart';
import '../../../utils/logger/logger_helper.dart';

typedef LoginNotifier = AutoDisposeNotifierProvider<LoginProvider, void>;

final loginProvider = LoginNotifier(LoginProvider.new);

class LoginProvider extends AutoDisposeNotifier<void> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final emailCntrlr = TextEditingController();
  final pwdCntrlr = TextEditingController();
  bool pwdObscure = true;

  bool isInProcess = false;

  @override
  void build() async {}

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
    await Future.delayed(const Duration(seconds: 5));
    isInProcess = false;
    ref.notifyListeners();
  }
}

Future<void> signoutFunction(BuildContext context) async {
  try {
    appSettings.storeId = null;
    appSettings.managementId = null;
    appSettings.accessToken = null;
    appSettings.refreshToken = null;
    await appSettings.saveData();
    log.i(
        'Local Storage Store Id: ${appSettings.storeId}, Management Id: ${appSettings.managementId}, Access Token: ${appSettings.accessToken}, Refresh Token: ${appSettings.refreshToken}');
    if (!context.mounted) return;
    context.beamUpdate();
  } catch (e) {
    debugPrint('Error: $e');
    if (!context.mounted) return;
    KSnackbar.showSnackBar(context, e.toString());
  }
}

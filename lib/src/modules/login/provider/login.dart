import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../utils/logger/logger_helper.dart';

import '../../../shared/show_toast/awsome_snackbar/awesome_snackbar.dart';
import '../../../shared/show_toast/awsome_snackbar/show_awesome_snackbar.dart';
import '../../../utils/extensions/extensions.dart';

typedef LoginNotifier = AutoDisposeNotifierProvider<LoginProvider, void>;

final loginProvider = LoginNotifier(LoginProvider.new);

class LoginProvider extends AutoDisposeNotifier<void> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final emailCntrlr = TextEditingController();
  final pwdCntrlr = TextEditingController();
  bool pwdObscure = true;

  bool isSignInProcess = false;

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
    isSignInProcess = true;
    ref.notifyListeners();
    //
    log.i('Email: ${emailCntrlr.text.trim()}');
    log.i('Password: ${pwdCntrlr.text.trim()}');
    //
    await Future.delayed(const Duration(seconds: 5));
    isSignInProcess = false;
    ref.notifyListeners();
  }
}

Future<void> signOut(BuildContext context, WidgetRef ref) async {
  try {
    if (!context.mounted) return;
    context.beamUpdate();
  } catch (e) {
    debugPrint('Error: $e');
    if (!context.mounted) return;
    showAwesomeSnackbar(context, 'Error', e.toString(), MessageType.failure);
  }
}

import 'package:flutter/material.dart';
import '../provider/login.dart';

import '../../../frogbase/utils/helpers.dart';
import '../../../shared/ksnackbar/ksnackbar.dart';
import '../../../utils/logger/logger_helper.dart';

Future<bool> loginApi(
  BuildContext context,
  LoginProvider notifier,
) async {
  try {
    //
    await fb.signin(
      notifier.emailCntrlr.text.trim(),
      notifier.pwdCntrlr.text.trim(),
    );
    //
    return true;
  } catch (e) {
    log.e('Management Login: $e');
    if (!context.mounted) return false;
    KSnackbar.show(context, e.toString(), isError: true);
    return false;
  }
}

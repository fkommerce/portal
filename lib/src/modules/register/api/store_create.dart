import 'package:flutter/material.dart';
import '../../../utils/extensions/extensions.dart';

import '../../../frogbase/utils/helpers.dart';
import '../../../shared/generated_string/generated_string.dart';
import '../../../shared/ksnackbar/ksnackbar.dart';
import '../../../utils/logger/logger_helper.dart';
import '../provider/register.dart';

Future<bool> signupApi(
  BuildContext context,
  RegisterProvider notifier,
) async {
  try {
    //
    await fb.signup(data: {
      'name': notifier.storeNameCntrlr.text,
      'ownerName': notifier.ownerNameCntrlr.text,
      'email': notifier.emailCntrlr.text.trim(),
      'phone': notifier.phoneNumber?.number,
      'password': notifier.pwdCntrlr.text.trim(),
      'country': notifier.country?.name,
      'countryCode': notifier.country?.code,
      'currency': notifier.country?.currencyName,
      'currencySymbol': notifier.country?.currencySymbol,
      'dialingCode': notifier.country?.dialCodeWithPlus,
      'phoneNumberLength': notifier.country?.maxLength,
      'fcmToken': getRandomString(20),
    });
    //
    notifier.clear();
    if (!context.mounted) return true;
    KSnackbar.showSnackBar(context, 'Store created successfully.');
    context.beamUpdate();
    return true;
  } catch (e) {
    log.e('Store Creation: $e');
    if (!context.mounted) return false;
    KSnackbar.showSnackBar(context, e.toString());
    return false;
  }
}

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../../config/api/helper.dart';
import '../../../db/init.dart';
import '../provider/register.dart';
import '../../settings/model/settings_model.dart';
import '../../../shared/generated_string/generated_string.dart';

import '../../../config/api/response/api_response.dart';
import '../../../shared/ksnackbar/ksnackbar.dart';
import '../../../utils/logger/logger_helper.dart';

Future<bool> createStoreApi(
  BuildContext context,
  RegisterProvider notifier,
) async {
  var request = http.Request('POST', Uri.parse('$baseUrl/store'));
  request.body = json.encode({
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
  request.headers.addAll(kHeaders);
  final response = await request.send();
  final body = await response.stream.bytesToString();
  final apiResponse = ApiResponse.fromRawJson(body);
  log.i(apiResponse);

  if (apiResponse.success) {
    appSettings.storeId = apiResponse.data['store']['id'];
    appSettings.managementId = apiResponse.data['management']['data']['id'];
    appSettings.accessToken = apiResponse.data['management']['tokens']['access-token'];
    appSettings.refreshToken = apiResponse.data['management']['tokens']['refresh-token'];
    await appSettings.saveData();
    if (!context.mounted) return true;
    KSnackbar.showSnackBar(context, apiResponse.message);
    notifier.clear();
    return true;
  } else {
    if (!context.mounted) return false;
    KSnackbar.showSnackBar(context, apiResponse.message);
    return false;
  }
}

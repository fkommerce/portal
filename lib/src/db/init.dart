import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../config/constants.dart';
import '../config/get_platform.dart';
import '../modules/settings/model/currency/currency.model.dart';
import '../modules/settings/model/settings_model.dart';
import '../utils/extensions/extensions.dart';
import '../utils/logger/logger_helper.dart';
import 'functions.dart';
import 'hive.dart';
import 'paths.dart' show appDir, initDir;

late AppSettings appSettings;

Future<void> openDB() async {
  await initDir();
  await initHiveDB();
}

Future<void> initHiveDB() async {
  try {
    await Hive.initFlutter(pt.isWeb ? null : appDir.db.path);
    HiveFuntions.registerHiveAdepters();
    await HiveFuntions.openAllBoxes();
  } catch (e) {
    log.e('Failed to initialize Hive DB: $e');
    rethrow;
  }
}

Future<void> initAppDatum() async {
  if (Boxes.appSettings.isEmpty) await appSettingsInit();
  if (Boxes.currencyProfile.isEmpty) await currencyInit();
  appSettings = Boxes.appSettings.get(appName.toCamelWord) ?? AppSettings();
  log.i('App Initiated with appSettings: ${appSettings.firstRunDateTime}');
  listenForAppConfig();
}

Future<void> appSettingsInit() async {
  final appSettings = AppSettings();
  log.i(
      'First time App Settings Initiated with ${appSettings.firstRunDateTime}');
  await appSettings.saveData();
}

Future<void> currencyInit() async {
  List<CurrencyProfile> currencies = [];
  final currenciesJson =
      await rootBundle.loadString('assets/json/currency_data.json');
  final jsonList = jsonDecode(currenciesJson) as List;
  for (final json in jsonList) {
    final curr = CurrencyProfile.fromJson(json);
    currencies.add(curr);
  }
  log.i('First time Currency Initiated with ${currencies.length} currencies');
  await currencies.saveAllData();
}

void listenForAppConfig() => Boxes.appSettings
    .watch(key: appName.toCamelWord)
    .listen((_) => appSettings =
        Boxes.appSettings.get(appName.toCamelWord) ?? AppSettings());

final appSettingStreamPd = StreamProvider<AppSettings>((_) => Boxes.appSettings
    .watch(key: appName.toCamelWord)
    .map((event) => event.value ?? AppSettings()));

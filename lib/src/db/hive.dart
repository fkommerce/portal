import 'package:hive/hive.dart' show Box, Hive;

import '../modules/settings/model/currency/currency.model.dart';
import '../modules/settings/model/locale/locale_model.dart';
import '../modules/settings/model/settings_model.dart';
import '../modules/settings/model/theme/theme_model.dart';

class Boxes {
  static Box<CurrencyProfile> currencyProfile = Hive.box<CurrencyProfile>(BoxNames.currencyProfile);
  static Box<LocaleProfile> localeProfile = Hive.box<LocaleProfile>(BoxNames.localeProfile);
  static Box<ThemeProfile> themeProfile = Hive.box<ThemeProfile>(BoxNames.themeProfile);
  static Box<AppSettings> appSettings = Hive.box<AppSettings>(BoxNames.appSettings);

  static Map<Box<dynamic>, dynamic Function(dynamic json)> get allBoxes => {
        currencyProfile: (json) => CurrencyProfile.fromJson(json),
        appSettings: (json) => AppSettings.fromJson(json),
      };
}

class BoxNames {
  static const String currencyProfile = 'currencyProfile';
  static const String localeProfile = 'localeProfile';
  static const String themeProfile = 'themeProfile';
  static const String appSettings = 'appSettings';
}

class HiveTypes {
  static const int currencyProfile = 0;
  static const int localeProfile = 1;
  static const int themeProfile = 2;
  static const int appSettings = 3;
}

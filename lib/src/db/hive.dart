import 'package:hive/hive.dart' show Box, Hive;

import '../frogbase/model/auth.store.dart';
import '../modules/settings/model/locale/locale_model.dart';
import '../modules/settings/model/settings_model.dart';
import '../modules/settings/model/theme/theme_model.dart';

class Boxes {
  static Box<LocaleProfile> localeProfile = Hive.box<LocaleProfile>(BoxNames.localeProfile);
  static Box<ThemeProfile> themeProfile = Hive.box<ThemeProfile>(BoxNames.themeProfile);
  static Box<AppSettings> appSettings = Hive.box<AppSettings>(BoxNames.appSettings);
  static Box<AuthStore> authStores = Hive.box<AuthStore>(BoxNames.authStores);

  static Map<Box<dynamic>, dynamic Function(dynamic json)> get allBoxes => {
        appSettings: (json) => AppSettings.fromJson(json),
        authStores: (json) => json as String,
      };
}

class BoxNames {
  static const String localeProfile = 'localeProfile';
  static const String themeProfile = 'themeProfile';
  static const String appSettings = 'appSettings';
  static const String authStores = 'authStores';
}

class HiveTypes {
  static const int localeProfile = 1;
  static const int themeProfile = 2;
  static const int appSettings = 3;
  static const int authStore = 4;
}

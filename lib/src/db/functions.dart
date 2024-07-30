import 'package:hive/hive.dart';

import '../frogbase/model/auth.store.dart';
import '../modules/settings/model/locale/locale_model.dart';
import '../modules/settings/model/settings_model.dart';
import '../modules/settings/model/theme/theme_model.dart';
import 'hive.dart';

class HiveFuntions {
  static void registerHiveAdepters() {
    Hive.registerAdapter(LocaleProfileAdapter());
    Hive.registerAdapter(ThemeProfileAdapter());
    Hive.registerAdapter(AppSettingsAdapter());
    Hive.registerAdapter(AuthStoreAdapter());
  }

  static Future<void> openAllBoxes() async {
    await Hive.openBox<LocaleProfile>(BoxNames.localeProfile);
    await Hive.openBox<ThemeProfile>(BoxNames.themeProfile);
    await Hive.openBox<AppSettings>(BoxNames.appSettings);
    await Hive.openBox<AuthStore>(BoxNames.authStores);
  }

  static Future<void> closeAllBoxes() async {
    await Boxes.localeProfile.close();
    await Boxes.themeProfile.close();
    await Boxes.appSettings.close();
    await Boxes.authStores.close();
  }

  static Future<void> clearAllBoxes() async {
    await Boxes.localeProfile.clear();
    await Boxes.themeProfile.clear();
    await Boxes.appSettings.clear();
    await Boxes.authStores.clear();
  }

  static Future<void> deleteAllBoxes() async {
    await Hive.deleteBoxFromDisk(BoxNames.localeProfile);
    await Hive.deleteBoxFromDisk(BoxNames.themeProfile);
    await Hive.deleteBoxFromDisk(BoxNames.appSettings);
    await Hive.deleteBoxFromDisk(BoxNames.authStores);
  }
}

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../config/constants.dart';
import '../../../db/hive.dart';
import '../../../db/init.dart';
import '../../../utils/extensions/extensions.dart';
import '../../../utils/logger/logger_helper.dart';
import '../model/settings_model.dart';

final _settingsStream = Boxes.appSettings
    .watch(key: appName.toCamelWord)
    .map((event) => event.value as AppSettings);

final settingsStreamProvider = StreamProvider((_) => _settingsStream);

typedef AppSettingsNotifier = NotifierProvider<SettingProvider, AppSettings>;

final settingsProvider = AppSettingsNotifier(SettingProvider.new);

class SettingProvider extends Notifier<AppSettings> {
  @override
  AppSettings build() => ref.watch(settingsStreamProvider).value ?? appSettings;

  Future<bool> changeInitSetting(AppSettings setting) async {
    log.i('First Time Run. Initializing...');
    // await compute(_changeInit, _Data(setting));
    await setting.saveData();
    state = setting;
    return true;
  }
}

// void _changeInit(_Data data) {
//   openDBSync(data.dir);
//   data.setting.saveSync();
// }

// class _Data {
//   _Data(this.setting);

//   final AppDir dir = appDir;
//   final AppSettings setting;
// }

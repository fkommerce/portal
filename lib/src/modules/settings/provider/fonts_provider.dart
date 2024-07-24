import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'settings_provider.dart';

typedef FontNotifier = NotifierProvider<FontProvider, String>;

final fontProvider = FontNotifier(FontProvider.new);

class FontProvider extends Notifier<String> {
  @override
  String build() => ref.watch(settingsProvider.select((v) => v.fontFamily));

  // Future<void> changeFont(String font) async {
  //   // await compute(_changeFont, _Data(ref.read(settingsProvider), font));
  //   await ref.read(settingsProvider).copyWith(fontFamily: font).saveData();
  // }
}

// void _changeFont(_Data data) {
//   openDBSync(data.dir);
//   data.setting.fontFamily = data.font;
//   data.setting.saveSync();
// }

// class _Data {
//   _Data(this.setting, this.font);

//   final AppDir dir = appDir;
//   final String font;
//   final AppSettings setting;
// }

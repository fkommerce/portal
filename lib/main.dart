import 'package:beamer/beamer.dart';
import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'src/app.dart' show App;
import 'src/config/get_platform.dart';
import 'src/db/init.dart';
import 'src/db/paths.dart';

void main() async {
  await _init();
  runApp(const ProviderScope(child: App()));
}

Future<void> _init() async {
  FlutterNativeSplash.preserve(
      widgetsBinding: WidgetsFlutterBinding.ensureInitialized());
  Beamer.setPathUrlStrategy();
  pt = PlatformInfo.getCurrentPlatformType();
  await openDB();
  await _initFastCachedImageConfig();
  configEasyLoading();
  await initAppDatum();
  await Future.delayed(const Duration(seconds: 2));
  FlutterNativeSplash.remove();
}

Future<void> _initFastCachedImageConfig() async {
  await FastCachedImageConfig.init(
    subDir: pt.isWeb ? '' : appDir.files.path,
    clearCacheAfter: const Duration(days: 30),
  );
}

void configEasyLoading() => EasyLoading.instance
  ..dismissOnTap = false
  ..userInteractions = false
  ..maskType = EasyLoadingMaskType.black
  ..toastPosition = EasyLoadingToastPosition.bottom
  ..indicatorType = EasyLoadingIndicatorType.fadingCircle;

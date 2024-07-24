import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart'
    show
        BuildContext,
        Key,
        MaterialApp,
        MediaQuery,
        TextScaler,
        ThemeData,
        Widget;
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart'
    show AppLocalizations;
import 'package:flutter_riverpod/flutter_riverpod.dart'
    show ConsumerWidget, WidgetRef;
import 'package:portal/src/modules/home/home.dart';

import '../beamer.routes.dart';
import 'config/constants.dart' show appName;
import 'config/size.dart';
import 'localization/loalization.dart'
    show localizationsDelegates, onGenerateTitle, t;
import 'modules/settings/model/locale/locale_model.dart';
import 'modules/settings/model/theme/theme_model.dart';
import 'modules/settings/provider/fonts_provider.dart';
import 'modules/settings/provider/locale_provider.dart';
import 'modules/settings/provider/performance_overlay_provider.dart';
import 'modules/settings/provider/theme_provider.dart';
import 'utils/extensions/extensions.dart';
import 'utils/logger/logger_helper.dart';
import 'utils/themes/dark/dark.theme.dart';
import 'utils/themes/light/light.theme.dart';

class App extends ConsumerWidget {
  const App({super.key = const Key(appName)});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BeamerProvider(
      routerDelegate: routerDelegate,
      child: MaterialApp.router(
        title: appName,
        theme: _themeData(context, ref),
        routerDelegate: routerDelegate,
        onGenerateTitle: onGenerateTitle,
        debugShowCheckedModeBanner: false,
        routeInformationParser: BeamerParser(),
        restorationScopeId: appName.toCamelWord,
        locale: ref.watch(localeProvider).locale,
        localizationsDelegates: localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        showPerformanceOverlay: ref.watch(performanceOverlayProvider),
        builder: EasyLoading.init(builder: (ctx, child) {
          t = AppLocalizations.of(ctx)!;
          topBarSize = ctx.padding.top;
          bottomViewPadding = ctx.padding.bottom;
          log.i('App build. Height: ${ctx.height} px, Width: ${ctx.width} px');
          return MediaQuery(
            data: ctx.mq.copyWith(
              devicePixelRatio: 1.0,
              textScaler: const TextScaler.linear(1.0),
            ),
            child: child ?? const HomeScreen(),
          );
        }),
      ),
    );
  }
}

ThemeData _themeData(BuildContext context, WidgetRef ref) {
  final theme = ref.watch(themeProvider);
  final t = theme.isSystem
      ? (context.isLightTheme ? lightTheme : darkTheme)
      : theme.isDark
          ? darkTheme
          : lightTheme;

  SystemChrome.setSystemUIOverlayStyle(
    theme.isSystem
        ? (context.isLightTheme ? lightUiConfig : darkUiConfig)
        : theme.isDark
            ? darkUiConfig
            : lightUiConfig,
  );

  final f = ref.watch(fontProvider);
  return t.copyWith(
    textTheme: t.textTheme.apply(fontFamily: f),
    primaryTextTheme: t.textTheme.apply(fontFamily: f),
  );
}

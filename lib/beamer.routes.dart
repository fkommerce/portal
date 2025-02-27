import 'package:beamer/beamer.dart'
    show
        BeamGuard,
        BeamPage,
        BeamPageType,
        BeamerDelegate,
        RoutesLocationBuilder;
import 'package:flutter/widgets.dart' show ValueKey;
import 'package:portal/src/modules/home/home.dart';
import 'package:portal/src/modules/register/register.dart';

import 'app.routes.dart';
import 'src/config/constants.dart';
import 'src/modules/login/login.dart';
import 'src/shared/page_not_found/page_not_found.dart';

// TODO: temporary variable to check if user is logged in
bool isLoggedIn = false;

final routerDelegate = BeamerDelegate(
  initialPath: AppRoutes.homeRoute,
  notFoundPage: const BeamPage(
    key: ValueKey('not-found'),
    title: 'Page not found - $appName',
    child: KPageNotFound(error: '404 - Page not found!'),
  ),
  locationBuilder: RoutesLocationBuilder(
    routes: {
      AppRoutes.homeRoute: (_, __, ___) {
        return const BeamPage(
          key: ValueKey(AppRoutes.homeRoute),
          title: appName,
          type: BeamPageType.fadeTransition,
          child: HomeScreen(),
        );
      },
      AppRoutes.loginRoute: (_, __, ___) {
        return const BeamPage(
          key: ValueKey(AppRoutes.loginRoute),
          title: 'Login - $appName',
          type: BeamPageType.fadeTransition,
          child: LoginScreen(),
        );
      },
      AppRoutes.registerRoute: (_, __, ___) {
        return const BeamPage(
          key: ValueKey(AppRoutes.registerRoute),
          title: 'Register - $appName',
          type: BeamPageType.fadeTransition,
          child: RegisterScreen(),
        );
      },
    },
  ).call,
  guards: [
    BeamGuard(
      pathPatterns: AppRoutes.allAuthRequiredRoutes,
      check: (_, __) => isLoggedIn,
      beamToNamed: (_, __, ___) => AppRoutes.loginRoute,
    ),
    BeamGuard(
      pathPatterns: [AppRoutes.loginRoute, AppRoutes.registerRoute],
      check: (_, __) => !isLoggedIn,
      beamToNamed: (_, __, ___) => AppRoutes.homeRoute,
    ),
  ],
);

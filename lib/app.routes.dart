class AppRoutes {
  ///
  static const String homeRoute = '/home';
  static const String loginRoute = '/login';
  static const String registerRoute = '/register';

  static const List<String> allRoutes = [
    homeRoute,
    loginRoute,
    registerRoute,
  ];

  static final List<String> allAuthRequiredRoutes = [...allRoutes]
    ..remove(loginRoute)
    ..remove(registerRoute);
}

part of 'theme_model.dart';

extension ThemeProfileExtension on ThemeProfile {
  String get label {
    switch (this) {
      case ThemeProfile.system:
        return 'System Default';
      case ThemeProfile.light:
        return 'Light';
      case ThemeProfile.dark:
        return 'Dark';
      default:
        return 'System Default';
    }
  }

  // ThemeData get theme {
  //   switch (this) {
  //     case ThemeProfile.system:
  //       return darkTheme;
  //     case ThemeProfile.light:
  //       return lightTheme;
  //     case ThemeProfile.dark:
  //       return darkTheme;
  //     default:
  //       return lightTheme;
  //   }
  // }

  // Color get color {
  //   switch (this) {
  //     case ThemeProfile.dark:
  //       return Colors.black;
  //     case ThemeProfile.light:
  //       return Colors.white;
  //     default:
  //       return Colors.white;
  //   }
  // }

  // SystemUiOverlayStyle get uiConfig {
  //   switch (this) {
  //     case ThemeProfile.dark:
  //       return darkUiConfig;
  //     case ThemeProfile.light:
  //       return lightUiConfig;
  //     default:
  //       return lightUiConfig;
  //   }
  // }

  // ThemeProfile get toggled =>
  //     this == ThemeProfile.light ? ThemeProfile.dark : ThemeProfile.light;

  bool get isSystem => this == ThemeProfile.system;
  bool get isLight => this == ThemeProfile.light;
  bool get isDark => this == ThemeProfile.dark;

  bool get isNotSystem => !isSystem;
  bool get isNotLight => !isLight;
  bool get isNotDark => !isDark;
}

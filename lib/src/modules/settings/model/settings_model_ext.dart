part of 'settings_model.dart';

extension SettingExtension on AppSettings {
  AppSettings copyWith({
    bool? firstRun,
    String? dateFormat,
    String? timeFormat,
    String? fontFamily,
    ThemeProfile? theme,
    String? rememberEmail,
    LocaleProfile? locale,
    String? rememberPassword,
    DateTime? firstRunDateTime,
    bool? performanceOverlayEnable,
  }) =>
      AppSettings()
        ..performanceOverlayEnable =
            performanceOverlayEnable ?? this.performanceOverlayEnable
        ..firstRunDateTime = firstRunDateTime ?? this.firstRunDateTime
        ..dateFormat = dateFormat ?? this.dateFormat
        ..timeFormat = timeFormat ?? this.timeFormat
        ..fontFamily = fontFamily ?? this.fontFamily
        ..firstRun = firstRun ?? this.firstRun
        ..locale = locale ?? this.locale
        ..theme = theme ?? this.theme;

  DateFormat get getDateFormat => DateFormat(dateFormat);

  DateFormat get getTimeFormat => DateFormat(timeFormat);

  DateFormat get getDateTimeFormat => DateFormat('$dateFormat $timeFormat');
}

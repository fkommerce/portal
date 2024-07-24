import 'package:hive/hive.dart';

import '../../../../db/hive.dart';

part 'theme_model.g.dart';
part 'theme_model_ext.dart';

@HiveType(typeId: HiveTypes.themeProfile)
enum ThemeProfile {
  @HiveField(0)
  system,
  @HiveField(1)
  light,
  @HiveField(2)
  dark,
}

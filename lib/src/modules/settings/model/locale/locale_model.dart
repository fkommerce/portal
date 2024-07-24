import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../../../../db/hive.dart';
import '../../../../localization/loalization.dart';

part 'locale_model.g.dart';
part 'locale_model_ext.dart';

@HiveType(typeId: HiveTypes.localeProfile)
enum LocaleProfile {
  @HiveField(0)
  bengali,
  @HiveField(1)
  english,
}
